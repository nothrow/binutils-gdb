#!/bin/bash -eu

function error()
{
  echo $*
  exit 2
}

FILE=$(dirname $0)/exceptions_asm.o

xxd ${FILE} | grep -q "0000 002c" || error "Failed to find FDE length"
xxd ${FILE} | grep -q "0000 0024" || error "Failed to find FDE CIE Offset"
xxd ${FILE} | grep -q "ffff fe68" || error "Failed to find FDE initial location"
xxd ${FILE} | grep -q "0000 0078" || error "Failed to find FDE address range"

echo "All OK"
