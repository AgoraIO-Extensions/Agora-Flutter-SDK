import { CXXFile, CXXTYPE, Clazz } from "@agoraio-extensions/cxx-parser";
import {
  ParseResult,
  RenderResult,
  TerraContext,
} from "@agoraio-extensions/terra-core";
import { isCallbackClass } from "./utils";
import { dartFileName } from "../parsers/dart_syntax_parser";

/// Generate the files:
/// - lib/src/binding_forward_export.dart
/// - lib/src/binding/impl_forward_export.dart
export default function ForwardExportRenderer(
  terraContext: TerraContext,
  args: any,
  parseResult: ParseResult
): RenderResult[] {
  let cxxFiles = parseResult!.nodes as CXXFile[];
  let bindingExportFiles: string[] = [];
  let implExportFiles: string[] = [];
  cxxFiles.forEach((cxxFile: CXXFile) => {
    bindingExportFiles.push(`export '/src/${dartFileName(cxxFile)}.dart';`);

    let hasImplClass = cxxFile.nodes.find((node) => {
      return node.__TYPE == CXXTYPE.Clazz && !isCallbackClass(node as Clazz);
    });
    let hasCallbackImplClass = cxxFile.nodes.find((node) => {
      return node.__TYPE == CXXTYPE.Clazz && isCallbackClass(node as Clazz);
    });
    if (hasImplClass) {
      implExportFiles.push(`export '/src/binding/${dartFileName(cxxFile)}_impl.dart';`);
    }
    if (hasCallbackImplClass) {
      implExportFiles.push(
        `export '/src/binding/${dartFileName(cxxFile)}_event_impl.dart';`
      );
    }
  });

  // lib/src/binding_forward_export.dart
  let bindingExport = `
${bindingExportFiles.join("\n")}
export '/src/agora_rtc_engine_ext.dart';
export '/src/impl/json_converters.dart';
export 'dart:convert';
export 'dart:typed_data';
export 'package:json_annotation/json_annotation.dart';
export 'package:flutter/foundation.dart';
`;

  // lib/src/binding/impl_forward_export.dart
  let implExport = `
${implExportFiles.join("\n")}
export '/src/binding/event_handler_param_json.dart';
export '/src/binding/call_api_impl_params_json.dart';
export '/src/binding/call_api_event_handler_buffer_ext.dart';
`;

  return [
    {
      file_name: "lib/src/binding_forward_export.dart",
      file_content: bindingExport,
    },

    {
      file_name: "lib/src/binding/impl_forward_export.dart",
      file_content: implExport,
    },
  ];
}
