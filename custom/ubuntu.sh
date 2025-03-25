#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) ImmortalWrt.org

function install_mustrelyon(){
# 安装编译openwrt的依赖
${INS} update > /dev/null 2>&1

#${INS} full-upgrade > /dev/null 2>&1

${INS} install ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache clang cmake cpio curl device-tree-compiler flex gawk gcc-multilib g++-multilib gettext \
genisoimage git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev \
libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev \
libreadline-dev libssl-dev libtool llvm lrzsz msmtp ninja-build p7zip p7zip-full patch pkgconf \
python3 python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion \
swig texinfo uglifyjs unzip vim wget xmlto xxd zlib1g-dev

# N1打包需要的依赖
${INS} install rename pigz clang upx-ucl

# 安装gcc-13
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa
${INS} update > /dev/null 2>&1
${INS} install gcc-13
${INS} install g++-13
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 60 --slave /usr/bin/g++ g++ /usr/bin/g++-13
gcc --version
g++ --version
clang --version
}

function update_apt_source(){
${INS} autoremove --purge
${INS} clean
}

function main(){
	if [[ -n "${BENDI_VERSION}" ]]; then
		export BENDI_VERSION="1"
		INS="sudo apt-get -y"
		echo "开始升级ubuntu插件和安装依赖....."
		install_mustrelyon
		update_apt_source
	else
		INS="sudo apt-get -y"
                echo "开始升级ubuntu插件和安装依赖....."
		install_mustrelyon
		update_apt_source
	fi
}

main
