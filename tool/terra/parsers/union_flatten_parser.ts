import {
  CXXFile,
  CXXTYPE,
  Clazz,
  MemberVariable,
  SimpleType,
  SimpleTypeKind,
} from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  TerraContext,
  resolvePath,
} from "@agoraio-extensions/terra-core";
import { toDartStyleNaming } from "./dart_syntax_parser";
import unionFlattenConfigs, {
  UnionFlattenConfig,
  UnionFlattenMember,
} from "../configs/union_flatten.config";
import fs from "fs";
import path from "path";

const dartUserDataKey = "DartSyntaxParser";

export interface UnionFlattenParserArgs {
  configPath?: string;
}

export default function UnionFlattenParser(
  terraContext: TerraContext,
  args: UnionFlattenParserArgs,
  preParseResult?: ParseResult
): ParseResult | undefined {
  let parseResult = preParseResult!;
  let config = unionFlattenConfigs as UnionFlattenConfig[];

  if (args.configPath) {
    const configPath = resolvePath(args.configPath, terraContext.configDir);
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    const loaded = require(configPath);
    config = (loaded?.default ?? loaded) as UnionFlattenConfig[];
  }

  if (config && config.length > 0) {
    applyConfigFlatten(parseResult, config);
  } else {
    flattenAnonymousUnions(parseResult, terraContext);
  }

  return parseResult;
}

function buildMemberVariable(member: UnionFlattenMember): MemberVariable {
  const type = {
    __TYPE: CXXTYPE.SimpleType,
    is_builtin_type: member.type.is_builtin_type ?? false,
    is_const: member.type.is_const ?? false,
    kind: member.type.kind,
    name: member.type.name,
    source: member.type.source ?? member.type.name,
    template_arguments: [],
    clang_qualtype: member.type.source ?? member.type.name,
    user_data: {
      [dartUserDataKey]: {
        dartName:
          member.type.dartName ??
          toDartStyleNaming(trimNamespace(member.type.name)),
      },
    },
  } as unknown as SimpleType;

  const mv: MemberVariable = {
    __TYPE: CXXTYPE.MemberVariable,
    name: member.name,
    type,
    user_data: {
      [dartUserDataKey]: {
        dartName: member.dartName ?? toDartStyleNaming(member.name),
      },
    },
  } as MemberVariable;

  return mv;
}

function trimNamespace(name: string): string {
  return name.includes("::") ? name.split("::").pop()! : name;
}

function applyConfigFlatten(parseResult: ParseResult, config: UnionFlattenConfig[]) {
  (config ?? []).forEach((item) => {
    const targetNode = parseResult.resolveNodeByName(item.struct);
    if (!targetNode) {
      return;
    }

    if (
      targetNode.__TYPE != CXXTYPE.Clazz &&
      targetNode.__TYPE != CXXTYPE.Struct
    ) {
      return;
    }

    const structNode = targetNode as Clazz;
    item.members.forEach((member) => {
      if (structNode.member_variables.find((mv) => mv.name === member.name)) {
        return;
      }

      const newMember = buildMemberVariable(member);
      structNode.member_variables.push(newMember);
    });
  });
}

function flattenAnonymousUnions(
  parseResult: ParseResult,
  terraContext?: TerraContext
) {
  const clangUnionMap = loadClangUnionFields(parseResult, terraContext);
  const files = parseResult.nodes as CXXFile[];

  files.forEach((file) => {
    file.nodes.forEach((node) => {
      if (
        node.__TYPE == CXXTYPE.Clazz ||
        node.__TYPE == CXXTYPE.Struct
      ) {
        const clazz = node as Clazz;
        clazz.member_variables = flattenMembers(
          parseResult,
          clazz,
          clazz.member_variables,
          clangUnionMap
        );
      }
    });
  });
}

function flattenMembers(
  parseResult: ParseResult,
  parent: Clazz,
  members: MemberVariable[],
  clangUnionMap: Map<string, ClangUnionField[]>
): MemberVariable[] {
  const result: MemberVariable[] = [];

  members.forEach((mv) => {
    const typeNode = parseResult.resolveNodeByType(mv.type);
    const isAnonStructOrUnion =
      typeNode &&
      (typeNode.__TYPE == CXXTYPE.Clazz || typeNode.__TYPE == CXXTYPE.Struct) &&
      typeNode.name.trim().length === 0 &&
      (typeNode as Clazz).member_variables?.length;

    if (isAnonStructOrUnion) {
      (typeNode as Clazz).member_variables.forEach((childMv) => {
        const cloned = cloneMemberVariable(childMv);
        if (!result.find((it) => it.name === cloned.name)) {
          result.push(cloned);
        }
      });
    } else {
      result.push(mv);
    }
  });

  // 补充来自 clang AST 的 union 字段（cxx-parser 不会保留 union）
  const unionFields = clangUnionMap.get(parent.name.trimNamespace()) ?? [];
  unionFields.forEach((uf) => {
    if (!result.find((it) => it.name === uf.name)) {
      result.push(buildMemberFromClangField(uf));
    }
  });

  return result;
}

function cloneMemberVariable(mv: MemberVariable): MemberVariable {
  const type = mv.type as SimpleType;
  const clonedType = {
    ...type,
    template_arguments: (type as any).template_arguments ?? [],
    clang_qualtype: (type as any).clang_qualtype ?? type.source ?? type.name,
    user_data: { ...(type.user_data ?? {}) },
  } as unknown as SimpleType;
  clonedType.user_data![dartUserDataKey] ??= {};
  clonedType.user_data![dartUserDataKey].dartName ??= toDartStyleNaming(
    trimNamespace(type.name)
  );

  const cloned: MemberVariable = {
    ...mv,
    type: clonedType,
    user_data: { ...(mv.user_data ?? {}) },
  } as MemberVariable;
  cloned.user_data![dartUserDataKey] ??= {};
  cloned.user_data![dartUserDataKey].dartName ??= toDartStyleNaming(mv.name);

  return cloned;
}

interface ClangUnionField {
  parent: string;
  name: string;
  qualType: string;
}

// 从 clang ast dump 中提取 union 字段
function loadClangUnionFields(parseResult: ParseResult, terraContext?: TerraContext): Map<string, ClangUnionField[]> {
  const out = new Map<string, ClangUnionField[]>();
  const baseDir = path.resolve(
    terraContext?.configDir ?? process.cwd(),
    ".terra/cxx_parser"
  );
  let files: string[] = [];
  try {
    files = fs
      .readdirSync(baseDir)
      .filter((f) => f.startsWith("dump_clang_ast_") && f.endsWith(".json"))
      .map((f) => path.join(baseDir, f));
  } catch (e) {
    return out;
  }

  files.forEach((file) => {
    let data: any;
    try {
      data = JSON.parse(fs.readFileSync(file, "utf-8"));
    } catch (e) {
      return;
    }
    const stack: any[] = [data];
    while (stack.length) {
      const node = stack.pop();
      if (Array.isArray(node)) {
        stack.push(...node);
      } else if (node && typeof node === "object") {
        const isRecord =
          (node.kind === "RecordDecl" || node.kind === "CXXRecordDecl") &&
          node.name;
        if (isRecord) {
          const parentName = node.name as string;
          const inner = Array.isArray(node.inner) ? node.inner : [];
          inner.forEach((child: any) => {
            const isUnion =
              child &&
              typeof child === "object" &&
              (child.tagUsed === "union" ||
                child.kind === "RecordDecl" ||
                child.kind === "CXXRecordDecl") &&
              child.tagUsed === "union";
            if (isUnion) {
              const unionInner = Array.isArray(child.inner) ? child.inner : [];
              unionInner.forEach((u: any) => {
                if (u?.kind === "FieldDecl") {
                  const field: ClangUnionField = {
                    parent: parentName,
                    name: u.name,
                    qualType: u.type?.qualType ?? "",
                  };
                  const list = out.get(parentName) ?? [];
                  list.push(field);
                  out.set(parentName, list);
                }
              });
            }
          });
        }
        Object.values(node).forEach((v) => {
          if (v && (Array.isArray(v) || typeof v === "object")) {
            stack.push(v);
          }
        });
      }
    }
  });

  return out;
}

function buildMemberFromClangField(field: ClangUnionField): MemberVariable {
  const isPointer = field.qualType.includes("*");
  const isConst = field.qualType.trim().startsWith("const ");
  const baseName = trimNamespace(
    field.qualType
      .replace(/^const\s+/, "")
      .replace(/\s*\*+$/, "")
      .trim()
  );
  let dartTypeName = toDartStyleNaming(baseName, true);
  if (baseName === "char" && isPointer) {
    dartTypeName = "String";
  }

  const simpleType = {
    __TYPE: CXXTYPE.SimpleType,
    is_builtin_type: isBuiltin(baseName),
    is_const: isConst,
    kind: isPointer ? SimpleTypeKind.pointer_t : SimpleTypeKind.value_t,
    name: baseName,
    source: field.qualType,
    template_arguments: [],
    clang_qualtype: field.qualType,
    user_data: {
      [dartUserDataKey]: {
        dartName: dartTypeName,
      },
    },
  } as unknown as SimpleType;

  const mv: MemberVariable = {
    __TYPE: CXXTYPE.MemberVariable,
    name: field.name,
    type: simpleType,
    user_data: {
      [dartUserDataKey]: {
        dartName: toDartStyleNaming(field.name),
      },
    },
  } as MemberVariable;

  return mv;
}

function isBuiltin(typeName: string): boolean {
  const builtins = [
    "char",
    "int",
    "float",
    "double",
    "short",
    "long",
    "bool",
    "void",
  ];
  return builtins.includes(typeName);
}

