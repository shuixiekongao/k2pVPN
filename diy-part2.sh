#!/bin/bash

# 1. 修改 DTS 分区定义 (将 firmware 扩展至 32MB)
# 修复之前日志中 25MB > 16MB 的溢出问题
sed -i 's/<0x50000 0xfb0000>/<0x50000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts

# 2. 修改 Image Makefile (解除 16MB 体积检查限制)
sed -i 's/IMAGE_SIZE := 16064k/IMAGE_SIZE := 32448k/g' target/linux/ramips/image/mt7621.mk
sed -i 's/IMAGE_SIZE := 16128k/IMAGE_SIZE := 32448k/g' target/linux/ramips/image/mt7621.mk

# 3. 锁定 K2P 硬件架构及无线驱动 (确保 ra0 可搜到)
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y" >> .config
echo "CONFIG_PACKAGE_kmod-mt7621-wm=y" >> .config
echo "CONFIG_PACKAGE_luci-app-mtwifi=y" >> .config

# 4. 修改默认 SSID 为 PDCN
sed -i 's/OpenWrt/PDCN/g' package/base-files/files/bin/config_generate
