# download sources
wget --quiet https://launchpad.net/ubuntu/+archive/primary/+files/linux_4.3.0-5.16.tar.gz

# decompress
tar xf linux_4.3.0-5.16.tar.gz
mv ubuntu-xenial linux-4.3

# apply patches
cd linux-4.3
patch -p1 --ignore-whitespace -i ../patches/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r8-4.3.patch
patch -p1 --ignore-whitespace -i ../patches/0002-block-introduce-the-BFQ-v7r8-I-O-sched-for-4.3.patch
patch -p1 --ignore-whitespace -i ../patches/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r8-for-4.3.0.patch
patch -p1 --ignore-whitespace -i ../patches/bfq-config.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchpad.patch
patch -p1 --ignore-whitespace -i ../patches/surface-cam.patch
patch -p1 --ignore-whitespace -i ../patches/surface-lid.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchscreen.patch
patch -p1 --ignore-whitespace -i ../patches/enable-rx-workqueue-when-rx-pending-is-high.patch
patch -p1 --ignore-whitespace -i ../patches/set-status-to-0-if-_STA-failed.patch
patch -p1 --ignore-whitespace -i ../patches/speedup-grace-period-in-acpi_os_map_cleanup.patch
patch -p1 --ignore-whitespace -i ../patches/SPI-multiple-chipselects-hack-for-Braswell,Cherry_Trail.patch
patch -p1 --ignore-whitespace -i ../patches/add-support-for-Intel-Broxton-SoC.patch
patch -p1 --ignore-whitespace -i ../patches/add-support-for-Intel-Broxton-config.patch
patch -p1 --ignore-whitespace -i ../patches/support-Intel-Broxton.patch
patch -p1 --ignore-whitespace -i ../patches/allow-shared-GPIO-event-to-be-read-via-operation-region.patch
patch -p1 --ignore-whitespace -i ../patches/remove-duplicate-definitions.patch
patch -p1 --ignore-whitespace -i ../patches/fix-system-hangup-on-BYT,BSW,CHT.patch
patch -p1 --ignore-whitespace -i ../patches/fix-system-hangup-config.patch
patch -p1 --ignore-whitespace -i ../patches/0001-add-fwnode_property_match_string-and-support-for-dma-names-property.patch
patch -p1 --ignore-whitespace -i ../patches/0002-enable-I2C-devices-behind-I2C-bus-on-Gen2.patch
patch -p1 --ignore-whitespace -i ../patches/0003-hierarchical-properties-support.patch
patch -p1 --ignore-whitespace -i ../patches/0004-setting-up-DMA-coherency-for-PCI-device-from-_CCA-attribute.patch
patch -p1 --ignore-whitespace -i ../patches/0005-fix-subnode-lookup-scope-for-data-only-subnodes.patch
patch -p1 --ignore-whitespace -i ../patches/0006-code-duplication-removal-and-cleanups.patch
patch -p1 --ignore-whitespace -i ../patches/0007-support-non-ACPI-platforms.patch

sed -i '/^iosf_mbi$/d' debian.master/abi/4.3.0-*/amd64/generic.modules
sed -i 's/4.3.0-5.16)/4.3.0-5.16~14.04.3)/g' debian.master/changelog
sed -i 's/SUBLEVEL = 3/SUBLEVEL = 0/' Makefile
sed -i 's/EXTRAVERSION =/EXTRAVERSION = -5/' Makefile

# update execute flags
chmod a+x debian/rules
chmod a+x debian/scripts/*
chmod a+x debian/scripts/misc/*

# compile kernel
fakeroot debian/rules clean
fakeroot debian/rules binary-headers binary-generic
