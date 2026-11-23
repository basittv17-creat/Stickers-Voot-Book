# Stickers Voot Book

A Flutter Android companion for **Stickers 😀 🌹 Voot Book**. It opens on the channel screen without an account or external navigation. The current source displays an unavailable state because a working signed-out Android preview and a production content source have yet to be established.

## Source checks

Use Flutter 3.50.1 stable (Dart 3.14), JDK 21 and the Android SDK:

```sh
flutter pub get --enforce-lockfile
dart format --output=none --set-exit-if-changed lib test integration_test
flutter analyze
flutter test
```

GitHub Actions runs the same checks and configures the Android Gradle project without packaging. See [TEST_PLAN.md](TEST_PLAN.md) for device validation and the approval gate for APK work.

## Repository baseline and plan

The public repository started empty, with no branches, source, or CI. The connected account had push access. The first commit initializes `main` with a README so the app source can be reviewed on `codex/android-channel-source`. The source phase adds the Android project and channel availability screen, documents the feasibility review, and establishes non-packaging CI. A working device preview or an authorized production API is a prerequisite for a live feed.

- [Architecture](ARCHITECTURE.md)
- [Channel feasibility](FEASIBILITY.md)
- [Test plan](TEST_PLAN.md)
