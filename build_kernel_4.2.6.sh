# download sources
wget --quiet https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.2.6.tar.xz

# decompress
tar xf linux-4.2.6.tar.xz

# apply patches
cd linux-4.2.6
patch -p1 --ignore-whitespace -i ../patches-4.2.6/0001-base-packaging.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/0002-debian-changelog.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/0003-configs-based-on-Ubuntu-4.2.0-18.22.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r9-4.2.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/0002-block-introduce-the-BFQ-v7r9-I-O-sched-for-4.2.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r9-for-4.2.0.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/bfq-config.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/mwifiex-0001.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/mwifiex-0002.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/surface-lid.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/surface-touchpad.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/surface-button-cam.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/surface-button-config.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/acpi-scan.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/acpi-osl.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/spi-pxa.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/lpss.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/lpss-config.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/pinctrl.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/pinctrl-config.patch
patch -p1 --ignore-whitespace -i ../patches-4.2.6/version.patch
sed -i 's/4.2.6-040206.201511091832)/4.2.0-17.21~14.04.3)/g' debian.master/changelog

# update execute flags
chmod a+x debian/rules
chmod a+x debian/scripts/*
chmod a+x debian/scripts/misc/*

# compile kernel
fakeroot debian/rules clean
fakeroot debian/rules binary-headers binary-generic
