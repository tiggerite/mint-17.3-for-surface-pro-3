# download sources
wget --quiet https://launchpad.net/ubuntu/+archive/primary/+files/linux_4.3.0-4.13.tar.gz

# decompress
tar xf linux_4.3.0-4.13.tar.gz
mv ubuntu-xenial linux-4.3

# apply patches
cd linux-4.3
patch -p1 --ignore-whitespace -i ../patches/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r8-4.3.patch
patch -p1 --ignore-whitespace -i ../patches/0002-block-introduce-the-BFQ-v7r8-I-O-sched-for-4.3.patch
patch -p1 --ignore-whitespace -i ../patches/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r8-for-4.3.0.patch
patch -p1 --ignore-whitespace -i ../patches/bfq-config.patch
patch -p1 --ignore-whitespace -i ../patches/mwifiex.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchpad.patch
patch -p1 --ignore-whitespace -i ../patches/surface-cam.patch
patch -p1 --ignore-whitespace -i ../patches/surface-lid.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchscreen.patch
patch -p1 --ignore-whitespace -i ../patches/acpi-scan.patch
patch -p1 --ignore-whitespace -i ../patches/acpi-osl.patch
patch -p1 --ignore-whitespace -i ../patches/spi-pxa.patch
patch -p1 --ignore-whitespace -i ../patches/pinctrl-broxton.patch
patch -p1 --ignore-whitespace -i ../patches/pinctrl-broxton-config.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-broxton.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-non-acpi.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-hangup-fix.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-hangup-config.patch
patch -p1 --ignore-whitespace -i ../patches/lpss-hangup-oldmodule.patch
patch -p1 --ignore-whitespace -i ../patches/gpio-shared-event.patch
patch -p1 --ignore-whitespace -i ../patches/version.patch

# update execute flags
chmod a+x debian/rules
chmod a+x debian/scripts/*
chmod a+x debian/scripts/misc/*

# compile kernel
fakeroot debian/rules clean
sed -i 's/4.3.0-4.13)/4.3.0-4.13~14.04.3)/g' debian/changelog
fakeroot debian/rules binary-headers binary-generic
