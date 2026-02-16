# PROJECT KNOWLEDGE BASE

**Generated:** 2026-02-15
**Project:** 当时 (Dangshi) - Mood Journaling App
**Framework:** Flutter 3.41.1 / Dart 3.11.0

## OVERVIEW

A mood journaling mobile app that helps users record feelings and review them from a "future perspective". Data stored locally using Drift (SQLite).

## STRUCTURE

```
lib/
├── main.dart                    # Entry point (Flutter default, needs rewrite)
├── app.dart                     # App configuration (TODO)
├── core/
│   ├── theme/                   # Theme configuration
│   ├── constants/               # App constants
│   └── utils/                   # Utility functions
├── data/
│   ├── database/                # Drift database
│   ├── models/                  # Data models (Feeling, Reply, User)
│   └── repositories/             # Data repositories
├── features/                    # Feature modules
│   ├── onboarding/              # OOBE screens
│   ├── timeline/                # Home/Timeline
│   ├── feeling_detail/          # Feeling + replies
│   ├── retrospect/              # Statistics
│   └── profile/                 # User profile
└── shared/
    └── widgets/                 # Reusable UI components
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Database schema | lib/data/database/ | Drift tables |
| Data models | lib/data/models/ | Feeling, Reply, User |
| UI components | lib/shared/widgets/ | FeelingCard, InputBar, TabBar |
| Screen implementations | lib/features/*/ | Feature screens |

## CODE MAP

| Symbol | Type | Location | Notes |
|--------|------|----------|-------|
| Feeling | Model | lib/data/models/feeling.dart | Mood entry |
| Reply | Model | lib/data/models/reply.dart | Future perspective reply |
| User | Model | lib/data/models/user.dart | User profile |

## CONVENTIONS

- **State Management**: Riverpod (flutter_riverpod)
- **Navigation**: GoRouter
- **Database**: Drift with code generation
- **Models**: Equatable for value equality
- **Linting**: flutter_lints (standard)

## ANTI-PATTERNS (THIS PROJECT)

- NO server/cloud - all data local only
- NO authentication - no login required
- NO third-party analytics

## COMMANDS

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk --debug

# Generate Drift code
dart run build_runner build

# Analyze
flutter analyze
```

## DESIGN TOKENS

From pencil-new.pen:
- accent-primary: #0D6E6E
- bg-primary: #FAFAFA
- text-primary: #1A1A1A
- fonts: Newsreader (title), Inter (body), JetBrains Mono (time)

## NOTES

- Project is fresh - main.dart contains default Flutter counter app
- Need to implement proper app architecture (Riverpod + GoRouter)
- Drift database needs schema definition
