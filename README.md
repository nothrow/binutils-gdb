# binutils-gdb for AIX

## What is this?

Its a work-in-progress fork of binutils to support AIX XCOFF to enable cross-compiling AIX C/C++ on Linux.

## Why does it exist?

Developing on AIX is non-trivial and requires a dedicated power machine. Cross-compiling for development purposes allows a faster write-compile-test loop as only the testing portion requires an SSH connection to a real machine.

The goal is to be able to get binaries that work more often than not for dev and test. Production use of this is not on the cards.

## Where has it got so far?

It creates object files that can be linked with both the AIX linker and the GNU linker. And fixes these bugs:

* [19153](https://sourceware.org/bugzilla/show_bug.cgi?id=19153)
* [21700](https://sourceware.org/bugzilla/show_bug.cgi?id=21700)

However... these results are often wrong:

* [x] Compiles 32-bit \*.c and \*.cpp files (gcc 7.3.0)
* [x] 32-bit hello world in C (gcc 7.3.0)
* [x] 32-bit exception catching in C++ from source (gcc 7.3.0 + IBM linker)
* [ ] 32-bit exception catching in C++ from source (gcc 7.3.0)
  * Fails with relocation errors
* [ ] Compiles 64-bit \*.c and \*.cpp files
  * Illegal instruction
* [ ] 64-bit hello world in C
  * Illegal instruction
* [ ] 64-bit hello world in C++
  * Illegal instruction

## How do I build it?

*Note:* These instructions will build a toolchain in the current directory called `aix6.1-toolchain`. For just the binutils you don't need to fill the sysroot, for testing alongside gcc you need a sysroot from a working AIX box.

```
$ git clone https://github.com/JamesReynolds/binutils-gdb
$ mkdir build_binutils
$ cd build_binutils
$ ../binutils-gdb/configure --target=powerpc-ibm-aix6.1 \
               --prefix=$(pwd)/../aix6.1-toolchain \
               --with-sysroot=$(pwd)/../aix6.1-toolchain/sysroot
$ make
$ make install
```

## How do I test it?

* Fill the sysroot directory by finding files on an AIX box that has gcc 7.3.0 installed:

```
AIX $ cd / ; find ./ -name *.o -o -name *.h -o -name *.exp -o -name *.a -name *.so | cpio -oLV > out.cpio
Linux $ cd $(pwd)/aix6.1-toolchain/sysroot ; cpio -imdV < out.cpio 
```

* Build gcc 7.3.0

```
$ tar xf gcc-7.3.0.tar.gz
$ mkdir build_gcc
$ cd build_gcc
$ ../gcc-7.3.0/configure \
    --target=powerpc-ibm-aix6.1 \
    --prefix=$(pwd)/../aix6.1-toolchain \
    --with-sysroot=$(pwd)/../aix6.1-toolchain/sysroot \
    --with-gnu-as --with-gnu-ld \
    --enable-languages=c,c++ \
    --enable-version-specific-runtime-libs --disable-nls \
    --enable-decimal-float=dpd --with-cloog=no --with-ppl=no \
    --disable-libstdcxx-pch --enable-__cxa_atext
$ make -k
$ make install -k
```

*Note:* This will fail until this work has progressed much further... but enough will be completed for testing.

```
$ cd test
$ ./binutils-gdb/test.sh ../aix6.1-toolchain
```

*Note:* This will fail too - see the checkboxes at the start.
