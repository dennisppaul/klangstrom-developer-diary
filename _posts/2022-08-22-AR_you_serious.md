---
layout: post
title:  "`ar` you serious?!?"
date:   2022-08-22 10:00:00 +0100
---

#updatesformtheengineroom all compilers + linkers are the same … until they are not.

i embarked on a journey to make the emulator ( or simulator ) work on *linux*. since it is based on SDL and the gcc compiler ( both available on *linux* and *macOS* ) i was hoping that the transistion could be rather painless.

unfortunately, it wasn’t that easy. well, actually it was except for one detail. while i was able to compile most of the source code pretty quickly on *linux*, i ended up with the following complaint from the linker:

    could not read symbols: Archive has no index; run ranlib to add one

long story short: i spent an entire 2 days to get to the bottom of this. *bottomline* is that the gcc linker on *linux* behaves slightly different than on *macOS*: on *macOS* the order in which arguments are passed to the linker does **not** matter, on *linux* it does!!!

the long version, including an example, can be found below.

let’s consider the following very simple use case: we have a static library `libcodec.a` that contains two functions and an application that links against these functions. first we build the library:

`‌encode.c`: 

```
void encode(char *text) {
	for (int i=0; text[i] != 0x0; i++) {
		text[i]++;
	}
}
```

`decode.c`: 

```
void decode(char *text) {
    for (int i=0; text[i] != 0x0; i++) {
        text[i]--;
    }
}
```

we compile both C files with 

    $ gcc -c encode.c
    $ ‌gcc -c decode.c

this creates two object files `encode.o` and `decode.o`. now we create the static library `libcodec.a‌` out of the object files with 

    $ ar -crs libcodec.a encode.o decode.o

we then write a header for the library `libcodec.h`:

```
void encode(char *text);
void decode(char *text);
```

and write a small application `testlib.c`:

```
#include <stdio.h>
#include <stdlib.h>

#include "libcodec.h"

int main(int argc, char *argv[]) {
 char text[]="fourtytwo";
 puts(text);

 encode(text);
 puts(text);

 decode(text);
 puts(text);

 return 0;
}
```

we can now compile `testlib.c` and link it against `libcodec.a` and run it with the following commands:

    $ gcc testlib.c libcodec.a -o testapp 
    $ ./testapp

the output looks like this:

```
fourtytwo
gpvsuzuxp
fourtytwo
```

however, if we consider compiling and linking the test with the following command ( note, library and source file are in reversed order ):

    $ gcc libcodec.a testlib.c -o testapp 

the divergence starts to emerge. whereas on *macOS* this compiles and links just fine on *linux* the linker complains about not finding the symbols:

```
/usr/bin/ld: /tmp/ccqMMhIO.o: in function `main':
testlib.c:(.text+0x4a): undefined reference to `encode'
/usr/bin/ld: testlib.c:(.text+0x62): undefined reference to `decode'
collect2: error: ld returned 1 exit status
```

well, riddle me this!

in summary, the problem i encountered while porting to *linux* was basically due to the fact that my *macOS* build script passed the `core.a` library ( which the Arduino Environment creates during the build process ) before the sketch. this worked fine on *macOS* but not on *linux*. simple.

---

the examples above is based on the articles [How to Use Linux’s ar Command to Create Static Libraries](https://www.howtogeek.com/427086/how-to-use-linuxs-ar-command-to-create-static-libraries/) and [Things to remember when compiling/linking C/C++ software](https://gist.github.com/gubatron/32f82053596c24b6bec6).

the issue occured on the following systems.

*linux*:

```
$ uname -a
Linux primary 5.4.0-54-generic #60-Ubuntu SMP Fri Nov 6 10:37:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
$ gcc --version
gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

*macOS*:

```
$ uname -a
Darwin d3BookPro.local 21.6.0 Darwin Kernel Version 21.6.0: Sat Jun 18 17:07:25 PDT 2022; root:xnu-8020.140.41~1/RELEASE_X86_64 x86_64
$ gcc --version
Apple clang version 13.1.6 (clang-1316.0.21.2.5)
Target: x86_64-apple-darwin21.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```
