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
CXXFLAGS=""
export AS CC CXX LIBPATH CXXFLAGS

make clean
make -k
