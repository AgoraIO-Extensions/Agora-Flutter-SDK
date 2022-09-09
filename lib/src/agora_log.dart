import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_log.g.dart';

/// 日志输出等级。
///
@JsonEnum(alwaysCreate: true)
enum LogLevel {
  /// 0: 不输出任何日志。
  @JsonValue(0x0000)
  logLevelNone,

  /// 0x0001:（默认）输出 FATAL、ERROR、WARN、INFO 级别的日志。我们推荐你将日志级别设为该等级。
  @JsonValue(0x0001)
  logLevelInfo,

  /// 0x0002: 仅输出 FATAL、ERROR、WARN 级别的日志。
  @JsonValue(0x0002)
  logLevelWarn,

  /// 0x0004: 仅输出 FATAL、ERROR 级别的日志。
  @JsonValue(0x0004)
  logLevelError,

  /// 0x0008: 仅输出 FATAL 级别的日志。
  @JsonValue(0x0008)
  logLevelFatal,

  /// @nodoc
  @JsonValue(0x0010)
  logLevelApiCall,
}

/// @nodoc
extension LogLevelExt on LogLevel {
  /// @nodoc
  static LogLevel fromValue(int value) {
    return $enumDecode(_$LogLevelEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LogLevelEnumMap[this]!;
  }
}

/// 日志过滤等级。
///
@JsonEnum(alwaysCreate: true)
enum LogFilterType {
  /// 0: 不输出日志信息。
  @JsonValue(0)
  logFilterOff,

  /// 0x080f: 输出所有 API 日志信息。如果你想获取最完整的日志，可以将日志级别设为该等级。
  @JsonValue(0x080f)
  logFilterDebug,

  /// 0x000f: 输出 logFilterCritical、logFilterError、logFilterWarn 和 logFilterInfo 级别的日志信息。我们推荐你将日志级别设为该等级。
  @JsonValue(0x000f)
  logFilterInfo,

  /// 0x000e: 输出 logFilterCritical、logFilterError 和 logFilterWarn 级别的日志信息。
  @JsonValue(0x000e)
  logFilterWarn,

  /// 0x000c: 输出 logFilterCritical 和 logFilterError 级别的日志信息。
  @JsonValue(0x000c)
  logFilterError,

  /// 0x0008: 输出 logFilterCritical 级别的日志信息。
  @JsonValue(0x0008)
  logFilterCritical,

  /// @nodoc
  @JsonValue(0x80f)
  logFilterMask,
}

/// @nodoc
extension LogFilterTypeExt on LogFilterType {
  /// @nodoc
  static LogFilterType fromValue(int value) {
    return $enumDecode(_$LogFilterTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$LogFilterTypeEnumMap[this]!;
  }
}

/// @nodoc
const maxLogSize = 20 * 1024 * 1024;

/// @nodoc
const minLogSize = 128 * 1024;

/// @nodoc
const defaultLogSizeInKb = 1024;

/// Agora SDK 日志文件的配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LogConfig {
  /// @nodoc
  const LogConfig({this.filePath, this.fileSizeInKB, this.level});

  /// 日志文件的完整路径。请确保你指定的目录存在且可写。你可以通过该参数修改日志文件名。
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// 单个 agorasdk.log 日志文件的大小，单位为 KB，取值范围为 [128,1024]，默认值为 1,024 KB。 如果你将 fileSizeInKByte 设为小于 128 KB，SDK 会自动调整到 128 KB；如果你将 fileSizeInKByte 设为大于 1,024 KB，SDK 会自动调整到 1,024 KB。
  @JsonKey(name: 'fileSizeInKB')
  final int? fileSizeInKB;

  /// Agora SDK 的日志输出等级，详见 LogLevel 。例如，如果你选择 WARN 级别，就可以看到在 FATAL、ERROR 和 WARN 级别上的所有日志信息。
  @JsonKey(name: 'level')
  final LogLevel? level;

  /// @nodoc
  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}
