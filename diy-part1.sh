#!/bin/bash
# 添加 helloworld 源 (可选)
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 【关键】取消注释并添加 PassWall 源及其依赖包源
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
