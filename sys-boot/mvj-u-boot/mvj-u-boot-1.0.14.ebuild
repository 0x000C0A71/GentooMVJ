# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig

DESCRIPTION="MilkV's U-Boot. Uses savedconfig -> you can edit the config"
HOMEPAGE="https://github.com/milkv-jupiter/uboot-2022.10"
SRC_URI="
	https://github.com/milkv-jupiter/uboot-2022.10/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE=""
SLOT="0"
KEYWORDS="~riscv"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	sys-apps/dtc
"

UBOOT_BLOB_DIR="/boot/u-boot-blobs"

S="${WORKDIR}/uboot-2022.10-${PV}"

src_prepare() {
	if use savedconfig ; then
		restore_config .config
	else
		emake k1_defconfig
	fi

	default
}

src_compile() {

	emake
	emake u-boot.itb
}

src_install() {
	insinto ${UBOOT_BLOB_DIR}
	doins FSBL.bin
	doins u-boot-env-default.bin
	doins u-boot.itb

	save_config .config
}

pkg_postinst() {
	elog
	elog "All the compiled blobs have been saved to"
	elog "	${UBOOT_BLOB_DIR}"
	elog "Now it is up to you to flash them!"
	elog
}



