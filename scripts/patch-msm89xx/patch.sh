#!/bin/bash
set -e

SRC="$(cd "$(dirname "$0")" && pwd)"
BASE="$(cd "$SRC/../.." && pwd)"
OPENWRT="$BASE/openwrt"

cp -r "$SRC/target/." "$OPENWRT/target/"
cp -r "$SRC/package/." "$OPENWRT/package/" 2>/dev/null || true

ls "$OPENWRT/target/linux/msm89xx" || echo "msm89xx not found"
