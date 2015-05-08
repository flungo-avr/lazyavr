Lazy AVR
========

Library for mapping functionality of various AVR based boards in order to make coding more readable and reduce the need to look up board specific details in the schematics and documentation.

Disclaimer
----------

This project is still highly under development and may be subject to change. I recommend keeping the library up to date but you may need to update the usage code of your project between updates.

Usage
-----

The easiest way to use this library is to clone (or add as a submodule) of your project. Assuming you are in your project directory you can do either of the following to get the library:

### Get the Library

#### git clone

If you are not using git for your project and `git status` says you are not in a git repository

```
git clone https://github.com/flungo/lazyavr
```

This will clone the git repo into "lazyavr" in your current working directory and you can continue to [Initialising the library](#Initialising-the-library).

#### git submodule add

If you are using git for your project then what you want to do is add this library as a submodule of your project. This can be done with a similar command to that used to clone the repository:

```
git submodule add https://github.com/flungo/lazyavr
```

This will clone the git repo into "lazyavr" as a submodule of the git repository you are working in and you can continue to [Initialising the library](#Initialising-the-library).

#### Download the archive

If you do not want to or cannot use git you can download and extract the archive of the project into your project folder.

### Initialising the library

To make development cleaner and easier as well as allowing for adaption for various hardware configurations, the library uses dynamically generated header files. You will need to generate these before you can use the library. A make file is included that will run all the relevant scripts for making all the header source files you will need to use the library. To run make from your project directory:

```
make -C lazyavr
```

### Integrating with make

If you are using a Makefile for your project, the library can be integrated into your make file so that should any changes be made in the lazyavr, the dynamic header files are regenerated. This can be useful after an update to the library so you do not need to manually initialise and also makes sharing your project with its submodules (if you are using the library as a submodule) easier.

The best way to integrate with make is to create a rule that will always run whenever you try to make your project. Firstly, add the following rule to your make file:

```
# Add a phony rule to run make on the lazyavr library.
# .PHONY so that it runs no matter what.
.PHONY: lazyavr

lazyavr:
	$(MAKE) -C lazyavr
```

At this point you would now be able to run `make lazyavr` in your project and it will make the required files in the lazyavr folder.

The next step with integrating would be to add `lazyavr` as a dependency for the target that will compile your code. For example, if using the Universal Makefile by Klaus-Peter Zauner, you would need to change the `$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)` line to `$(BUILD_DIR)/%.o: %.c Makefile | lazyavr $(BUILD_DIR)`.

In summary, you need to make sure that you make the `lazyavr` target before trying to compile code that uses it.

The rules in the libraries Makefile, do not generate the objects and it is assumed that your Makefile will be able to traverse the subdirectories in order to make the source files it requires.

### Updating the library

#### Update using git

To update you can either use `git pull` or `make git-pull` directly from the library directory to pull the latest update to the folder or use `make -C lazyavr git-pull` from your project directory.

#### From archive

If you are using the library extracted from the archive, then just delete the library and follow the procedure to [get the library using the archive](#Download-the-archive) again.

#### Auto updating with make

If you would like the code to be automatically updated within your make (as well as automatically cloned when someone makes from your source), you can replace the make integration rule given in the [Integrating with make](#Integrating-with-make) section with:

```
# Add a phony rule to run make on the lazyavr library.
# .PHONY so that it runs no matter what.
.PHONY: git-pull git-submodule-update git-submodule-pull
.PHONY: lazyavr lazyavr-update

lazyavr: git-submodule-update
	$(MAKE) -C lazyavr

lazyavr-update: git-submodule-update
	$(MAKE) -C lazyavr update

git-pull:
	git pull

git-submodule-update: git-pull
	git submodule init
	git submodule update
```

With this addition in the makefile, you can either add the `lazyavr-update` target as a dependency so that the latest version is pulled whenever you call that target or just use `make lazyavr-update` whenever you want the library updated.

For a more in depth look into how you can integrate git with your makefile, please reffer to my [git.mk](https://github.com/flungo/git.mk) project.

### Including in your code

To include any part of the library in your code, you will need to use an include statement that uses the relative path to the file. To include the core functionality, you should add `#include "lazyavr/lazyavr.h"` to the top of your source file.

#### Blink Example

This is an example `blink.c` file demonstrating the use of the library.

```
#define BOARD_LAFORTUNA 1

#include "lazyavr/lazyavr.h"
#include <util/delay.h>

void main(void) {
  lazyavr_init();

  OUTPUT(LED);

  for (;;) {
    SET(LED);
    _delay_ms(250);
    CLEAR(LED);
    _delay_ms(250);
  }

}
```

Documentation
-------------

For full documentation on the library and its features as well as guides on how to use it, please refer to the [wiki](https://github.com/flungo/lazyavr/wiki).
