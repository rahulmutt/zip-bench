#!/usr/bin/env sh

rm -rf tmp
mkdir tmp
cd tmp
jar -xf ../HSbase-4.8.2.0.jar
jar -xf ../HSghc-prim-0.4.0.0.jar
jar -xf ../HSinteger-0.5.1.0.jar
jar -xf ../HSrts-0.1.0.0.jar
jar -cf merged.jar .
