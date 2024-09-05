# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ETYPE="sources"
K_NOUSENAME="yes"
K_SECURITY_UNSUPPORTED="yes"

inherit kernel-2 unpacker
detect_version

MVJ_MAJ="${PR:1:1}"
MVJ_MIN="${PR:2:1}"
MVJ_REV="${PR:3:2}"
MVJ_VER="${MVJ_MAJ}.${MVJ_MIN}.${MVJ_REV#0}"

DESCRIPTION="The out-of-tree kernel for the MilkV Jupiter"
HOMEPAGE="https://github.com/milkv-jupiter/linux-6.1"
SRC_URI="
	https://github.com/milkv-jupiter/linux-6.1/archive/refs/tags/v${MVJ_VER}.tar.gz -> ${PF}.tar.gz
"

LICENSE=""
SLOT="0"
KEYWORDS="~riscv"

DEPEND="
	dev-embedded/u-boot-tools
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unpacker "${PF}.tar.gz"
	mv "linux-${KV_MAJOR}.${KV_MINOR}-${MVJ_VER}" "${WORKDIR}/linux-${PVR}"
}

pkg_postinst() {
	elog
	elog "Kernel sources have been installed."
	elog "Set them as active kernel sources via"
	elog "	\`eselect kernel\`"
	elog "Then they can be compiled by going to"
	elog "	/usr/src/linux"
	elog "and running"
	elog "	\`make\`"
	elog "To install the kernel, copy over"
	elog "	/usr/src/linux/arch/riscv/boot/Image.gz.itb"
	elog "to the bootfs as vmlinuz"
	elog "Also copy over all files from"
	elog "	/usr/src/linux/arch/riscv/boot/dts/spacemit/*.dtb"
	elog "After all that adjust the env file in the bootfs accordingly"
	elog
}

