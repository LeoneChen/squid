set -e
autoreconf -i --force
PROJECT_ROOT=$(realpath ../..)
./configure --disable-strict-error-checking --prefix=${PROJECT_ROOT}/src/squid/install --disable-shared --enable-static --enable-silent-rules --enable-dependency-tracking --enable-icmp --enable-delay-pools --enable-useragent-log --enable-esi --enable-follow-x-forwarded-for --enable-auth --with-openssl=${PROJECT_ROOT}/src/libressl-2.4.1 LIBOPENSSL_LIBS="-lssl -lcrypto -lsgx_urts -lsgx_uae_service -lpthread"
make -j16 -s && make -j16 install -s
cp ${PROJECT_ROOT}/conf/squid/squid.conf install/etc/squid.conf
echo "\nABC\nMy City\nMy Institution\n\nwww.example.com\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${PROJECT_ROOT}/src/squid/install/etc/cert.key -out ${PROJECT_ROOT}/src/squid/install/etc/cert.crt
ln -s ../libressl-2.4.1/crypto/enclave.signed.so