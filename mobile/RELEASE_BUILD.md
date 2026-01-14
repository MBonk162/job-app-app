# Building Release APK for Android

This guide explains how to create a production-ready APK that can be installed on any Android phone.

## One-Time Setup (First Time Only)

### Step 1: Create Signing Key

Run this from the `mobile/android` directory:

```bash
cd mobile/android
create_keystore.bat
```

You'll be asked for:
- **Keystore password**: Create a strong password (you'll need this for every release!)
- **Key password**: Can be the same as keystore password
- **First and last name**: Your name
- **Organizational unit**: Your company/team (or just your name)
- **Organization**: Your company (or just your name)
- **City/Locality**: Your city
- **State/Province**: Your state
- **Country code**: Two-letter code (e.g., US)

**IMPORTANT**:
- This creates `mobile/android/app/upload-keystore.jks`
- **NEVER lose this file or password!** You won't be able to update your app without it.
- **NEVER commit it to git!** (already in .gitignore)
- Back it up somewhere safe (encrypted cloud storage, password manager, etc.)

### Step 2: Configure Signing

Create a file `mobile/android/key.properties` with your passwords:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=app/upload-keystore.jks
```

Replace `YOUR_KEYSTORE_PASSWORD` and `YOUR_KEY_PASSWORD` with the passwords you just created.

**IMPORTANT**: This file is in .gitignore - never commit it!

### Step 3: Verify Setup

Check that these files exist:
- ✅ `mobile/android/app/upload-keystore.jks`
- ✅ `mobile/android/key.properties`

## Building Release APK

### Quick Build (Recommended)

From the `mobile` directory:

```bash
flutter build apk --release
```

This creates a **split APK** (optimized for each CPU architecture).

**Output location:**
```
mobile/build/app/outputs/flutter-apk/app-release.apk
```

**File size**: ~20-30 MB (optimized)

### Full Build (Universal APK)

If you need a single APK that works on all devices:

```bash
flutter build apk --release --split-per-abi
```

This creates separate APKs for each architecture:
- `app-arm64-v8a-release.apk` (modern 64-bit devices - **use this one**)
- `app-armeabi-v7a-release.apk` (older 32-bit devices)
- `app-x86_64-release.apk` (emulators)

**Recommended**: Use `app-arm64-v8a-release.apk` for most modern phones.

### Alternative: Universal APK (Larger File)

For a single APK that works on all devices (larger file size):

```bash
flutter build apk --release --no-split-per-abi
```

**File size**: ~40-60 MB (includes all architectures)

## Installing on Your Phone

### Method 1: Direct USB Transfer

1. Connect phone via USB
2. Copy APK to phone's Downloads folder
3. On phone: Open **Files** app → **Downloads**
4. Tap the APK file
5. Tap **Install**
6. If prompted, allow "Install from unknown sources" for that app

### Method 2: Cloud Transfer

1. Upload APK to Google Drive, Dropbox, etc.
2. On phone: Download the APK
3. Open the downloaded APK
4. Tap **Install**

### Method 3: ADB Install (via USB)

```bash
adb install mobile/build/app/outputs/flutter-apk/app-release.apk
```

## Updating the App

When you make changes and want to release a new version:

### Step 1: Update Version Number

Edit `mobile/pubspec.yaml`:

```yaml
version: 1.0.1+2  # Format: version+buildNumber
```

- **1.0.1**: User-visible version (increment for updates)
- **+2**: Build number (increment for every build)

### Step 2: Rebuild

```bash
flutter build apk --release
```

### Step 3: Uninstall Old Version (if needed)

If the new version won't install over the old one:

1. On phone: Settings → Apps → Job Application Tracker
2. Tap **Uninstall**
3. Install the new APK

**Note**: This will delete local data! Make sure to sync first.

## Troubleshooting

### Error: "keystore file not found"

Make sure `mobile/android/key.properties` points to the correct path:
```properties
storeFile=app/upload-keystore.jks
```

### Error: "App not installed"

- Uninstall the old version first
- Make sure you're using the correct APK for your device architecture

### Error: "Passwords don't match"

Check that `key.properties` has the correct passwords from when you created the keystore.

### Build Fails with ProGuard Errors

If the release build crashes or behaves strangely:

1. Disable minification temporarily:
   Edit `mobile/android/app/build.gradle.kts`:
   ```kotlin
   isMinifyEnabled = false
   isShrinkResources = false
   ```

2. Rebuild and test
3. If that fixes it, we need to update ProGuard rules

## Release Checklist

Before building a release:

- [ ] Test thoroughly on emulator/debug build
- [ ] Verify Google Sign-In works
- [ ] Verify sync works correctly
- [ ] Update version number in `pubspec.yaml`
- [ ] Clean build: `flutter clean && flutter pub get`
- [ ] Build release: `flutter build apk --release`
- [ ] Test release APK on real device
- [ ] Backup keystore file

## Security Notes

**Keep these SECRET**:
- ✅ `upload-keystore.jks` - Your signing key
- ✅ `key.properties` - Your passwords
- ✅ Keystore password
- ✅ Key password

**Safe to share**:
- ✅ The release APK file
- ✅ `key.properties.example` (template with no passwords)

## Google Play Store (Optional)

If you want to publish to the Play Store instead:

1. Create Google Play Developer account ($25 one-time fee)
2. Build an **App Bundle** instead of APK:
   ```bash
   flutter build appbundle --release
   ```
3. Upload to Google Play Console
4. Fill out store listing (description, screenshots, etc.)
5. Submit for review

**App Bundle location:**
```
mobile/build/app/outputs/bundle/release/app-release.aab
```

## Current App Information

**Package Name**: `com.jobtracker.job_tracker_mobile`
**Current Version**: Check `mobile/pubspec.yaml`

## Questions?

- Flutter build docs: https://docs.flutter.dev/deployment/android
- Android signing: https://developer.android.com/studio/publish/app-signing
