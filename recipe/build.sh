#!/bin/bash

qmake
make -j $CPU_COUNT
make install
