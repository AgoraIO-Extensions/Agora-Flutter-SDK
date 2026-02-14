import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'agora_log.g.dart';

/// Log output level.
@JsonEnum(alwaysCreate: true)
enum LogLevel {
  /// 0: Do not output any logs.
  @JsonValue(0x0000)
  logLevelNone,

  /// 0x0001: (Default) Outputs logs of levels FATAL, ERROR, WARN, and INFO. It is recommended to set the log level to this level.
  @JsonValue(0x0001)
  logLevelInfo,

  /// 0x0002: Outputs only logs of levels FATAL, ERROR, and WARN.
  @JsonValue(0x0002)
  logLevelWarn,

  /// 0x0004: Outputs only logs of levels FATAL and ERROR.
  @JsonValue(0x0004)
  logLevelError,

  /// 0x0008: Outputs only logs of level FATAL.
  @JsonValue(0x0008)
  logLevelFatal,

  /// @nodoc
  @JsonValue(0x0010)
  logLevelApiCall,

  /// @nodoc
  @JsonValue(0x0020)
  logLevelDebug,
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

/// Log filter level.
@JsonEnum(alwaysCreate: true)
enum LogFilterType {
  /// 0: No log output.
  @JsonValue(0)
  logFilterOff,

  /// 0x080f: Outputs all API log information. Set the log level to this for the most complete logs.
  @JsonValue(0x080f)
  logFilterDebug,

  /// 0x000f: Outputs logs at logFilterCritical, logFilterError, logFilterWarn, and logFilterInfo levels. Recommended log level.
  @JsonValue(0x000f)
  logFilterInfo,

  /// 0x000e: Outputs logs at logFilterCritical, logFilterError, and logFilterWarn levels.
  @JsonValue(0x000e)
  logFilterWarn,

  /// 0x000c: Outputs logs at logFilterCritical and logFilterError levels.
  @JsonValue(0x000c)
  logFilterError,

  /// 0x0008: Outputs logs at logFilterCritical level only.
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

/// Configuration of SDK log files.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LogConfig implements AgoraSerializable {
  /// @nodoc
  const LogConfig({this.filePath, this.fileSizeInKB, this.level});

  /// Full path of the log file. Agora recommends using the default log path. If you need to change the default log path, make sure the specified path exists and is writable.
  @JsonKey(name: 'filePath')
  final String? filePath;

  /// Size of a single agorasdk.log log file, in KB. The range is [128, 20480], and the default value is 2,048 KB. If you set fileSizeInKByte to less than 128 KB, the SDK automatically adjusts it to 128 KB; if you set it to more than 20,480 KB, the SDK automatically adjusts it to 20,480 KB.
  @JsonKey(name: 'fileSizeInKB')
  final int? fileSizeInKB;

  /// Log output level of the SDK. See LogLevel.
  /// For example, if you choose the WARN level, you will see all log messages at FATAL, ERROR, and WARN levels.
  @JsonKey(name: 'level')
  final LogLevel? level;

  /// @nodoc
  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}
