#!/bin/bash

rm -rf .repo/local_manifests/
repo init -u https://github.com/XephiraOS/android.git -b lineage-23.2 --git-lfs --depth=1
git clone https://github.com/Project-Nightcord/manifesto.git -b lineage-23.2 .repo/local_manifests
/opt/crave/resync.sh

rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Apply patch only if not already applied
PATCH="$PWD/.repo/local_manifests/build/make/0001-build-Automatically-replace-old-style-kernel-header-.patch"
TARGET="build/make"

if git -C "$TARGET" apply --reverse --check "$PATCH" >/dev/null 2>&1; then
    echo "Patch already applied, skipping."
elif git -C "$TARGET" apply --check "$PATCH" >/dev/null 2>&1; then
    git -C "$TARGET" apply "$PATCH" && echo "Patch applied."
else
    echo "Patch cannot be applied (conflict). Check manually."
    exit 1
fi

. build/envsetup.sh
lunch lineage_ysl-bp4a-user
m bacon
