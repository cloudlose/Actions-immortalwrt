#!/bin/bash


# hlk7628dna dts
mkdir -p target/linux/ramips/dts/
cp -f "$GITHUB_WORKSPACE/scripts/dts/mt7628an_hilink_hlk-7628dna.dts" "target/linux/ramips/dts/mt7628an_hilink_hlk-7628dna.dts"

# hlk7628dna mk
mkdir -p target/linux/ramips/image/
cp -f "$GITHUB_WORKSPACE/scripts/image/mt76x8.mk" "target/linux/ramips/image/mt76x8.mk"
