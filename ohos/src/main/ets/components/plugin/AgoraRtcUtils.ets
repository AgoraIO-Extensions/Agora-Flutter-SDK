import { writeIrisLog } from '@shengwang/rtc-wrapper';

enum IrisLogLevel {
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  CRITICAL = 5
}

export class AgoraLog {
  public static d(tag: string, content: string) {
    writeIrisLog(IrisLogLevel.DEBUG, `[ohos][${tag}] ${content}`)
  }

  public static i(tag: string, content: string) {
    writeIrisLog(IrisLogLevel.INFO, `[ohos][${tag}] ${content}`)
  }

  public static w(tag: string, content: string) {
    writeIrisLog(IrisLogLevel.WARN, `[ohos][${tag}] ${content}`)
  }

  public static e(tag: string, content: string) {
    writeIrisLog(IrisLogLevel.ERROR, `[ohos][${tag}] ${content}`)
  }

  public static f(tag: string, content: string) {
    writeIrisLog(IrisLogLevel.CRITICAL, `[ohos][${tag}] ${content}`)
  }
}