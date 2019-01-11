SUMMARY = "This is a simple library used for userspace, which manages multi-chip sync, on platforms (FMCOMMS5) where multiple AD9361 devices are used."
AUTHOR = "Carles Fernandez-Prades <carles.fernandez@cttc.es>"
HOMEPAGE = "https://github.com/analogdevicesinc/libad9361-iio"
LICENSE = "LGPL-2.1"
LIC_FILES_CHKSUM = "file://LICENSE;md5=40d2542b8c43a3ec2b7f5da31a697b88"

PV = "0.1"

DEPENDS = "libiio"

SRCREV = "ac3651abb2706c647ef76b65f14b0e11d714125c"

SRC_URI = "git://github.com/analogdevicesinc/libad9361-iio"

S="${WORKDIR}/git"

inherit distutils-base cmake pkgconfig

FILES_${PN}-dev += " \
  ${libdir}/pkgconfig/libad9361.pc \
"

FILES_{PN}-dbg += " \
  /usr/src/debug/* \
  /usr/lib/.debug/* \
"
