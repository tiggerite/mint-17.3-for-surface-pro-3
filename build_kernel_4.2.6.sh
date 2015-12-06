# download sources
wget --quiet https://launchpad.net/ubuntu/+archive/primary/+files/linux_4.2.0.orig.tar.gz
wget --quiet https://launchpad.net/ubuntu/+archive/primary/+files/linux_4.2.0-19.23.diff.gz

# decompress
tar xf linux_4.2.0.orig.tar.gz
gunzip linux_4.2.0-19.23.diff.gz

# apply patches
cd linux-4.2
patch -p1 --ignore-whitespace -i ../linux_4.2.0-19.23.diff
patch -p1 --ignore-whitespace -i ../patches/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r9-4.2.patch
patch -p1 --ignore-whitespace -i ../patches/0002-block-introduce-the-BFQ-v7r9-I-O-sched-for-4.2.patch
patch -p1 --ignore-whitespace -i ../patches/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r9-for-4.2.0.patch
patch -p1 --ignore-whitespace -i ../patches/bfq-config.patch
patch -p1 --ignore-whitespace -i ../patches/mwifiex-0001.patch
patch -p1 --ignore-whitespace -i ../patches/mwifiex-0002.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchpad.patch
patch -p1 --ignore-whitespace -i ../patches/surface-button-cam.patch
patch -p1 --ignore-whitespace -i ../patches/surface-button-config.patch
patch -p1 --ignore-whitespace -i ../patches/surface-lid.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchscreen.patch
patch -p1 --ignore-whitespace -i ../patches/acpi-scan.patch
patch -p1 --ignore-whitespace -i ../patches/acpi-osl.patch
patch -p1 --ignore-whitespace -i ../patches/spi-pxa.patch
patch -p1 --ignore-whitespace -i ../patches/pinctrl.patch
patch -p1 --ignore-whitespace -i ../patches/pinctrl-broxton.patch
patch -p1 --ignore-whitespace -i ../patches/pinctrl-broxton-config.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-broxton.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-non-acpi.patch
patch -p1 --ignore-whitespace -i ../patches/version.patch

# update execute flags
chmod a+x debian/rules
chmod a+x debian/scripts/*
chmod a+x debian/scripts/misc/*

# compile kernel
fakeroot debian/rules clean
sed -i 's/4.2.0-19.23)/4.2.0-19.23~14.04.3)/g' debian/changelog
fakeroot debian/rules binary-headers binary-generic
