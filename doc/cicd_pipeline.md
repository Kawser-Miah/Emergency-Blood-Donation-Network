# CI/CD Pipeline — Blood Setu

## Trigger Conditions

| Event | Branch |
|---|---|
| Push | `main` |
| Pull Request | `main` |
| Manual dispatch | any |

**Concurrency:** Superseded runs on the same ref are cancelled automatically to save CI minutes.

---

## Pipeline Structure

```
push / PR to main
        │
        ▼
┌─────────────────────┐
│  analyze-and-test   │  ← gate job
│  ubuntu-latest      │
│  • flutter analyze  │
│  • flutter test     │
└────────┬────────────┘
         │ needs: analyze-and-test
         ▼
┌─────────────────────┐
│   build-android     │
│   ubuntu-latest     │
│  • inject secret    │
│  • flutter build    │
│  • upload artifact  │
│  • GitHub Release   │  ← main push only
└─────────────────────┘
```

---

## Job Details

### Job 1 — `analyze-and-test`

**Runner:** `ubuntu-latest`

| Step | Command / Action |
|---|---|
| Checkout | `actions/checkout@v4` |
| Set up JDK 17 | `actions/setup-java@v4` (Temurin distribution) |
| Set up Flutter | `subosito/flutter-action@v2` (stable channel, cache enabled) |
| Install dependencies | `flutter pub get` |
| Analyze | `flutter analyze lib test` |
| Test | `flutter test` |

> Analysis is scoped to `lib test` only — the vendored `packages/jni/` directory is excluded to avoid unrelated path warnings failing the gate.

---

### Job 2 — `build-android`

**Runner:** `ubuntu-latest`
**Depends on:** `analyze-and-test` (must pass first)
**Permissions:** `contents: write` (needed to publish GitHub Releases)

| Step | Details |
|---|---|
| Checkout | `actions/checkout@v4` |
| Set up JDK 17 | `actions/setup-java@v4` (Temurin distribution) |
| Set up Flutter | `subosito/flutter-action@v2` (stable channel, cache enabled) |
| Inject Firebase config | Decodes `GOOGLE_SERVICES_JSON` secret → `android/app/google-services.json`; fails with a clear error if secret is unset |
| Install dependencies | `flutter pub get` |
| Build APK | `flutter build apk` |
| Upload artifact | `actions/upload-artifact@v4` → `build/app/outputs/flutter-apk/app-release.apk` |
| Publish GitHub Release | `softprops/action-gh-release@v2` — tagged `build-{run_number}` — **push to `main` only** |

#### Firebase Secret Setup

`google-services.json` is gitignored and must be added as a repository secret:

```bash
# Encode the file
base64 -w0 android/app/google-services.json
# Paste the output as secret: GOOGLE_SERVICES_JSON
```

#### GitHub Release naming

```
Tag:   build-{github.run_number}
Name:  Build #{github.run_number}
Body:  Automated debug build from commit {github.sha}.
```

Releases are **not** created on PR runs or manual dispatch — only on direct pushes to `main`.

---

## Known Issues & Recommendations

### 1. Debug vs Release APK mismatch (Medium)

`flutter build apk` without a flag produces a **release** APK (`app-release.apk`), but the job is named "Build Android APK (debug)". This is misleading and likely unintentional.

**Fix — pick one:**
```yaml
# Option A: true debug build
run: flutter build apk --debug
# artifact path: build/app/outputs/flutter-apk/app-debug.apk

# Option B: rename step and be explicit about release
name: Build Android APK (release)
run: flutter build apk --release
```

---

### 2. No `build_runner` generation check (Medium)

Generated files (`*.freezed.dart`, `*.g.dart`, `di.config.dart`) must be committed. CI does not verify they are up-to-date — a drift between source annotations and generated output can cause subtle runtime bugs.

**Recommended step** (add before `flutter analyze`):

```yaml
- name: Verify generated files are up to date
  run: |
    dart run build_runner build --delete-conflicting-outputs
    git diff --exit-code || (echo "Generated files are out of date. Run build_runner and commit the output." && exit 1)
```

---

### 3. Flutter version not pinned (Low)

`channel: stable` silently upgrades Flutter when a new stable release lands, which can introduce breaking changes mid-sprint.

**Fix:**
```yaml
- uses: subosito/flutter-action@v2
  with:
    channel: stable
    flutter-version: '3.32.x'   # pin to a known-good minor
    cache: true
```

---

### 4. Pub cache not shared between jobs (Low)

Both jobs independently run `flutter pub get`, downloading the same packages twice. Sharing the cache via `pubspec.lock` hash saves ~30–60 s per run.

**Fix — add to each job:**
```yaml
- uses: actions/cache@v4
  with:
    path: |
      ~/.pub-cache
      .dart_tool
    key: pub-${{ runner.os }}-${{ hashFiles('pubspec.lock') }}
    restore-keys: pub-${{ runner.os }}-
```

---

### 5. No APK signing for release builds (Info)

The current release APK is unsigned (Flutter's debug/default key). For distribution outside the Play Store you need a keystore:

```yaml
- name: Sign APK
  env:
    KEYSTORE_BASE64: ${{ secrets.KEYSTORE_BASE64 }}
    KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
    KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
    STORE_PASSWORD: ${{ secrets.STORE_PASSWORD }}
  run: |
    echo "$KEYSTORE_BASE64" | base64 --decode > android/app/release.jks
    # wire via key.properties or --dart-define
```

---

### 6. No iOS build (Info)

Only Android is covered. An iOS job would require a `macos-latest` runner and Apple certificates/provisioning profiles via secrets.

---

## Secrets Required

| Secret | Description |
|---|---|
| `GOOGLE_SERVICES_JSON` | Base64-encoded `android/app/google-services.json` |
| `KEYSTORE_BASE64` *(future)* | Base64-encoded release keystore |
| `KEY_ALIAS` *(future)* | Keystore key alias |
| `KEY_PASSWORD` *(future)* | Key password |
| `STORE_PASSWORD` *(future)* | Keystore password |