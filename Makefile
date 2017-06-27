# Makefile for testing C99/C++ complex interop as shown in Dr. Dobbs's
# Copyright (C) 2016 Eric Herman
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2.1 of the License, or
# (at your option) any later version.
# https://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt

NOISY_FLAGS=-Werror -Wall -Wextra -Wpedantic
CFLAGS=$(NOISY_FLAGS) -ggdb -O2 -pipe -fomit-frame-pointer
LDFLAGS=
LDLIBS=-lm
CXXFLAGS=$(NOISY_FLAGS)
CC=c99
CXX=g++

default: check

test-c99-program: math-complex.h  test-program.cpp.c99
	cp test-program.cpp.c99 test-c99-program.c
	$(CC) $(CFLAGS) $(LDFLAGS) \
		-o test-c99-program test-c99-program.c $(LDLIBS)

test-cpp-program: math-complex.h  test-program.cpp.c99
	cp test-program.cpp.c99 test-cpp-program.cpp
	$(CXX) $(CXXLFAGS) -o test-cpp-program test-cpp-program.cpp

check: test-c99-program test-cpp-program
	./test-c99-program > test-c99-program.out
	./test-cpp-program > test-cpp-program.out
	diff -u test-c99-program.out test-cpp-program.out

clean:
	rm -f test-c99-program* test-cpp-program*
