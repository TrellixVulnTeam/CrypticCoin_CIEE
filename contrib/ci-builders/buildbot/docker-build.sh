#!/usr/bin/env bash

export LC_ALL=C
set -exo pipefail

# Debian 9
docker build . -f Dockerfile-build-python.apt --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=9 -t electriccoinco/crypticcoind-build-debian9
docker push electriccoinco/crypticcoind-build-debian9
docker build . -f Dockerfile-bbworker.apt --build-arg BASEOS=debian --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=9 -t electriccoinco/crypticcoind-bbworker-debian9
docker push electriccoinco/crypticcoind-bbworker-debian9

# Debian 10
docker build . -f Dockerfile-build.apt --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=10 -t electriccoinco/crypticcoind-build-debian10
docker push electriccoinco/crypticcoind-build-debian10
docker build . -f Dockerfile-gitian.apt --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=10 -t electriccoinco/crypticcoind-gitian-debian10
docker push electriccoinco/crypticcoind-gitian-debian10
docker build . -f Dockerfile-bbworker.apt --build-arg BASEOS=debian --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=10 -t electriccoinco/crypticcoind-bbworker-debian10
docker push electriccoinco/crypticcoind-bbworker-debian10

# Debian 11
docker build . -f Dockerfile-build.apt --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=bullseye -t electriccoinco/crypticcoind-build-debian11
docker push electriccoinco/crypticcoind-build-debian11
docker build . -f Dockerfile-gitian.apt --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=bullseye -t electriccoinco/crypticcoind-gitian-debian11
docker push electriccoinco/crypticcoind-gitian-debian11
docker build . -f Dockerfile-bbworker.apt --build-arg BASEOS=debian --build-arg FROMBASEOS=debian --build-arg FROMBASEOS_BUILD_TAG=bullseye -t electriccoinco/crypticcoind-bbworker-debian11
docker push electriccoinco/crypticcoind-bbworker-debian11

# Ubuntu 16.04
docker build . -f Dockerfile-build.apt --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=16.04 -t electriccoinco/crypticcoind-build-ubuntu1604
docker push electriccoinco/crypticcoind-build-ubuntu1604
docker build . -f Dockerfile-gitian.apt --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=1604 -t electriccoinco/crypticcoind-gitian-ubuntu1604
docker push electriccoinco/crypticcoind-gitian-ubuntu1604
docker build . -f Dockerfile-bbworker.apt --build-arg BASEOS=ubuntu --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=1604 -t electriccoinco/crypticcoind-bbworker-ubuntu1604
docker push electriccoinco/crypticcoind-bbworker-ubuntu1604

# Ubuntu 18.04
docker build . -f Dockerfile-build.apt --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=18.04 -t electriccoinco/crypticcoind-build-ubuntu1804
docker push electriccoinco/crypticcoind-build-ubuntu1804
docker build . -f Dockerfile-gitian.apt --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=1804 -t electriccoinco/crypticcoind-gitian-ubuntu1804
docker push electriccoinco/crypticcoind-gitian-ubuntu1804
docker build . -f Dockerfile-bbworker.apt --build-arg BASEOS=ubuntu --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=1804 -t electriccoinco/crypticcoind-bbworker-ubuntu1804
docker push electriccoinco/crypticcoind-bbworker-ubuntu1804

# Ubuntu 20.04
docker build . -f Dockerfile-build.apt --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=20.04 -t electriccoinco/crypticcoind-build-ubuntu2004
docker push electriccoinco/crypticcoind-build-ubuntu2004
docker build . -f Dockerfile-gitian.apt --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=2004 -t electriccoinco/crypticcoind-gitian-ubuntu2004
docker push electriccoinco/crypticcoind-gitian-ubuntu2004
docker build . -f Dockerfile-bbworker.apt --build-arg BASEOS=ubuntu --build-arg FROMBASEOS=ubuntu --build-arg FROMBASEOS_BUILD_TAG=2004 -t electriccoinco/crypticcoind-bbworker-ubuntu2004
docker push electriccoinco/crypticcoind-bbworker-ubuntu2004

# Centos8
docker build . -f Dockerfile-build.centos8 -t electriccoinco/crypticcoind-build-centos8
docker build . -f Dockerfile-bbworker.centos8  -t electriccoinco/crypticcoind-bbworker-centos8
docker push electriccoinco/crypticcoind-build-centos8
docker push electriccoinco/crypticcoind-bbworker-centos8

# Arch 20200908
docker build . -f Dockerfile-build.arch --build-arg ARCHLINUX_TAG=20200908 -t electriccoinco/crypticcoind-build-arch
docker build . -f Dockerfile-bbworker.arch  -t electriccoinco/crypticcoind-bbworker-arch
docker push electriccoinco/crypticcoind-build-arch
docker push electriccoinco/crypticcoind-bbworker-arch