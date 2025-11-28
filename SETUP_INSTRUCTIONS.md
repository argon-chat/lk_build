# Mobile Build Setup Instructions

## Current Issues

### Android Build Requirements
- **Missing:** Android NDK (Native Development Kit)
- **Error:** `Could not find any NDK`

### iOS Build Requirements
- **Missing:** Full Xcode installation with iOS SDK
- **Current:** Only Command Line Tools installed
- **Error:** `SDK "iphoneos" cannot be located`

## Setup Steps

### Option 1: Install Android NDK (for Android builds)

1. **Install Android Studio** (recommended):
   - Download from: https://developer.android.com/studio
   - Open Android Studio → Settings → SDK Manager → SDK Tools
   - Check "NDK (Side by side)" and install

2. **Set environment variable**:
   ```bash
   export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/<version>
   # Add to ~/.zshrc to make permanent:
   echo 'export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/<version>' >> ~/.zshrc
   ```

3. **Or install via command line**:
   ```bash
   brew install --cask android-ndk
   # Or use sdkmanager:
   sdkmanager --install "ndk;26.1.10909125"
   ```

### Option 2: Install Xcode (for iOS builds)

1. **Install Xcode from Mac App Store** (required for iOS SDK):
   - Open App Store
   - Search for "Xcode"
   - Download and install (this is large, ~15GB)

2. **Switch to Xcode developer tools**:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   ```

3. **Accept license**:
   ```bash
   sudo xcodebuild -license accept
   ```

4. **Verify iOS SDK**:
   ```bash
   xcodebuild -showsdks | grep -i ios
   ```

## Quick Test After Setup

### Test Android Build:
```bash
./build_android.sh
```

### Test iOS Build:
```bash
./build_ios.sh
```

## Alternative: Build Without Mobile SDKs

If you don't need mobile builds right now, you can build the regular library:

```bash
cargo build --release
```

This will build for your current platform (macOS) without requiring Android NDK or iOS SDK.
