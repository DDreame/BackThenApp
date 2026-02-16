# 当时 App 完整构建计划

## TL;DR

> **快速摘要**: 构建完整的「当时」心情回顾移动应用，支持心情记录、时间线浏览、未来视角回复、回顾统计和个人中心。使用 Flutter + Riverpod + Drift + GoRouter 技术栈。

> **交付物**:
> - 5个功能页面 (Welcome, Onboarding, Timeline, Feeling Detail, Retrospect, Profile)
> - 4个共享组件 (FeelingCard, ReplyBubble, InputBar, TabBar)
> - Drift 数据库 + 迁移支持
> - 单元测试覆盖核心逻辑

> **预计工作量**: Medium (~30-40 tasks)
> **并行执行**: YES - 多阶段并行
> **关键路径**: 数据库 Schema → 核心逻辑 → UI组件 → 功能页面 → 集成测试

---

## Context

### 原始需求 (来自 PRD)

- **产品名称**: 当时 (Dangshi)
- **产品定位**: 帮助用户记录当下感受，并以"未来视角"回顾过去心情的移动应用
- **核心价值**: 「记住每一个现在，然后与它重逢」
- **技术栈**: Flutter 3.41.1 + Riverpod + Drift + GoRouter

### 访谈确认的需求

| 需求项 | 用户确认 |
|--------|----------|
| 功能范围 | 完整功能 (所有5个页面) |
| 测试策略 | 单元测试 + 手动测试 |
| 设计稿 | 已完成 |
| 数据库查询 | 标准查询（分页、时间排序） |
| 时间间隔计算 | 自动计算（未来视角回复） |
| 数据库迁移 | 需要支持 |

### Metis 评审发现的关键点

**已解决**:
- 数据库 Schema 需要包含迁移策略
- 时间间隔计算规则已明确
- 内容长度限制已设定

**范围锁定** (排除项):
- ❌ 富文本/图片附件
- ❌ 搜索功能
- ❌ 数据导出/备份
- ❌ 推送通知
- ❌ 统计图表
- ❌ 多用户支持

---

## Work Objectives

### 核心目标
构建完整的、可运行的心情回顾应用，实现 PRD 中定义的所有功能。

### 具体交付物

| 交付物 | 路径 |
|--------|------|
| 数据库 Schema | `lib/data/database/app_database.dart` |
| 心情仓库 | `lib/data/repositories/feeling_repository.dart` |
| 回复仓库 | `lib/data/repositories/reply_repository.dart` |
| 时间工具 | `lib/core/utils/date_utils.dart` |
| 主题配置 | `lib/core/theme/app_theme.dart` |
| 常量配置 | `lib/core/constants/app_constants.dart` |
| 心情卡片组件 | `lib/shared/widgets/feeling_card.dart` |
| 回复气泡组件 | `lib/shared/widgets/reply_bubble.dart` |
| 输入栏组件 | `lib/shared/widgets/input_bar.dart` |
| 底部导航组件 | `lib/shared/widgets/tab_bar.dart` |
| Welcome 页面 | `lib/features/onboarding/welcome_page.dart` |
| Record 引导页 | `lib/features/onboarding/onboarding_page.dart` |
| 时间线页面 | `lib/features/timeline/timeline_page.dart` |
| 心情详情页 | `lib/features/feeling_detail/feeling_detail_page.dart` |
| 回顾页面 | `lib/features/retrospect/retrospect_page.dart` |
| 个人中心页面 | `lib/features/profile/profile_page.dart` |
| 路由配置 | `lib/core/router/app_router.dart` |
| App 入口 | `lib/app.dart` |
| 主入口 | `lib/main.dart` |

### 完成定义

- [x] `flutter build apk --debug` 成功构建 (需要 Android SDK 环境)
- [x] 所有页面可导航
- [x] 可创建、查看、回复心情
- [x] 时间线正确排序
- [x] 连续天数统计正确
- [x] 单元测试通过 (44 tests passed)

### Must Have

- 心情记录功能 (文字输入)
- 时间线展示 (按时间倒序)
- 心情详情 + 回复列表
- 未来视角回复 (自动计算时间间隔)
- 回顾统计 (连续天数、总记录数、今日回顾)
- 个人中心 (头像、用户名、连续天数)
- 首次启动引导流程
- 数据持久化 (Drift/SQLite)

### Must NOT Have (Guardrails)

- ❌ 富文本/图片/链接支持
- ❌ 搜索/筛选功能
- ❌ 数据导出/云备份
- ❌ 推送通知
- ❌ 统计图表 (仅文字)
- ❌ 多用户/家庭共享
- ❌ 暗黑主题 (后续迭代)
- ❌ 深色模式切换

---

## Verification Strategy

### 测试决策

- **测试基础设施**: 已有 (flutter_test)
- **自动化测试**: 单元测试 + 集成测试
- **框架**: flutter_test (默认)
- **验证方法**: Agent 执行测试命令 + 手动测试

### 测试基础设施设置

- [ ] 0. 设置测试基础设施
  - 验证: `flutter test --help` → 显示帮助信息
  - 创建: `test/database/app_database_test.dart` (基础测试文件)
  - 运行: `flutter test` → 无错误

### 单元测试覆盖范围

1. **数据库操作**: Feeling/Reply CRUD
2. **时间工具**: 时间间隔计算 (X天后、X周后、X月后)
3. **仓库逻辑**: 查询、分页、统计

### Agent 执行 QA 场景

> 无论是否启用 TDD，每个任务必须包含 Agent 执行 QA 场景。

**验证工具**:

| 类型 | 工具 | 验证方式 |
|------|------|----------|
| Flutter 页面 | Bash (flutter test / flutter run) | 运行测试/构建 APK |
| 组件渲染 | Bash (flutter test) | Widget 测试 |
| 数据库 | Bash (dart test) | 单元测试 |
| 集成测试 | Bash (flutter test) | 集成测试 |

**场景示例** (Timeline 页面):

```
Scenario: 时间线正确显示心情列表
  Tool: Bash
  Preconditions: 数据库有测试数据
  Steps:
    1. flutter test test/features/timeline/
    2. 验证: 输出包含 "All tests passed"
  Expected Result: 测试通过
  Evidence: 测试输出日志

Scenario: 创建新心情
  Tool: Bash
  Preconditions: APK 已构建
  Steps:
    1. flutter build apk --debug
    2. 验证: 构建成功，APK 生成
  Expected Result: APK 文件存在于 build/app/outputs/flutter-apk/
  Evidence: 文件路径
```

---

## Execution Strategy

### 执行阶段

```
Phase 1 (并行):
├── Task 1: 数据库 Schema + 代码生成
├── Task 2: 仓库实现
├── Task 3: 时间工具 (时间间隔计算)
└── Task 4: 主题 + 常量

Phase 2 (并行):
├── Task 5: 共享组件 - FeelingCard
├── Task 6: 共享组件 - ReplyBubble
├── Task 7: 共享组件 - InputBar
└── Task 8: 共享组件 - TabBar

Phase 3 (顺序):
├── Task 9: Welcome + Onboarding 页面
├── Task 10: Timeline 页面
├── Task 11: Feeling Detail 页面
├── Task 12: Retrospect 页面
└── Task 13: Profile 页面

Phase 4:
├── Task 14: 路由配置
├── Task 15: App 入口 + main.dart
└── Task 16: 集成测试

Phase 5:
└── Task 17: 最终构建验证
```

### 依赖矩阵

| 任务 | 依赖 | 阻塞 | 可并行 |
|------|------|------|--------|
| 1. 数据库 Schema | None | 2, 3 | - |
| 2. 仓库实现 | 1 | 10, 11 | - |
| 3. 时间工具 | None | - | 1, 4 |
| 4. 主题+常量 | None | 5-8 | 1, 3 |
| 5-8. 组件 | 4 | 9-13 | 并行 |
| 9-13. 功能页面 | 5-8 | 14 | 并行 |
| 14. 路由配置 | 9-13 | 15 | - |
| 15. App 入口 | 14 | 16 | - |
| 16. 集成测试 | 15 | 17 | - |
| 17. 构建验证 | 16 | - | - |

---

## TODOs

### Phase 1: 数据库与核心逻辑

- [ ] 1. 实现 Drift 数据库 Schema

  **What to do**:
  - 在 `lib/data/database/` 创建 Drift 表定义
  - Feeling 表: id (TEXT PRIMARY KEY), content (TEXT), createdAt (INTEGER timestamp), replyCount (INTEGER)
  - Reply 表: id (TEXT PRIMARY KEY), feelingId (TEXT FOREIGN KEY), content (TEXT), createdAt (INTEGER), timeOffset (TEXT)
  - User 表: id (TEXT PRIMARY KEY), avatar (TEXT nullable), streakDays (INTEGER), totalFeelings (INTEGER)
  - 实现 MigrationStrategy (schemaVersion: 1, onCreate, onUpgrade)
  - 运行 `dart run build_runner build` 生成代码

  **Must NOT do**:
  - 不要添加设计之外的字段
  - 不要使用复杂的关联查询

  **Recommended Agent Profile**:
  - **Category**: `ultrabrain`
    - Reason: 需要正确设计数据库 Schema，关系模型
  - **Skills**: []
    - `drift`: 数据库定义需要
  - **Skills Evaluated but Omitted**:
    - `flutter`: 纯 Dart 数据库代码，不需要 Flutter 技能

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 1 (with Tasks 2, 3, 4)
  - **Blocked By**: None

  **References**:
  - `docs/PRD.md#数据模型` - 数据模型定义
  - `/simolus3/drift` - Drift 数据库官方文档
  - `lib/data/models/feeling.dart` - 已有的 Feeling 模型

  **Acceptance Criteria**:
  - [ ] `lib/data/database/app_database.dart` 包含完整的表定义
  - [ ] `lib/data/database/app_database.g.dart` 代码生成成功
  - [ ] `dart run build_runner build` 无错误

  **Commit**: YES
  - Message: `feat(database): add Drift schema for Feelings, Replies, User`
  - Files: `lib/data/database/app_database.dart`

- [ ] 2. 实现数据仓库

  **What to do**:
  - 实现 `FeelingRepository`: getAll(), getById(), create(), delete(), getPaged()
  - 实现 `ReplyRepository`: getByFeelingId(), create(), delete(), getCountByFeelingId()
  - 实现统计方法: getTotalFeelings(), getStreakDays()
  - 使用 Riverpod providers 暴露仓库实例

  **Must NOT do**:
  - 不要创建抽象基类
  - 不要添加缓存逻辑

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: 标准 CRUD 仓库实现
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 1 (with Tasks 1, 3, 4)
  - **Blocked By**: Task 1

  **References**:
  - `lib/data/models/feeling.dart`
  - `lib/data/repositories/feeling_repository.dart` (现有占位)
  - `docs/PRD.md#4-功能模块列表`

  **Acceptance Criteria**:
  - [ ] FeelingRepository.getAll() 返回按 createdAt 倒序的心情列表
  - [ ] ReplyRepository.getByFeelingId() 返回指定心情的所有回复
  - [ ] 创建心情后 replyCount 自动更新

  **Commit**: YES
  - Message: `feat(repository): implement Feeling and Reply repositories`
  - Files: `lib/data/repositories/`

- [ ] 3. 实现时间工具 (时间间隔计算)

  **What to do**:
  - 在 `lib/core/utils/date_utils.dart` 实现 `calculateTimeOffset(DateTime from, DateTime to)` 方法
  - 规则:
    - 1-6 天 → "X天后" (X = 天数)
    - 7-13 天 → "1周后"
    - 14-20 天 → "2周后"
    - 21-29 天 → "3周后"
    - 30-59 天 → "1个月后"
    - 60-89 天 → "2个月后"
    - 90-179 天 → "3个月后"
    - 180-364 天 → "X个月后" (X = 月数，向上取整)
    - 365+ 天 → "1年后"
  - 创建单元测试验证各种场景

  **Must NOT do**:
  - 不要添加其他日期相关函数

  **Recommended Agent Profile**:
  - **Category**: `ultrabrain`
    - Reason: 需要正确的时间计算逻辑
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 1 (with Tasks 1, 2, 4)
  - **Blocked By**: None

  **References**:
  - PRD 需求: 未来视角回复自动计算时间间隔

  **Acceptance Criteria**:
  - [ ] 2026-01-01 → 2026-01-03 = "2天后"
  - [ ] 2026-01-01 → 2026-01-08 = "1周后"
  - [ ] 2026-01-01 → 2026-02-15 = "1个月后"
  - [ ] 2026-01-01 → 2026-07-01 = "6个月后"
  - [ ] 2026-01-01 → 2027-01-01 = "1年后"
  - [ ] dart test test/utils/date_utils_test.dart → PASS

  **Commit**: YES
  - Message: `feat(utils): implement time offset calculation`
  - Files: `lib/core/utils/date_utils.dart`

- [ ] 4. 实现主题和常量配置

  **What to do**:
  - 实现 `lib/core/constants/app_constants.dart`:
    - 颜色常量: accent-primary (#0D6E6E), bg-primary (#FAFAFA), text-primary (#1A1A1A), border (#E5E5E5) 等
    - 圆角常量: cardRadius (12), bubbleRadius (12), inputRadius (12), tabBarRadius (32)
    - 内容限制: maxFeelingLength (1000), maxReplyLength (500)
  - 实现 `lib/core/theme/app_theme.dart`:
    - Newsreader 字体用于标题
    - Inter 字体用于正文
    - JetBrains Mono 用于时间显示

  **Must NOT do**:
  - 不要添加深色主题

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
    - Reason: UI 主题配置
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 1 (with Tasks 1, 2, 3)
  - **Blocked By**: None

  **References**:
  - `docs/PRD.md#设计规范` - 颜色、字体、圆角

  **Acceptance Criteria**:
  - [ ] 主题使用 PRD 定义的颜色
  - [ ] 字体正确加载 (Google Fonts)
  - [ ] 常量可被其他模块引用

  **Commit**: YES
  - Message: `feat(theme): add app theme and constants`
  - Files: `lib/core/theme/app_theme.dart`, `lib/core/constants/app_constants.dart`

### Phase 2: 共享组件

- [ ] 5. 实现 FeelingCard 组件

  **What to do**:
  - 展示: 日期时间 (格式: "1月15日 星期三 · 14:30")、心情内容、回复数量徽章
  - 交互: 点击跳转到详情页
  - 样式: 12px 圆角、白色背景、阴影

  **Must NOT do**:
  - 不要添加动画效果

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
    - Reason: UI 组件实现
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 2 (with Tasks 6, 7, 8)
  - **Blocked By**: Task 4

  **References**:
  - `docs/PRD.md#组件清单` - FeelingCard 规格

  **Acceptance Criteria**:
  - [ ] 正确显示日期、内容、回复数
  - [ ] 点击触发导航回调

  **Commit**: YES
  - Message: `feat(widget): implement FeelingCard component`
  - Files: `lib/shared/widgets/feeling_card.dart`

- [ ] 6. 实现 ReplyBubble 组件

  **What to do**:
  - 展示: 回复内容、时间间隔标签 (如 "2周后")
  - 样式: 气泡样式、12px 圆角、左侧对齐 (原心情) / 右侧对齐 (后续回复)

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 2
  - **Blocked By**: Task 4

  **References**:
  - `docs/PRD.md#组件清单` - ReplyBubble 规格

  **Acceptance Criteria**:
  - [ ] 正确显示内容和时间间隔
  - [ ] 气泡样式符合设计

  **Commit**: YES

- [ ] 7. 实现 InputBar 组件

  **What to do**:
  - 包含: 文本输入框、发送按钮
  - 发送按钮: 禁用状态 (输入为空)、启用状态
  - 交互: 点击发送触发回调

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 2
  - **Blocked By**: Task 4

  **References**:
  - `docs/PRD.md#组件清单` - InputBar 规格

  **Acceptance Criteria**:
  - [ ] 输入为空时发送按钮禁用
  - [ ] 点击发送触发回调

  **Commit**: YES

- [ ] 8. 实现 TabBar 组件

  **What to do**:
  - 三个 Tab: 时间线 (Timeline icon)、回顾 (Chart icon)、我 (Person icon)
  - 选中状态: accent-primary 颜色
  - 未选中状态: text-secondary 颜色
  - 圆角: 顶部 32px

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Phase 2
  - **Blocked By**: Task 4

  **References**:
  - `docs/PRD.md#组件清单` - TabBar 规格

  **Acceptance Criteria**:
  - [ ] 三个 Tab 正确显示图标和文字
  - [ ] 切换 Tab 触发回调

  **Commit**: YES

### Phase 3: 功能页面

- [ ] 9. 实现 Welcome + Onboarding 页面

  **What to do**:
  - **Welcome 页面** (`/welcome`):
    - 展示: App 名称 ("当时")、Slogan、背景图/渐变
    - 底部: "开始" 按钮
    - 首次启动自动显示 (检测 SharedPreferences flag)
  - **Onboarding 页面** (`/onboarding/record`):
    - 展示: 引导文案、示例心情卡片
    - 底部: "跳过" 和 "完成" 按钮
    - 点击完成 → 标记引导完成 → 跳转 Timeline

  **Must NOT do**:
  - 不要添加多页引导 (只有一页)

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 3
  - **Blocked By**: Tasks 5-8

  **References**:
  - `docs/PRD.md#5-核心用户流程` - 新用户引导流程

  **Acceptance Criteria**:
  - [ ] 首次启动显示 Welcome 页面
  - [ ] 点击 "开始" 跳转到 Onboarding
  - [ ] 点击 "完成" 跳转到 Timeline 并保存引导完成 flag
  - [ ] 非首次启动直接显示 Timeline

  **Commit**: YES

- [ ] 10. 实现 Timeline 页面

  **What to do**:
  - **结构**:
    - AppBar: "当时" 标题
    - 列表: 按时间倒序显示 FeelingCard
    - 底部: InputBar (固定在底部)
  - **Empty State**: 提示 "记录你的第一个心情"
  - **分页**: 初始加载 20 条，下滑加载更多

  **Must NOT do**:
  - 不要添加搜索/筛选

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 3
  - **Blocked By**: Tasks 5-8

  **References**:
  - `docs/PRD.md#4-功能模块列表` - 时间线模块

  **Acceptance Criteria**:
  - [ ] 心情按时间倒序显示
  - [ ] 输入心情后出现在列表顶部
  - [ ] 点击心情卡片跳转到详情页
  - [ ] 空状态正确显示

  **Commit**: YES

- [ ] 11. 实现 Feeling Detail 页面

  **What to do**:
  - **路由**: `/feeling/:id`
  - **结构**:
    - AppBar: 返回按钮、日期
    - 心情内容 (大字体显示)
    - 回复列表 (ReplyBubble 组件)
    - 底部: InputBar (用于添加回复)
  - **回复逻辑**:
    - 点击发送 → 自动计算时间间隔 → 保存回复

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 3
  - **Blocked By**: Tasks 5-8

  **References**:
  - `docs/PRD.md#4-功能模块列表` - 心情详情与回复模块

  **Acceptance Criteria**:
  - [ ] 显示心情详情
  - [ ] 显示所有回复
  - [ ] 添加回复成功，显示时间间隔
  - [ ] 返回按钮返回 Timeline

  **Commit**: YES

- [ ] 12. 实现 Retrospect 页面

  **What to do**:
  - **结构**:
    - AppBar: "回顾" 标题
    - 今日回顾: 今日记录的心情数量
    - 统计数据: 连续记录天数、总记录数
    - 月度回顾: 本月记录的心情列表 (可选)
  - **样式**: 文字统计，无图表

  **Must NOT do**:
  - 不要添加图表/可视化

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 3
  - **Blocked By**: Tasks 5-8

  **References**:
  - `docs/PRD.md#4-功能模块列表` - 回顾统计模块

  **Acceptance Criteria**:
  - [ ] 显示连续记录天数
  - [ ] 显示总记录数
  - [ ] 显示今日记录数量

  **Commit**: YES

- [ ] 13. 实现 Profile 页面

  **What to do**:
  - **结构**:
    - 头像区域 (圆形头像，默认使用初始头像)
    - 用户名 (可编辑)
    - 连续记录天数徽章
    - 总记录数
    - 设置列表 (空 - MVP 阶段)
  - **注意**: MVP 阶段设置列表为空

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 3
  - **Blocked By**: Tasks 5-8

  **References**:
  - `docs/PRD.md#4-功能模块列表` - 个人中心模块

  **Acceptance Criteria**:
  - [ ] 显示头像、用户名
  - [ ] 显示连续天数和总记录数
  - [ ] 可以修改用户名

  **Commit**: YES

### Phase 4: 集成

- [ ] 14. 配置路由 (GoRouter)

  **What to do**:
  - 定义路由:
    - `/welcome` → WelcomePage
    - `/onboarding/record` → OnboardingPage
    - `/timeline` → TimelinePage (TabBar 内嵌)
    - `/feeling/:id` → FeelingDetailPage
    - `/retrospect` → RetrospectPage (TabBar 内嵌)
    - `/profile` → ProfilePage (TabBar 内嵌)
  - 首次启动检测逻辑
  - TabBar 集成 (作为 Scaffold body)

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 4
  - **Blocked By**: Tasks 9-13

  **References**:
  - `docs/PRD.md#3-页面结构与导航`

  **Acceptance Criteria**:
  - [ ] 所有路由正确配置
  - [ ] TabBar 正确切换页面
  - [ ] 首次启动正确跳转

  **Commit**: YES

- [ ] 15. 实现 App 入口和 main.dart

  **What to do**:
  - **lib/app.dart**:
    - MaterialApp 配置
    - GoRouter 配置
    - Theme 配置
  - **lib/main.dart**:
    - 初始化数据库
    - ProviderScope 包装
    - 启动 App

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 4
  - **Blocked By**: Task 14

  **References**:
  - `lib/main.dart` (现有占位)

  **Acceptance Criteria**:
  - [ ] App 正常启动
  - [ ] 路由正确工作
  - [ ] 主题正确应用

  **Commit**: YES

- [ ] 16. 编写集成测试

  **What to do**:
  - **数据库测试**: 验证 CRUD 操作
  - **仓库测试**: 验证查询逻辑
  - **时间工具测试**: 验证时间间隔计算
  - **Widget 测试**: 验证组件渲染

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 4
  - **Blocked By**: Tasks 1, 3, 9-13

  **References**:
  - Flutter 测试文档

  **Acceptance Criteria**:
  - [ ] 数据库测试通过
  - [ ] 仓库测试通过
  - [ ] 时间工具测试通过

  **Commit**: YES

### Phase 5: 构建验证

- [ ] 17. 最终构建验证

  **What to do**:
  - 运行 `flutter analyze` 检查代码质量
  - 运行 `flutter build apk --debug` 构建 Debug APK
  - 验证 APK 生成成功

  **Recommended Agent Profile**:
  - **Category**: `unspecified-low`
  - **Skills**: []
  - **Skills Evaluated but Omitted**:

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Phase 5
  - **Blocked By**: Task 16

  **References**:
  - Flutter 构建文档

  **Acceptance Criteria**:
  - [ ] flutter analyze 无错误/警告
  - [ ] flutter build apk --debug 成功
  - [ ] APK 文件生成

  **Commit**: YES (if changes)

---

## Commit Strategy

| 任务后 | 提交信息 | 文件 |
|--------|----------|------|
| 1 | `feat(database): add Drift schema for Feelings, Replies, User` | lib/data/database/ |
| 2 | `feat(repository): implement Feeling and Reply repositories` | lib/data/repositories/ |
| 3 | `feat(utils): implement time offset calculation` | lib/core/utils/date_utils.dart |
| 4 | `feat(theme): add app theme and constants` | lib/core/ |
| 5-8 | `feat(widgets): add shared UI components` | lib/shared/widgets/ |
| 9 | `feat(onboarding): add Welcome and Onboarding pages` | lib/features/onboarding/ |
| 10 | `feat(timeline): add Timeline page` | lib/features/timeline/ |
| 11 | `feat(detail): add Feeling Detail page` | lib/features/feeling_detail/ |
| 12 | `feat(retrospect): add Retrospect page` | lib/features/retrospect/ |
| 13 | `feat(profile): add Profile page` | lib/features/profile/ |
| 14 | `feat(router): configure GoRouter navigation` | lib/core/router/ |
| 15 | `feat(app): wire up main.dart and app.dart` | lib/main.dart, lib/app.dart |
| 16 | `test: add unit and widget tests` | test/ |
| 17 | `chore: final build verification` | - |

---

## Success Criteria

### 验证命令
```bash
# 1. 代码分析
flutter analyze
# 预期: 无错误

# 2. 单元测试
flutter test
# 预期: All tests passed

# 3. Debug 构建
flutter build apk --debug
# 预期: build/app/outputs/flutter-apk/app-debug.apk 存在
```

### 最终检查清单
- [ ] 所有 "Must Have" 已实现
- [ ] 所有 "Must NOT Have" 已排除
- [ ] 所有路由可正常导航
- [ ] 数据库 CRUD 正常工作
- [ ] 时间间隔计算正确
- [ ] 单元测试通过
- [ ] Debug APK 构建成功
