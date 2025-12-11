import { SimpleTypeKind } from "@agoraio-extensions/cxx-parser";

export interface UnionFlattenMemberType {
  name: string;
  source?: string;
  is_const?: boolean;
  is_builtin_type?: boolean;
  kind: SimpleTypeKind;
  dartName?: string;
}

export interface UnionFlattenMember {
  name: string;
  dartName?: string;
  type: UnionFlattenMemberType;
}

export interface UnionFlattenConfig {
  struct: string; // fully qualified struct/class name
  members: UnionFlattenMember[];
}

// 留空意味着对所有匿名 union/struct 通用展平。如需特殊追加字段可在此配置。
const configs: UnionFlattenConfig[] = [];

export default configs;

