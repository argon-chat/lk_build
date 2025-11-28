# Building livekit-ffi for Android and iOS

This guide explains how to build the `livekit-ffi` library for Android and iOS platforms.

## Prerequisites

### For Both Platforms
- Rust toolchain installed
- Required Rust targets (already installed):
  - Android: `aarch64-linux-android`, `armv7-linux-androideabi`, `i686-linux-android`, `x86_64-linux-android`
  - iOS: `aarch64-apple-ios`, `aarch64-apple-ios-sim`, `x86_64-apple-ios`

### For Android
- **Android NDK** is required
- Install via Android Studio or standalone:
  - Download from: https://developer.android.com/ndk/downloads
  - Set `ANDROID_NDK_HOME` environment variable to the NDK root directory

**Example NDK setup:**
```bash
# If using Android Studio, the NDK is typically located at:
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk/<version>"

# Or download standalone NDK and set:
export ANDROID_NDK_HOME="/path/to/android-ndk-r26d"
```

Add this to your `~/.zshrc` or `~/.bashrc` to make it permanent:
```bash
echo 'export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk/<version>"' >> ~/.zshrc
source ~/.zshrc
```

### For iOS
- **Full Xcode installation** (not just Command Line Tools)
- Install Xcode from the App Store
- After installation, set Xcode as the active developer directory:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

## Build Scripts

Two build scripts have been created in the `livekit-ffi` directory:

### 1. `build_android.sh` - Build for Android
Compiles the library for multiple Android architectures:
- `armeabi-v7a` (ARM 32-bit)
- `arm64-v8a` (ARM 64-bit)
- `x86` (Intel 32-bit)
- `x86_64` (Intel 64-bit)

**Usage:**
```bash
./build_android.sh
```

Output will be in `./jniLibs/` directory, organized by architecture.

### 2. `build_ios.sh` - Build for iOS
Compiles the library for iOS device and simulator architectures:
- `aarch64-apple-ios` (iOS device ARM64)
- `aarch64-apple-ios-sim` (iOS simulator ARM64)
- `x86_64-apple-ios` (iOS simulator x86_64)

**Usage:**
```bash
./build_ios.sh
```

Output will be in:
- `../target/aarch64-apple-ios/release/liblivekit_ffi.a`
- `../target/aarch64-apple-ios-sim/release/liblivekit_ffi.a`
- `../target/x86_64-apple-ios/release/liblivekit_ffi.a`

## Creating an XCFramework (Optional)

After building for iOS, you can create an XCFramework for easier distribution:

```bash
# Create a universal simulator binary
lipo -create \
  ../target/aarch64-apple-ios-sim/release/liblivekit_ffi.a \
  ../target/x86_64-apple-ios/release/liblivekit_ffi.a \
  -output ../target/liblivekit_ffi_sim.a

# Create XCFramework
xcodebuild -create-xcframework \
  -library ../target/aarch64-apple-ios/release/liblivekit_ffi.a \
  -headers ./include/ \
  -library ../target/liblivekit_ffi_sim.a \
  -headers ./include/ \
  -output ../target/LiveKitFFI.xcframework
```

## Troubleshooting

### Android Build Issues
- **Error: "Could not find any NDK"**
  - Ensure `ANDROID_NDK_HOME` is set correctly
  - Verify the NDK is installed: `ls $ANDROID_NDK_HOME`

### iOS Build Issues
- **Error: "SDK 'iphoneos' cannot be located"**
  - Install full Xcode (not just Command Line Tools)
  - Run: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
  - Open Xcode once to complete installation
  - Accept license: `sudo xcodebuild -license accept`

- **Error: "tool 'xcodebuild' requires Xcode"**
  - You have Command Line Tools but not full Xcode
  - Install Xcode from the App Store

## Current Status

✅ **Completed:**
- Rust targets installed for Android and iOS
- `cargo-ndk` tool installed
- Build scripts created (`build_android.sh` and `build_ios.sh`)
- Scripts are executable and ready to use

⚠️ **Required before building:**
- **Android**: Install Android NDK and set `ANDROID_NDK_HOME`
- **iOS**: Install full Xcode and configure developer directory

## Next Steps

1. **For Android development:**
   - Install Android NDK
   - Set `ANDROID_NDK_HOME` environment variable
   - Run `./build_android.sh`

2. **For iOS development:**
   - Install Xcode from App Store
   - Run `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
   - Open Xcode and accept license
   - Run `./build_ios.sh`
