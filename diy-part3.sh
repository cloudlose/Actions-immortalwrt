#!/bin/bash
#
# hlk7628n dts
mkdir -p target/linux/ramips/dts/
cp -f "$GITHUB_WORKSPACE/dts/mt7628an_hilink_hlk-7628n.dts" target/linux/ramips/dts/mt7628an_hilink_hlk-7628n.dts


# turboacc
curl -sSL https://raw.githubusercontent.com/mufeng05/turboacc/main/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh 24.10
