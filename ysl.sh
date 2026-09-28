#!/bin/bash

rm -rf .repo/local_manifests/
repo init -u https://github.com/XephiraOS/android.git -b lineage-23.2 --git-lfs --depth=1
git clone https://github.com/Project-Nightcord/manifesto.git -b lineage-23.2 .repo/local_manifests
/opt/crave/resync.sh
rm -rf hardware/google/pixel/kernel_headers/Android.bp
. build/envsetup.sh
lunch lineage_ysl-bp4a-user
m bacon
