#!/bin/sh -eu

if [ ${#} -lt 1 ];
then
    echo "Usage: $(basename $0) <path to target toolchain>"
    exit 2
fi

ROOT=$1
TARGET=`find ${ROOT}/bin -name *-readelf | sed s/-readelf//g`

AS="${TARGET}-as"
CC="${TARGET}-gcc"
CXX="${TARGET}-g++"
LIBPATH=-L${ROOT}/sysroot/opt/freeware/lib/pthread/
CFLAGS=""
CXXFLAGS=""
export AS CC CXX LIBPATH CXXFLAGS

make clean
make -k

CFLAGS="-maix64 ${CFLAGS}"
CXXFLAGS="-maix64 ${CXXFLAGS}"
export CFLAGS CXXFLAGS

echo "Testing 64-bit"
make clean
make -k
