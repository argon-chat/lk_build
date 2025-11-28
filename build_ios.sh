#!/bin/bash

# Build livekit-ffi for iOS targets
# This script compiles the library for iOS device and simulator architectures

set -e

cd ./rust-sdks/livekit-ffi

echo "Building livekit-ffi for iOS..."

# Build for iOS device (ARM64)
echo "Building for iOS device (aarch64-apple-ios)..."
cargo build --release --target aarch64-apple-ios

# Build for iOS simulator (ARM64)
echo "Building for iOS simulator (aarch64-apple-ios-sim)..."
cargo build --release --target aarch64-apple-ios-sim

# Build for iOS simulator (x86_64) - for Intel Mac simulators
# echo "Building for iOS simulator (x86_64-apple-ios)..."
# cargo build --release --target x86_64-apple-ios

echo "✓ iOS build completed successfully!"
echo ""
echo "Libraries are located in:"
echo "  - Device:        ../target/aarch64-apple-ios/release/liblivekit_ffi.a"
echo "  - Simulator ARM: ../target/aarch64-apple-ios-sim/release/liblivekit_ffi.a"
echo "  - Simulator x64: ../target/x86_64-apple-ios/release/liblivekit_ffi.a"
echo ""
echo "To create an XCFramework, you can use xcodebuild -create-xcframework"
