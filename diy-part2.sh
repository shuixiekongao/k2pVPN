#!/bin/bash
# 1. 强制纠正硬件架构
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y" >> .config

# 2. 强制开启 Sing-box 并启用极致压缩 (UPX)
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Sing_Box=y" >> .config
echo "CONFIG_PACKAGE_sing-box=y" >> .config
echo "CONFIG_SING_BOX_COMPRESS_UPX=y" >> .config

# 3. 删掉占空间的“累赘”，保住 32MB 闪存底线
sed -i 's/CONFIG_PACKAGE_luci-app-docker=y/# CONFIG_PACKAGE_luci-app-docker is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-v2ray-server=y/# CONFIG_PACKAGE_luci-app-v2ray-server is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-ssr-native=y/# CONFIG_PACKAGE_luci-app-ssr-native is not set/' .config
# 移除所有 Xray/V2ray 核心，只留 Sing-box
sed -i 's/CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Core=y/# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Core is not set/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Core=y/# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Core is not set/' .config

# 4. 修改默认 SSID 为 PDCN (确保无线能搜到)
sed -i 's/OpenWrt/PDCN/g' package/base-files/files/bin/config_generate

# 5. 强制集成 LuCI 界面，防止出现 Nginx 欢迎页
echo "CONFIG_PACKAGE_luci=y" >> .config
echo "CONFIG_PACKAGE_luci-theme-bootstrap=y" >> .config
