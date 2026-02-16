# 当时 (Dangshi)

记住每一个现在，然后与它重逢。

## 产品概述

「当时」是一款帮助用户记录当下感受，并以"未来视角"回顾过去心情的移动应用。

## 技术栈

| 类别 | 技术 |
|------|------|
| 框架 | Flutter 3.41.1 |
| 语言 | Dart 3.11.0 |
| 状态管理 | Riverpod |
| 本地数据库 | Drift (SQLite) |
| 路由 | GoRouter |
| 平台 | iOS + Android |

## 项目结构

```
lib/
├── main.dart                    # 应用入口
├── app.dart                     # App 配置
├── core/                        # 核心模块
│   ├── theme/                   # 主题配置
│   ├── constants/               # 常量定义
│   └── utils/                   # 工具函数
├── data/                        # 数据层
│   ├── database/                # Drift 数据库
│   ├── models/                  # 数据模型
│   └── repositories/            # 仓库
├── features/                    # 功能模块
│   ├── onboarding/              # 引导页
│   ├── timeline/                # 时间线
│   ├── feeling_detail/          # 心情详情
│   ├── retrospect/              # 回顾统计
│   └── profile/                 # 个人中心
└── shared/                      # 共享组件
    └── widgets/                 # 通用组件
```

## 设计规范

### 色彩系统

| 变量 | 值 | 用途 |
|------|-----|------|
| accent-primary | #0D6E6E | 强调色 |
| bg-primary | #FAFAFA | 主背景 |
| bg-surface | #FFFFFF | 卡片背景 |
| text-primary | #1A1A1A | 主文字 |
| text-secondary | #6B6B6B | 次级文字 |
| border-primary | #E5E5E5 | 边框 |

### 字体

- 标题: Newsreader (衬线体)
- 正文: Inter
- 代码/时间: JetBrains Mono

## 开发指南

### 环境要求

- Flutter SDK >= 3.41.1
- Dart SDK >= 3.11.0

### 安装依赖

```bash
flutter pub get
```

### 运行项目

```bash
# 开发模式
flutter run

# 构建 APK
flutter build apk --debug

# 构建 Release
flutter build apk --release

# iOS (需要 macOS)
flutter build ios --release
```

### 代码生成

本项目使用 Drift 进行数据库代码生成：

```bash
dart run build_runner build
```

## 页面清单

| 页面 | 路径 |
|------|------|
| Welcome | /welcome |
| Record 引导 | /onboarding/record |
| 时间线 | /timeline |
| 心情详情 | /feeling/:id |
| 回顾 | /retrospect |
| 个人中心 | /profile |

## 数据模型

### Feeling (心情)

```dart
class Feeling {
  final String id;
  final String content;
  final DateTime createdAt;
  final int replyCount;
}
```

### Reply (回复)

```dart
class Reply {
  final String id;
  final String feelingId;
  final String content;
  final DateTime createdAt;
  final String timeOffset;  // 如 "1周后"
}
```

## 贡献指南

欢迎提交 Issue 和 Pull Request。

## 许可证

MIT License
