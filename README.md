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

* 32-bit
  * [x] Compiles \*.c and \*.cpp files (gcc 6.4.0)
  * [x] hello world in C (gcc 6.4.0)
  * [x] simple exception catching in C++ from source (gcc 6.4.0)
  * [x] function-level exception catching in C++ from source (gcc 6.4.0)
  * [x] complex exception catching in C++ from source (gcc 6.4.0)

* 64-bit
  * [ ] Compiles \*.c and \*.cpp files (gcc 6.4.0)
  * [ ] hello world in C (gcc 6.4.0)
  * [ ] simple exception catching in C++ from source (gcc 6.4.0)
  * [ ] function-level exception catching in C++ from source (gcc 6.4.0)
  * [ ] complex exception catching in C++ from source (gcc 6.4.0)

All currently fail with bad relocation errors.

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

* Fill the sysroot directory by finding files on an AIX box that has gcc 6.3.0 installed:

```
AIX $ cd / ; find ./ -name *.o -o -name *.h -o -name *.exp -o -name *.a -name *.so | cpio -oLV > out.cpio
Linux $ cd $(pwd)/aix6.1-toolchain/sysroot ; cpio -imdV < out.cpio 
```

* Build gcc 6.4.0

This requires the following patch "gcc.patch" to fix a problem present in gcc 6.x but not 7.x:

```
diff --git a/gcc/config/rs6000/rs6000.c b/gcc/config/rs6000/rs6000.c
index 67011707bfa..b08097550b9 100644
--- a/gcc/config/rs6000/rs6000.c
+++ b/gcc/config/rs6000/rs6000.c
@@ -33813,7 +33813,7 @@ rs6000_xcoff_declare_object_name (FILE *file, const char *name, tree decl)
   struct declare_alias_data data = {file, false};
   RS6000_OUTPUT_BASENAME (file, name);
   fputs (":\n", file);
-  symtab_node::get (decl)->call_for_symbol_and_aliases (rs6000_declare_alias, &data, true);
+  symtab_node::get_create (decl)->call_for_symbol_and_aliases (rs6000_declare_alias, &data, true);
 }
 
 /* Overide the default 'SYMBOL-.' syntax with AIX compatible 'SYMBOL-$'. */
```

The patched build runs as follows:

```
$ tar xf gcc-6.4.0.tar.gz
$ patch -p1 < gcc.patch
$ mkdir build_gcc
$ cd build_gcc
$ ../gcc-6.4.0/configure \
    --target=powerpc-ibm-aix6.1 \
    --prefix=$(pwd)/../aix6.1-toolchain \
    --with-sysroot=$(pwd)/../aix6.1-toolchain/sysroot \
    --with-gnu-as --with-gnu-ld \
    --enable-languages=c,c++ \
    --enable-version-specific-runtime-libs --disable-nls \
    --enable-decimal-float=dpd --with-cloog=no --with-ppl=no \
    --disable-libstdcxx-pch --enable-__cxa_atext
$ make
$ make install
```

The tests are run using an AIX box with an account linked via SSH (`guest@10.10.14.1` in the Makefile):
```
$ cd test
$ ./binutils-gdb/test.sh ../aix6.1-toolchain
```

This will run all 32-bit tests (succeeding) and all 64-bit tests (failing).
