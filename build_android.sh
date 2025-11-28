#!/bin/bash

# Build livekit-ffi for Android targets
# This script compiles the library for multiple Android architectures

set -e

cd ./rust-sdks/livekit-ffi

echo "Building livekit-ffi for Android..."

# Build for Android architectures
cargo ndk \
    -t armeabi-v7a \
    -t arm64-v8a \
    -t x86 \
    -t x86_64 \
    -o ./jniLibs \
    build --release

echo "✓ Android build completed successfully!"
echo "Libraries are located in: ./jniLibs"
