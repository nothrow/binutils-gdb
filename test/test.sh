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
LIBPATH=${ROOT}/sysroot/opt/freeware/lib/pthread/
export AS CC CXX LIBPATH

cp ${ROOT}sysroot/opt/freeware/lib/gcc/powerpc-ibm-aix*/*/*.o .
make clean
make -k
