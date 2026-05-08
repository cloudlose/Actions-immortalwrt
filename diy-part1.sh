#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

# 8916dts
mkdir -p target/linux/msm89xx/dts/
cp -f "$GITHUB_WORKSPACE/scripts/dts/msm8916.dtsi" "target/linux/msm89xx/dts/msm8916.dtsi"

# aic8800
sed -i -e 's/aic8800DC_fdrv\.ko/aic8800_fdrv.ko/g' -e 's/aic_load_fw aic8800DC_fdrv/aic_load_fw aic8800_fdrv/g' package/kernel/aic8800/Makefile


# OpenClash
# git clone --depth 1 https://github.com/vernesong/OpenClash.git OpenClash

# turboacc
curl -sSL https://raw.githubusercontent.com/mufeng05/turboacc/main/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh

# 调试
sed -i 's|src-git-full openstick https://github.com/lkiuyu/openstick-feeds.git|src-git-full openstick https://github.com/xuxin1955/openstick-feeds|g' feeds.conf.default

# test
# cat > feeds.conf.default << 'EOF'
# src-git packages https://github.com/immortalwrt/packages.git;openwrt-25.12
# src-git luci https://github.com/immortalwrt/luci.git;openwrt-25.12
# src-git routing https://github.com/openwrt/routing.git;openwrt-25.12
# src-git telephony https://github.com/openwrt/telephony.git;openwrt-25.12
# src-git video https://github.com/openwrt/video.git;openwrt-25.12
# src-git-full openstick https://github.com/xuxin1955/openstick-feeds.git
# EOF

# inspect
echo ">>> OPP VOLTAGE COUNT: $(grep -c 'opp-microvolt' target/linux/msm89xx/dts/msm8916.dtsi) <<<"

# aic8800
grep -n "aic8800_fdrv\|aic8800DC_fdrv" package/kernel/aic8800/Makefile
