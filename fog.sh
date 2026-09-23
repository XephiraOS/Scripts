#!/bin/bash

rm -rf .repo/local_manifests/
repo init -u https://github.com/XephiraOS/android.git -b lineage-23.2 --git-lfs --depth=1
git clone https://github.com/XephiraOS/local_manifests.git -b main .repo/local_manifests
/opt/crave/resync.sh
rm -rf hardware/google/pixel/kernel_headers/Android.bp
. build/envsetup.sh
lunch aosp_cf_x86_64_phone-trunk_staging-userdebug
m bacon
