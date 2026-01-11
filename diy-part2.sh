#!/bin/bash

# 1. 修改默认管理 IP (可选，如果你想改成 192.168.2.1)
# sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2. 强制锁定 K2P 硬件架构（多重保险）
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y" >> .config

# 3. 开启 Sing-box 唯一核心方案（方案 B）
# 强制选中 Sing-box 及其 Luci 支持
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Sing_Box=y" >> .config
echo "CONFIG_PACKAGE_sing-box=y" >> .config

# 强制剔除 Xray/V2ray 等占用空间巨大的核心
sed -i 's/CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Core=y/# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Core is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Core=y/# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Core is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geodata=y/# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geodata is not set/' .config

# 4. 极致瘦身策略（关键）
# 开启二进制 UPX 压缩，这是 Sing-box 能进 K2P 的唯一机会
echo "CONFIG_SING_BOX_COMPRESS_UPX=y" >> .config
echo "CONFIG_USE_SSTRIP=y" >> .config

# 彻底移除 K2P 用不到的组件（Docker、打印服务器、USB 驱动等）
sed -i 's/CONFIG_PACKAGE_luci-app-docker=y/# CONFIG_PACKAGE_luci-app-docker is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-usb-printer=y/# CONFIG_PACKAGE_luci-app-usb-printer is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-samba=y/# CONFIG_PACKAGE_luci-app-samba is not set/' .config

# 5. 修改无线名称为 PDCN (初始生效)
sed -i 's/OpenWrt/PDCN/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
