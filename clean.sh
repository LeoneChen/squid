set -e
if [ -f Makefile ]
then
make maintainer-clean -s
fi
rm -rf install enclave.signed.so
