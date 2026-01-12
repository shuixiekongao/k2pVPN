#!/bin/bash

# 1. 修改 DTS 分区定义 (将 firmware 分区从 16MB 扩展至 32MB)
# 这一步是让内核知道闪存有 32MB 空间
sed -i 's/<0x50000 0xfb0000>/<0x50000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts

# 2. 修改 Image Makefile (解除编译时的体积检查限制)
# 这一步是防止出现 "Image too big" 错误而导致不生成 bin 文件
# 针对不同版本的 LEDE/OpenWrt 源码，尝试匹配多种可能的原始数值
sed -i 's/IMAGE_SIZE := 16064k/IMAGE_SIZE := 32448k/g' target/linux/ramips/image/mt7621.mk
sed -i 's/IMAGE_SIZE := 16128k/IMAGE_SIZE := 32448k/g' target/linux/ramips/image/mt7621.mk
sed -i 's/IMAGE_SIZE := 15872k/IMAGE_SIZE := 32448k/g' target/linux/ramips/image/mt7621.mk

# 3. 极致瘦身：剔除无用大文件，确保编译能通过
# 即使扩容了，也建议开启 UPX 压缩，否则系统运行会很卡
echo "CONFIG_SING_BOX_COMPRESS_UPX=y" >> .config
echo "CONFIG_V2RAY_COMPRESS_UPX=y" >> .config
echo "CONFIG_GEOVIEW_COMPRESS_UPX=y" >> .config

# 4. 再次确认架构锁定
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621=y" >> .config
echo "CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y" >> .config
