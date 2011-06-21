# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

SRC_URI="http://gentoo-vala.googlecode.com/files/${PN}-${PVR}.tar.bz2"
DESCRIPTION="ValaTerm is a lightweigth terminal written in Vala"
HOMEPAGE="https://gitorious.org/valaterm/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"

RDEPEND=">=x11-libs/gtk+-2.16:2
	>=x11-libs/vte-0.20:0"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.10
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_configure() {
	./waf configure --prefix=/usr || die "Configure failed !"
}

src_compile() {
	./waf build || die "Build failed !"
}

src_install() {
	./waf install --destdir=${D} || die "Install failed !"
}