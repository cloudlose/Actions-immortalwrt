#!/bin/bash

# 8916dts
mkdir -p target/linux/msm89xx/dts/
cp -f "$GITHUB_WORKSPACE/scripts/dts/msm8916.dtsi" "target/linux/msm89xx/dts/msm8916.dtsi"

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

# test
cat << 'EOF' > target/linux/msm89xx/patches-6.12/999-support-wcn36xx-concurrency.patch
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@
+static const struct wiphy_iface_combination wcn36xx_iface_combos[] = {
+	{
+		.limits = {
+			{ .type = NL80211_IFTYPE_STATION, .max = 1 },
+			{ .type = NL80211_IFTYPE_AP, .max = 1 },
+		},
+		.n_limits = 2,
+		.max_interfaces = 2,
+	},
+};
+
 static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 {
 	static const u32 cipher_suites[] = {
@@
 	wiphy_ext_feature_set(wcn->hw->wiphy,
 			      NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
+	wcn->hw->wiphy->iface_combinations = wcn36xx_iface_combos;
+	wcn->hw->wiphy->n_iface_combinations = ARRAY_SIZE(wcn36xx_iface_combos);
+
 	return 0;
 }
EOF







# inspect
echo ">>> OPP VOLTAGE COUNT: $(grep -c 'opp-microvolt' target/linux/msm89xx/dts/msm8916.dtsi) <<<"
