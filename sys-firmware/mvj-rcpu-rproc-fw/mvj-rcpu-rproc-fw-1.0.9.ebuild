# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmware necessary to have the MilkV Jupiter boot"
HOMEPAGE="https://github.com/milkv-jupiter/buildroot-ext"
SRC_URI="
	https://github.com/milkv-jupiter/buildroot-ext/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE=""
SLOT="0"
KEYWORDS="~riscv"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/buildroot-ext-${PV}"


src_install() {
	insinto /lib/firmware
	doins "board/spacemit/k1/target_overlay/lib/firmware/esos.elf"

	insinto /etc/dracut.conf.d
	doins "${FILESDIR}/dracut-mvj-rcpu-rproc-fw-r1.conf"
}


