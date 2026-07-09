# 25307186-opensource-final-work

《开源软件开发技术》课程大作业：使用 **DevEco Studio + HarmonyOS ArkTS** 开发的一个小型应用 —— **开源学习助手**。

## 项目简介

开源学习助手面向开源课程学习场景，提供三个核心模块：

1. **学习待办**：新增、完成/撤销、删除开源学习任务；
2. **许可证速查**：对 MIT、Apache-2.0、GPL-3.0 三种常见许可证给出适用场景和注意事项；
3. **贡献流程**：展示 Fork/Clone、分支、提交、Pull Request、Review/Merge 的基本开源协作流程。

该应用用于展示 HarmonyOS Stage 模型工程结构、ArkTS 语法、ArkUI 声明式界面和基础交互能力。

## 技术栈

- 开发工具：DevEco Studio
- 平台：HarmonyOS / OpenHarmony Stage 模型
- 语言：ArkTS
- UI：ArkUI 声明式组件
- 构建：Hvigor

## 目录结构

```text
.
├── AppScope/                         # 应用级配置与资源
├── entry/                            # 主 HAP 模块
│   ├── src/main/ets/entryability/    # EntryAbility 生命周期入口
│   ├── src/main/ets/pages/           # ArkUI 页面
│   └── src/main/resources/           # 模块资源
├── build-profile.json5               # 工程构建配置
├── hvigorfile.ts                     # 工程 Hvigor 任务入口
└── oh-package.json5                  # 工程包配置
```

## 主要功能

### 1. 总览页

展示项目定位、核心功能、技术栈，以及当前学习任务数量、已完成数量和完成进度。

### 2. 待办页

支持输入新任务并添加到列表，任务项可以标记完成、撤销完成或删除。

### 3. 许可证页

用卡片方式对比 MIT、Apache-2.0 和 GPL-3.0，点击卡片可切换当前选择。

### 4. 贡献页

用步骤卡片展示开源项目常见贡献流程，适合课程展示与课堂汇报。

## 运行方式

1. 安装并打开 DevEco Studio；
2. 选择 `Open`，打开本仓库根目录；
3. 等待 DevEco Studio 同步 Hvigor / OpenHarmony SDK；
4. 选择 `entry` 模块，连接模拟器或真机；
5. 点击 `Run` 运行应用。

如需命令行构建，可在 DevEco Studio 已正确配置 SDK 与 Hvigor 后执行对应的 Hvigor 构建任务。

## 课程作业说明

- 仓库地址：<https://github.com/OSSD-Course-SYSU-2/25307186-opensource-final-work.git>
- 学号/标识：25307186
- 作业内容：使用 DevEco Studio 编写一个 HarmonyOS 小软件并提交到 GitHub。

## 开源许可证

本项目使用 MIT License，可作为课程学习与展示用途。
