#!/usr/bin/env sh

VERSION=2.69
SOURCE=https://git.kernel.org/pub/scm/libs/libcap/libcap.git/snapshot/libcap-$VERSION.tar.gz

echo Downloading libcap "$VERSION" ...
cd /build || exit
wget "$SOURCE"

echo Extracting libcap "$VERSION" ...
tar -xf libcap-$VERSION.tar.gz
mv libcap-$VERSION libcap

echo Building libcap ...
cd /build/libcap || exit
make "-j$(nproc)" GOLANG=no  -C libcap all || exit
strip libcap/libcap.so.2
ldd libcap/libcap.so.2

echo Packaging libcap ...
mkdir -p /export/lib
cd /export || exit

cp /build/libcap/libcap/libcap.so.2 lib

mkdir legal
cat > legal/libcap<< EOF
Source  : $SOURCE
Version : $VERSION
Package : https://github.com/infrastructurex/libcap/libcap/download/$TAG/libcap-$ARCH-$TAG.tar.gz
License :

EOF
cat /build/libcap/License >> legal/libcap
gzip legal/libcap

tar -czvf /libcap.tar.gz *
