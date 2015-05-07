#
# Author: Bharath Kumaran
# Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
# Description: Makefile for Project
#

#SWIG        = /u/kumarabh/Install/swig-3.0.2/preinst-swig
SWIG        = swig
SRCS        = example.c example_wrap.c examplejni.c
SRCDIR_SRCS = ./
TARGET      = example
INTERFACE   = example.i
SWIGOPT     = -package org.me
JAVASRCS    = *.java
JAVA_INCLUDE= -I"/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/include" -I"/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/include/linux"

CC         = gcc
CFLAGS     =
SO       = .so
LDSHARED = gcc -shared
CCSHARED = -fpic
OBJS     = $(SRCS:.c=.o)

# Extra Java specific dynamic linking options
JAVA_DLNK =
JAVA_LIBPREFIX = lib
JAVASO =.so
JAVALDSHARED = $(LDSHARED)
JAVACXXSHARED = $(CXXSHARED)
JAVACFLAGS =
JAVA = java
JAVAC = javac -d .
JAVA_JAR = example.jar

check: build
	$(MAKE) -f Makefile SRCDIR='$(SRCDIR)' java_test

build:
	$(MAKE) -f Makefile SRCDIR='$(SRCDIR)' SRCS='$(SRCS)' SWIG='$(SWIG)' \
	SWIGOPT='$(SWIGOPT)' TARGET='$(TARGET)' INTERFACE='$(INTERFACE)' java
	$(MAKE) -f Makefile SRCDIR='$(SRCDIR)' JAVASRCS='$(JAVASRCS)' JAVAFLAGS='$(JAVAFLAGS)' java_compile

clean:
	$(MAKE) -f Makefile SRCDIR='$(SRCDIR)' java_clean

# ----------------------------------------------------------------
# Build a java dynamically loadable module (C)
# ----------------------------------------------------------------

example_wrap.c: example.i
	$(SWIG) -java $(SWIGOPT) -I. $(INTERFACE)

java: $(SRCS)
	$(CC) -c $(CCSHARED) $(CPPFLAGS) $(CFLAGS) $(JAVACFLAGS) $(SRCS) $(INCLUDES) $(JAVA_INCLUDE)
	$(JAVALDSHARED) $(CFLAGS) $(LDFLAGS) $(OBJS) $(IOBJS) $(JAVA_DLNK) $(LIBS) -o $(JAVA_LIBPREFIX)$(TARGET)$(JAVASO)

# ----------------------------------------------------------------
# Compile java files
# ----------------------------------------------------------------

java_compile: $(SRCDIR_SRCS)
	$(COMPILETOOL) $(JAVAC) $(JAVACFLAGS) $(addprefix $(SRCDIR),$(JAVASRCS))

java_test:
	env LD_LIBRARY_PATH=$$PWD $(RUNTOOL) $(JAVA) org.me.myservicetest

jar:
	jar cf $(JAVA_JAR) $(JAVASRCS)

# -----------------------------------------------------------------
# Version display
# -----------------------------------------------------------------

java_version:
	$(JAVA) -version
	$(JAVAC) -version || echo "Unknown javac version"

java_clean:
	rm -f *_wrap* *~ .~* *.class `find . -name \*.java | grep -v myservicetest.java | grep -v myservice.java`
	rm -f core
	rm -Rf org
	rm -f *.o *.so
