import {
  CXXFile,
  CXXTYPE,
  CXXTerraNode,
  Clazz,
  Constructor,
  EnumConstant,
  Enumz,
  MemberFunction,
  MemberVariable,
  Variable,
} from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  TerraContext,
  resolvePath,
} from "@agoraio-extensions/terra-core";
import { irisApiId } from "@agoraio-extensions/terra_shared_configs";
import _ from "lodash";

const funcNeedCheckWithBaseClasses = [
  "agora::media::IAudioFrameObserver",
  "agora::rtc::IRtcEngineEventHandlerEx",
];
function isNeedCheckWithBaseClasses(clazz: Clazz): boolean {
  return funcNeedCheckWithBaseClasses.includes(clazz.fullName);
}

export interface CUDNodeOp {
  node: CXXTerraNode;
}

export interface CUDNodeDeleteConfig extends CUDNodeOp {}

function deleteOp(sourceNode: CXXTerraNode, opConfig: CUDNodeOp): boolean {
  return _.isMatch(sourceNode, opConfig.node);
}

export interface CUDNodeUpdateConfig extends CUDNodeOp {
  updated: CXXTerraNode;
}
function updateOp(sourceNode: CXXTerraNode, opConfig: CUDNodeOp): boolean {
  // https://lodash.com/docs/4.17.15#mergeWith
  function _customizer(objValue: any, srcValue: any) {
    if (_.isArray(objValue)) {
      for (let i = 0; i < srcValue.length; i++) {
        let srcValueItem = srcValue[i];

        for (let j = 0; j < objValue.length; j++) {
          let objValueItem = objValue[j];
          if (_.isMatch(objValueItem, srcValueItem)) {
            objValue[j] = _.merge(objValueItem, srcValueItem);
            break;
          }
        }
      }

      return objValue;
    }
  }

  let updateOpConfig = opConfig as CUDNodeUpdateConfig;
  if (_.isMatch(sourceNode, updateOpConfig.node)) {
    // _.merge(sourceNode, updateOpConfig.updated);
    _.mergeWith(sourceNode, updateOpConfig.updated, _customizer);
  }

  // We don't want to filter this node, but just update it.
  return false;
}

export interface CUDNodeConfig {
  deleteNodes?: CXXTerraNode[];
  updateNodes?: CUDNodeUpdateConfig[];
}

export interface CUDNodeParserArgs {
  configPath: string;
}

export default function CUDNodeParser(
  terraContext: TerraContext,
  args: CUDNodeParserArgs,
  preParseResult?: ParseResult
): ParseResult | undefined {
  let parseResult = preParseResult!;
  let configPath = resolvePath(args.configPath, terraContext.configDir);
  let config = require(configPath) as CUDNodeConfig;

  if (config.deleteNodes && config.deleteNodes.length) {
    let ops = config.deleteNodes.map((it) => {
      return {
        node: it,
      } as CUDNodeDeleteConfig;
    });
    deleteNodeInParseResult(parseResult, ops, deleteOp);
  }

  if (config.updateNodes && config.updateNodes.length) {
    deleteNodeInParseResult(parseResult, config.updateNodes, updateOp);
  }

  return parseResult;
}

function filterNodes(
  sourceNodes: any[],
  nodesToFilter: any[],
  op: (sourceNode: CXXTerraNode, opConfig: CUDNodeOp) => boolean
): CXXTerraNode[] {
  return sourceNodes.filter((it) => {
    for (let n of nodesToFilter) {
      if (op(it, n)) {
        // if the op function return true, then filter the node
        return false;
      }
    }

    return true;
  });
}

function deleteNodeInParseResult(
  originalParseResult: ParseResult,
  deleteNodes: CUDNodeOp[],
  op: (sourceNode: CXXTerraNode, opConfig: CUDNodeOp) => boolean
): ParseResult {
  // Remove nodes
  // 1. Remove CXXFile
  // 2. Remove Clazz

  let parseResult = originalParseResult;

  parseResult.nodes = filterNodes(
    parseResult.nodes,
    deleteNodes.filter((node) => node.node.__TYPE == CXXTYPE.CXXFile),
    op
  );

  parseResult.nodes.forEach((it) => {
    // Handle the parent nodes
    (it as CXXFile).nodes = filterNodes(
      (it as CXXFile).nodes,
      deleteNodes.filter((node) => node.node.__TYPE != CXXTYPE.CXXFile),
      op
    );

    // Handle the children nodes
    (it as CXXFile).nodes.forEach((it) => {
      // filter Clazz
      // filter Struct
      if (it.__TYPE == CXXTYPE.Struct || it.__TYPE == CXXTYPE.Clazz) {
        // The Struct is the sub class of Clazz
        let node = it as Clazz;

        node.constructors = filterNodes(
          node.constructors,
          deleteNodes.filter((node) => node.node.__TYPE == CXXTYPE.Constructor),
          op
        ) as Constructor[];

        node.methods = filterNodes(
          node.methods,
          deleteNodes.filter(
            (node) => node.node.__TYPE == CXXTYPE.MemberFunction
          ),
          op
        ) as MemberFunction[];
        node.methods.forEach((method) => {
          method.parameters = filterNodes(
            method.parameters,
            deleteNodes.filter((node) => node.node.__TYPE == CXXTYPE.Variable),
            op
          ) as Variable[];
        });

        node.member_variables = filterNodes(
          node.member_variables,
          deleteNodes.filter(
            (node) => node.node.__TYPE == CXXTYPE.MemberVariable
          ),
          op
        ) as MemberVariable[];
      } else if (it.__TYPE == CXXTYPE.Enumz) {
        // filter Enumz
        let node = it as Enumz;
        node.enum_constants = filterNodes(
          node.enum_constants,
          deleteNodes.filter(
            (node) => node.node.__TYPE == CXXTYPE.EnumConstant
          ),
          op
        ) as EnumConstant[];
      }
    });
  });

  return parseResult;
}

export function isNodeMatched(sourceNode: CXXTerraNode, nodeToMatch: any): boolean {
  return _.isMatch(sourceNode, nodeToMatch);
}
