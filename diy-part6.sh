#!/bin/bash

# Modify default IP
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# hlk7628dna dts
mkdir -p target/linux/ramips/dts/
cp -f "$GITHUB_WORKSPACE/scripts/dts/mt7628an_hilink_hlk-7628d.dts" "target/linux/ramips/dts/mt7628an_hilink_hlk-7628d.dts"

# hlk7628dna mk
mkdir -p target/linux/ramips/image/
cp -f "$GITHUB_WORKSPACE/scripts/image/mt76x8.mk" "target/linux/ramips/image/mt76x8.mk"

# hlk7628dna board.d
mkdir -p "target/linux/ramips/mt76x8/base-files/etc/board.d/"
cp -f "$GITHUB_WORKSPACE/scripts/image/02_network" "target/linux/ramips/mt76x8/base-files/etc/board.d/02_network"


# hlk7628dna (LEDs配置)
mkdir -p "target/linux/ramips/mt76x8/base-files/etc/board.d/"
cp -f "$GITHUB_WORKSPACE/scripts/image/01_leds" "target/linux/ramips/mt76x8/base-files/etc/board.d/01_leds"



# 写入北大 ImmortalWrt APK 源
mkdir -p package/base-files/files/etc/apk

cat > package/base-files/files/etc/apk/repositories << 'EOF'
# This file is auto-generated and build-specific, any changes will be intentionally lost in sysupgrade.
# Add your custom feeds to /etc/apk/repositories.d/customfeeds.list
https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/ramips/mt76x8/packages/packages.adb
https://mirrors.pku.edu.cn/immortalwrt/snapshots/packages/mipsel_24kc/base/packages.adb
https://mirrors.pku.edu.cn/immortalwrt/snapshots/packages/mipsel_24kc/luci/packages.adb
https://mirrors.pku.edu.cn/immortalwrt/snapshots/packages/mipsel_24kc/packages/packages.adb
https://mirrors.pku.edu.cn/immortalwrt/snapshots/packages/mipsel_24kc/routing/packages.adb
https://mirrors.pku.edu.cn/immortalwrt/snapshots/packages/mipsel_24kc/telephony/packages.adb
EOF