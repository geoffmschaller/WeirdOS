#!/bin/sh


make && qemu-system-i386 -fda ~/Software/WeirdOS/build/main_floppy.img
