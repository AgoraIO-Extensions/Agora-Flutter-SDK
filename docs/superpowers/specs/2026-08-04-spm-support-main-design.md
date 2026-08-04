# Agora Flutter SDK main 分支 SPM 实验版设计

## 目标

在不改变现有 CocoaPods 消费路径的前提下，让 `main` 分支的 iOS 和 macOS Flutter 插件能够通过 Flutter 新版 Swift Package Manager 集成完成依赖解析和无签名构建。同时让依赖更新脚本能够显式维护 SPM 版本、binary artifact URL 与 checksum，避免 `Package.swift` 再次长期停留在旧版本。

本次结果是可编译实验版，不作为正式发布就绪声明。原因是 CocoaPods 使用的 Special Native `4.6.2.70` 与公开 Native SPM tag `4.6.2` 尚未证明产物一致。

## 范围

- 基线：`origin/main@5f980f8f`。
- 分支：`codex/spm-support-main`。
- iOS 和 macOS 的 `Package.swift`。
- `ci/run_update_deps.sh` 的 SPM 更新能力及其回归测试。
- `test_shard/integration_test_swiftpm` 的构建断言和最小 SDK 初始化覆盖。
- `/Users/zhugaopeng/Downloads/flutter-special-sdk-release-request/flutter-SKILL_副本.md` 的 SPM 产物、审批和发布规则。

不包含：移除 CocoaPods、修改公开 Dart API、发布 Native/Iris SPM 产物、修改 JenkinsHelper 上传链路、声称 Special CocoaPods 与公开 SPM 二进制等价。

## 依赖策略

### Flutter

两个 plugin manifest 都增加 Flutter `3.44.8` 官方模板要求的本地 package：`.package(name: "FlutterFramework", path: "../FlutterFramework")`，并让 plugin target 依赖 `.product(name: "FlutterFramework", package: "FlutterFramework")`。

### Native SDK

实验版把 iOS 和 macOS Native package 精确锁定为 `4.6.2`，不再使用 `.upToNextMajor(from:)`。这样依赖更新不会在未审查时自动跨补丁版本变化。

默认继续使用现有 `RtcBasic` product。只有 SPM 构建产生明确缺失符号证据时，才增加其他 Native products，并在设计范围内记录原因。

### Iris

Iris 继续作为 `AgoraRtcWrapper` binary target。候选 iOS/macOS `4.6.2-build.1` artifact 必须逐项验证：

1. URL 可下载且不是重定向错误页。
2. zip 根目录直接包含 `AgoraRtcWrapper.xcframework/`。
3. `swift package compute-checksum` 与 manifest 中的 checksum 一致。
4. xcframework 包含目标平台需要的 slices。

任何一项失败，都停止把该平台标记为 SPM 可发布；不使用 CocoaPods 版本号猜测 URL 或 checksum。

## Manifest 改动

iOS 和 macOS manifest 保持同一结构：

- `swift-tools-version` 保持 `5.9`。
- 增加本地 `FlutterFramework` package dependency。
- Native SDK 使用 exact version。
- target dependencies 包含 `FlutterFramework`、`RtcBasic` 和 `AgoraRtcWrapper`。
- Iris URL/checksum 更新为已验证值。
- macOS 删除 `.unsafeFlags(["-std=c++14"])`，改为 package 级 `cxxLanguageStandard: .cxx14`。
- 保留现有平台最低版本和已存在的 linker settings。

## 依赖更新数据流

参考 `AgoraIO-Extensions/agora-cocos-rtc` 的依赖更新模式：workflow 保留一个可粘贴 release note 内容的 `dependencies_content` 输入，由仓库内可测试的 Node 解析器提取 SPM 信息，完成更新后再执行统一验证和创建 PR。

Cocos 仓库实际更新的是 `sdk/agora-rtc/sdk-config.json`，并不直接维护 `Package.swift`。Flutter 仓库不新增一份重复配置；两份已提交的 `Package.swift` 继续是最终 manifest，解析器只负责对其中稳定、明确的依赖字段做原子更新。

原始输入按平台分块，避免 iOS/macOS 和 Native/Iris 之间产生歧义：

```text
platform:iOS github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2 products:RtcBasic iris-url:https://download.agora.io/sdk/release/AgoraIrisRTC_iOS2-4.6.2-build.1.zip iris-checksum:eba8f9fc5b3d93d9d083d0c3f16e6c98fcd993e49989fb851e6df2941ca29825
platform:macOS github:https://github.com/AgoraIO/AgoraRtcEngine_macOS.git tag:4.6.2 products:RtcBasic iris-url:https://download.agora.io/sdk/release/AgoraIrisRTC_macOS2-4.6.2-build.1.zip iris-checksum:dbfe2db86b0cb2c1012202212248bd6588173020c357dc13fc5a6dcf0a7b97cf
```

新增无第三方 npm 依赖的 Node `.mjs` 解析器，复用 Cocos 已验证的规则：

- GitHub source 识别 `https` 和 `git@github.com:` 两种形式，并规范化为 `https` URL。
- Native version 必须带 `tag:` 或 `version:` 标签，不能从 Maven/CocoaPods 版本猜测。
- products 必须带 `products:` 标签，允许未来新增 product 名称，不在解析器中硬编码白名单。
- Iris URL 和 checksum 必须使用显式标签，并与同一 platform 块绑定。
- 输入顺序和空格可以变化，但平台标签及关键字段不能含糊。

iOS 和 macOS 分别更新自己的 manifest。脚本遵循以下规则：

- 某个平台的 source、tag、products、Iris URL 和 checksum 完整时，原子更新对应 `Package.swift`。
- 只有部分 SPM 元数据时直接失败，并列出缺失字段。
- 完全没有平台化 SPM 内容时，现有 `ci/run_update_deps.sh` 继续兼容旧调用，仅更新 CocoaPods/Maven/CDN，同时明确输出 `SPM dependencies unchanged`。
- Native exact version、products、Iris URL 和 checksum 必须一起进入 review diff。
- `.github/workflows/run_update_deps.yml` 在现有依赖更新后调用该解析器，并在创建 PR 前执行解析器测试与 `swift package dump-package`。

现有 `AgoraIO-Extensions/actions/.../dep` 仍负责 Maven/CocoaPods/CDN 的平台化解析；SPM 更新直接使用 workflow 的原始输入，不依赖外部 action 是否认识新增字段。

## 测试与验收

### 脚本测试

参照 Cocos 的 `tests/update-native-deps.test.ts`，新增基于 Node 内置 `node:test` 的回归测试，至少覆盖：

- iOS/macOS CocoaPods 与 SPM 同时更新成功。
- 缺失 checksum 等部分元数据时失败且不留下半更新文件。
- 旧格式输入继续只更新原平台依赖。
- 特殊版本与 SPM exact version 可不同，脚本不会自行截断或猜测。
- `https`/SSH GitHub source、输入乱序、不同空格和重复字段。
- product 名称不会从 URL 或其他依赖文本中被误识别。

### Manifest 验证

- 对两个目录分别运行 `swift package dump-package`。
- 对下载的 Iris zip 运行 `swift package compute-checksum` 并比较。
- 检查 dependency identity、product 和 binary target 均存在。

### Flutter 构建

使用隔离的 Flutter `3.44.8`，不升级机器默认 Flutter `3.24.5`：

- `flutter pub get`
- `flutter build ios --no-codesign`
- `flutter build macos`

构建前确认生成的 Xcode project 使用 `FlutterGeneratedPluginSwiftPackage`，并检查解析结果实际指向本地 plugin `Package.swift`。测试应用增加最小的 `createAgoraRtcEngine`/初始化调用，使验证覆盖链接和插件注册，而不只是空 Flutter 页面。

### 兼容性回归

- 根包现有 `flutter test` 必须继续通过。
- CocoaPods 示例构建路径保持可用，SPM 支持不能通过删除 podspec 或 Podfile 实现。

## SKILL 更新

发布 skill 增加 Apple SPM 关联产物模型：

- Native SPM repository、exact version/tag 和 products。
- Iris binary URL、checksum、xcframework 根结构和 slices。
- iOS/macOS CocoaPods 与 SPM 的版本一致性结果。
- 缺失或不一致时的阻断规则。

`base_branch` 仍是分支真值。只有 CocoaPods 和 SPM 两条 Apple 消费路径的必需产物都已确认，才允许描述为“Apple SPM 可发布”；否则只能描述为实验、部分平台或未确认。

## 风险与退出条件

- 公开 Native `4.6.2` 与 Special `4.6.2.70` 不等价：实验构建成功也不能替代二进制一致性验证。
- Iris artifact 结构不满足 SwiftPM：需要在 JenkinsHelper/Iris 发布链路增加重打包与 checksum，本仓库不伪造临时发布物。
- Flutter `3.44.8` 模板或生成路径变化：以实际生成工程为准更新本地 package path，并保留构建证据。
- TestFlight/static linking 可能丢失通过 `DynamicLibrary.process()` 查找的 Iris symbols：本次至少做无签名 debug/release 链接验证；archive/TestFlight 验证仍是正式发布前的独立门槛。
