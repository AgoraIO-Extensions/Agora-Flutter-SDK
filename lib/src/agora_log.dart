import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_log.g.dart';

/// The output log level of the SDK.
@JsonEnum(alwaysCreate: true)
enum LogLevel {
  /// 0: Do not output any log information.
  @JsonValue(0x0000)
  logLevelNone,

  /// 0x0001: (Default) Output FATAL, ERROR, WARN, and INFO level log information. We recommend setting your log filter to this level.
  @JsonValue(0x0001)
  logLevelInfo,

  /// 0x0002: Output FATAL, ERROR, and WARN level log information.
  @JsonValue(0x0002)
  logLevelWarn,

  /// 0x0004: Output FATAL and ERROR level log information.
  @JsonValue(0x0004)
  logLevelError,

  /// 0x0008: Output FATAL level log information.
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

/// The output log level of the SDK.
@JsonEnum(alwaysCreate: true)
enum LogFilterType {
  /// 0: Do not output any log information.
  @JsonValue(0)
  logFilterOff,

  /// 0x080f: Output all log information. Set your log filter to this level if you want to get the most complete log file.
  @JsonValue(0x080f)
  logFilterDebug,

  /// 0x000f: Output logFilterCritical, logFilterError, logFilterWarn, and logFilterInfo level log information. We recommend setting your log filter to this level.
  @JsonValue(0x000f)
  logFilterInfo,

  /// 0x000e: Output logFilterCritical, logFilterError, and logFilterWarn level log information.
  @JsonValue(0x000e)
  logFilterWarn,

  /// 0x000c: Output logFilterCritical and logFilterError level log information.
  @JsonValue(0x000c)
  logFilterError,

  /// 0x0008: Output logFilterCritical level log information.
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
const defaultLogSizeInKb = 2048;

/// Configuration of Agora SDK log files.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LogConfig {
  /// @nodoc
  const LogConfig({this.filePath, this.fileSizeInKB, this.level});

  /// The complete path of the log files. Agora recommends using the default log directory. If you need to modify the default directory, ensure that the directory you specify exists and is writable.
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// The size (KB) of an agorasdk.log file. The value range is [128,20480]. The default value is 2,048 KB. If you set fileSizeInKByte smaller than 128 KB, the SDK automatically adjusts it to 128 KB; if you set fileSizeInKByte greater than 20,480 KB, the SDK automatically adjusts it to 20,480 KB.
  @JsonKey(name: 'fileSizeInKB')
  final int? fileSizeInKB;

  /// The output level of the SDK log file. See LogLevel. For example, if you set the log level to WARN, the SDK outputs the logs within levels FATAL, ERROR, and WARN.
  @JsonKey(name: 'level')
  final LogLevel? level;

  /// @nodoc
  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}
