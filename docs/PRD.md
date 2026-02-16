# 产品需求文档 (PRD)
## 「当时」- 心情回顾应用

---

## 1. 产品概述

**产品名称**: 当时  
**产品定位**: 一款帮助用户记录当下感受，并以"未来视角"回顾过去心情的移动应用  
**核心价值**: 「记住每一个现在，然后与它重逢」  
**Slogan**: 记住每一个现在，然后与它重逢。

---

## 2. 技术规格

| 项目 | 选择 |
|------|------|
| 框架 | **Flutter** |
| 数据存储 | **本地数据库** (推荐 Drift/SQLite) |
| MVP范围 | **全部功能** |
| 平台 | **iOS + Android** |

---

## 3. 页面结构与导航

### 3.1 页面清单

| 页面 | 路径 | 说明 |
|------|------|------|
| OOBE 1 - Welcome | /welcome | 欢迎页，首次启动展示 |
| OOBE 2 - Record | /onboarding/record | 记录引导页 |
| Home - Timeline | /timeline | 首页/时间线（默认） |
| Feeling Thread | /feeling/:id | 心情详情页（带回复） |
| Retrospect - 回顾 | /retrospect | 回顾与统计页 |
| Profile - 我 | /profile | 个人中心页 |

### 3.2 导航结构

```
┌─────────────────────────────────────┐
│            TabBar (底部导航)          │
├──────────┬──────────┬───────────────┤
│  时间线   │   回顾    │     我         │
│ (Timeline)│(Retrospect)│  (Profile)  │
└──────────┴──────────┴───────────────┘
```

---

## 4. 功能模块列表

### 4.1 心情记录模块
- **功能描述**: 用户可以记录当下的感受和心情
- **触发方式**: 底部输入栏 (InputBar)
- **数据要求**: 文字内容 + 时间戳

### 4.2 时间线模块
- **功能描述**: 按时间倒序展示所有心情记录
- **展示内容**: 
  - 日期时间
  - 心情内容
  - 回复数量徽章
- **交互**: 点击卡片进入详情页

### 4.3 心情详情与回复模块
- **功能描述**: 查看单条心情及所有回复
- **回复功能**: 用户可以以"未来视角"给过去的心情添加回复
- **回复格式**: 回复内容 + 时间间隔（如"1周后"、"2个月后"）

### 4.4 回顾统计模块
- **功能描述**: 查看心情数据的统计分析
- **子功能**:
  - 今日回顾
  - 统计数据（连续记录天数等）
  - 月度回顾

### 4.5 个人中心模块
- **功能描述**: 用户profile和设置
- **展示内容**:
  - 头像
  - 用户名
  - 连续记录天数
  - 设置列表

---

## 5. 核心用户流程

### 5.1 新用户引导流程
```
首次打开 App
      ↓
  [Welcome页] ──「开始」按钮──→ [Record引导页]
      ↓                               ↓
  无需登录，数据本地保存      [跳过] / 完成引导
      ↓                               ↓
      └──────────→ 进入 Timeline ←───┘
```

### 5.2 心情记录流程
```
Timeline 页 → 点击输入栏 → 输入内容 → 点击发送 → 新心情出现在时间线顶部
```

### 5.3 回顾与回复流程
```
Timeline → 点击心情卡片 → Feeling Thread 页 
                                   ↓
                          底部输入栏回复 
                                   ↓
                          回复出现在原心情下方
```

---

## 6. 设计规范

### 6.1 色彩系统

| 变量名 | 值 | 用途 |
|--------|-----|------|
| accent-primary | #0D6E6E | 强调色/按钮 |
| accent-secondary | #E07B54 | 次要强调色 |
| bg-primary | #FAFAFA | 主背景色 |
| bg-surface | #FFFFFF | 卡片/表面背景 |
| bg-muted | #F8F8F8 | 次级背景 |
| text-primary | #1A1A1A | 主文字色 |
| text-secondary | #6B6B6B | 次级文字 |
| text-tertiary | #888888 | 辅助文字 |
| border-primary | #E5E5E5 | 边框色 |
| positive | #3D6B4F | 正向状态色 |

### 6.2 字体系统

| 用途 | 字体 |
|------|------|
| 标题 | Newsreader (衬线体) |
| 正文 | Inter |
| 时间/代码 | JetBrains Mono |

### 6.3 圆角规范

| 组件 | 圆角 |
|------|------|
| 心情卡片 (FeelingCard) | 12px |
| 回复气泡 (ReplyBubble) | 12px |
| 输入栏 (InputBar) | 12px |
| 底部导航 (TabBar) | 32px |

---

## 7. 数据模型

### 7.1 Feeling (心情)

```dart
class Feeling {
  final String id;
  final String content;      // 心情文字内容
  final DateTime createdAt;  // 创建时间
  final int replyCount;      // 回复数量
}
```

### 7.2 Reply (回复)

```dart
class Reply {
  final String id;
  final String feelingId;   // 关联的心情ID
  final String content;      // 回复内容
  final DateTime createdAt;  // 回复时间
  final String timeOffset;   // 时间间隔描述 (如 "1周后")
}
```

### 7.3 User (用户)

```dart
class User {
  final String id;
  final String? avatar;      // 头像URL
  final int streakDays;      // 连续记录天数
  final int totalFeelings;   // 总记录数
}
```

---

## 8. 组件清单

| 组件名 | 用途 | 特性 |
|--------|------|------|
| FeelingCard | 心情卡片 | 展示日期、内容、回复数徽章 |
| ReplyBubble | 回复气泡 | 带时间间隔标签的回复样式 |
| InputBar | 输入栏 | 包含输入框和发送按钮 |
| TabBar | 底部导航 | 三个Tab：时间线/回顾/我的 |

---

## 9. 关键设计细节

1. **无需登录**: 所有数据保存在本地
2. **未来视角回复**: 回复时自动计算与原心情的时间间隔
3. **简洁美学**: 大量留白，衬线体标题，JetBrains Mono用于时间显示
4. **移动端优先**: 宽度402px的设计，适配手机屏幕

---

## 10. 本地数据库选型建议

| 方案 | 优点 | 缺点 |
|------|------|------|
| **Drift (推荐)** | 类型安全、ORM友好、Flutter官方推荐 | 学习曲线略高 |
| **Isar** | 性能好、API简洁 | 相对较新 |
| **Hive** | 简单易用、NoSQL | 不适合复杂关系查询 |

**推荐**: 使用 Drift 作为本地数据库方案

---

## 11. 文件结构建议

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
├── data/
│   ├── database/
│   ├── models/
│   └── repositories/
├── features/
│   ├── onboarding/
│   ├── timeline/
│   ├── feeling_detail/
│   ├── retrospect/
│   └── profile/
└── shared/
    └── widgets/
```

---

*文档版本: v1.0*  
*最后更新: 2026-02-15*
