#!/bin/sh
# Script for building eq source to image. Temporary because makefile is not finished
# Preben Thorod - HandyEQ


#sparc-elf-gcc -o image src/main.c 
gcc -o eqmainx86 src/main.c src/biquad.c src/eq1band.c src/eqtest.c src/eqcoeff.c src/dspsystem.c src/volume.c
