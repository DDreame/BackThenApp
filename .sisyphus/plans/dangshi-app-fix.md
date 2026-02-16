# 当时 App Bug 修复计划

## TL;DR

> **问题**: "Data not init" 错误 + TabBar 未集成 + OOBE UI 不匹配
> **原因**: 每个页面独立创建数据库实例，导致数据丢失
> **修复**: 共享数据库 Provider + TabBar 导航集成

---

## 问题分析

### 🔴 Critical: 数据库未共享

**现象**: 创建第一个心情后提示 "Data not init"

**原因**:
```dart
// 每个页面都这样做:
class TimelinePage extends StatefulWidget {
  final AppDatabase _database = AppDatabase(); // 每个页面新建实例!
  
  @override
  void dispose() {
    _database.close(); // 切换页面时关闭!
    super.dispose();
  }
}
```

**解决方案**: 使用 Riverpod Provider 共享单一数据库实例

### 🔴 Critical: TabBar 未集成

**现象**: Timeline/Retrospect/Profile 是独立页面，无法切换

**原因**: 路由没有使用 Shell Route + Bottom Navigation

**解决方案**: 实现 GoRouter Shell Route

### 🟡 UI: OOBE 页面

**需要对照设计稿检查**:
- Welcome 页面布局
- Onboarding 示例卡片样式

---

## 修复任务

### Phase 1: 修复数据库共享 (Critical)

- [ ] 1. 创建数据库 Provider

  **What to do**:
  - 在 `lib/core/providers/` 创建 `database_provider.dart`
  - 使用 `Provider<AppDatabase>` 共享单一实例
  - 修改所有页面使用 Provider 获取数据库

  **File**: `lib/core/providers/database_provider.dart`

  **Acceptance Criteria**:
  - [ ] 数据库单例通过 Provider 访问
  - [ ] 不再出现 "Data not init" 错误

- [ ] 2. 重构所有页面使用 Provider

  **What to do**:
  - 修改 `timeline_page.dart` 使用 Provider
  - 修改 `feeling_detail_page.dart` 使用 Provider
  - 修改 `retrospect_page.dart` 使用 Provider
  - 修改 `profile_page.dart` 使用 Provider

  **Acceptance Criteria**:
  - [ ] 所有页面从 Provider 获取数据库
  - [ ] 页面切换不再导致数据库关闭

### Phase 2: 集成 TabBar 导航 (Critical)

- [ ] 3. 实现 TabBar Shell Route

  **What to do**:
  - 在 `app_router.dart` 使用 `ShellRoute`
  - 集成 `CustomTabBar` 组件
  - 三个 Tab: 时间线、回顾、我

  **Acceptance Criteria**:
  - [ ] 底部导航显示
  - [ ] Tab 切换正常工作

### Phase 3: 检查 OOBE UI (Minor)

- [ ] 4. 检查 Welcome 页面

  **What to do**:
  - 对照设计稿检查布局
  - 确认按钮样式、文字

- [ ] 5. 检查 Onboarding 页面

  **What to do**:
  - 对照设计稿检查示例卡片
  - 确认按钮文案

---

## 执行顺序

```
Phase 1:
├── Task 1: 创建数据库 Provider
└── Task 2: 重构页面使用 Provider

Phase 2:
└── Task 3: TabBar Shell Route

Phase 3 (可选):
├── Task 4: Welcome 页面检查
└── Task 5: Onboarding 页面检查
```

---

## 验收标准

- [ ] 创建心情不再报 "Data not init" 错误
- [ ] 可以正常切换 时间线/回顾/我的 Tab
- [ ] 数据在页面切换后保持
- [ ] OOBE 流程正常: Welcome → Onboarding → Timeline
