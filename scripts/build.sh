#!/bin/sh
set -e

ARCH=x86_64
DIST=el7

CENTOS_VERSION=7.6.1810
KERNEL_MAIN_VERSION=3.10.0
KERNEL_FULL_VERSION=3.10.0-957.10.1
CENTOS_KERNEL_RPM_SOURCE=http://vault.centos.org/${CENTOS_VERSION}/updates/Source/SPackages/kernel-${KERNEL_FULL_VERSION}.${DIST}.src.rpm

WORKSPACE=/workspace
RPMBUILD_HOME=${WORKSPACE}/rpmbuild

echo -e "########## clean old builds ##########\n"
rm -rf ${RPMBUILD_HOME}/


echo -e "########## create rpmbuild workspace ##########\n"
mkdir -p ${RPMBUILD_HOME}/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
echo "%_topdir ${RPMBUILD_HOME}" > ~/.rpmmacros


echo -e "########## install kernel build dependencies ##########\n"
yum install -y rpm-build redhat-rpm-config asciidoc hmaccalc perl-ExtUtils-Embed pesign xmlto
yum install -y audit-libs-devel binutils-devel elfutils-devel elfutils-libelf-devel
yum install -y ncurses-devel newt-devel numactl-devel pciutils-devel python-devel zlib-devel


echo -e "########## install devel dependencies ##########\n"
yum install -y make gcc net-tools bc openssl python-devel elfutils-libelf-devel elfutils-devel \
    zlib-devel binutils-devel bison audit-libs-devel java-devel numactl-devel pciutils-devel  \
    gettext ncurses-devel python-docutils newt-devel


echo -e "########## install kernel src rpm ##########\n"
rpm -i ${CENTOS_KERNEL_RPM_SOURCE}


echo -e "########## copy patches ##########\n"
cp ${WORKSPACE}/patches/* ${RPMBUILD_HOME}/SOURCES/


echo -e "########## copy rpm spec ##########\n"
cp ${WORKSPACE}/specs/kernel.spec ${RPMBUILD_HOME}/SPECS/


echo -e "########## disable CONFIG_MEMCG_KMEM ##########\n"
sed -i 's/CONFIG_MEMCG_KMEM=y/CONFIG_MEMCG_KMEM=n/g' ${RPMBUILD_HOME}/SOURCES/kernel-${KERNEL_MAIN_VERSION}-${ARCH}*.config


echo -e "########## build kernel ##########\n"
cd ${RPMBUILD_HOME}
rpmbuild -bb --without kabichk --target=$(uname -m) SPECS/kernel.spec
