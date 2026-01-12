#!/bin/bash
# 移除旧版核心
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,geoview,hysteria,v2ray-plugin,xray-plugin}

# 克隆最新依赖包和 LuCI 界面
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages
git clone https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci
