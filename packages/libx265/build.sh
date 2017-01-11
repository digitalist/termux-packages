TERMUX_PKG_HOMEPAGE=http://x265.org/
TERMUX_PKG_DESCRIPTION="H.265/HEVC video stream encoder library"
TERMUX_PKG_VERSION=2.2
TERMUX_PKG_SRCURL=http://ftp.videolan.org/pub/videolan/x265/x265_${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=b872552535e41fbffa03ba7cbcd3479c42c4053868309292e78e147b7773ac4b
TERMUX_PKG_FOLDERNAME=x265_$TERMUX_PKG_VERSION

termux_step_configure () {
	cd $TERMUX_PKG_BUILDDIR

	CMAKE_EXTRA_OPTS=""
	if [ $TERMUX_ARCH = "i686" ]; then
		# Avoid text relocations.
		CMAKE_EXTRA_OPTS="-DENABLE_ASSEMBLY=OFF"
	fi

	cmake -G "Unix Makefiles" $TERMUX_PKG_SRCDIR/source \
		-DCMAKE_AR=`which ${TERMUX_HOST_PLATFORM}-ar` \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_CROSSCOMPILING=True \
		-DCMAKE_SYSTEM_PROCESSOR=$TERMUX_ARCH \
		-DCMAKE_C_FLAGS="$CFLAGS $CPPFLAGS" \
		-DCMAKE_CXX_FLAGS="$CXXFLAGS" \
		-DCMAKE_FIND_ROOT_PATH=$TERMUX_PREFIX \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX \
		-DCMAKE_LINKER=`which ${TERMUX_HOST_PLATFORM}-ld` \
		-DCMAKE_MAKE_PROGRAM=`which make` \
		-DCMAKE_RANLIB=`which ${TERMUX_HOST_PLATFORM}-ranlib` \
		-DCMAKE_SYSTEM_NAME=Android \
		$CMAKE_EXTRA_OPTS
}