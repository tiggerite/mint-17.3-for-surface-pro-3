git clone git://github.com/sfjro/aufs4-standalone.git
cd aufs4-standalone
git checkout origin/aufs4.x-rcN
cd ..
git clone https://github.com/zfsonlinux/spl.git
cd spl
sh autogen.sh
cd ..
git clone https://github.com/zfsonlinux/zfs.git
cd zfs
sh autogen.sh
cd ..
wget --quiet https://launchpad.net/ubuntu/+archive/primary/+files/linux_4.3.0-5.16.tar.gz
tar xf linux_4.3.0-5.16.tar.gz ubuntu-xenial/ubuntu/

git clone git://anongit.freedesktop.org/drm-intel

cp -a aufs4-standalone/Documentation/ drm-intel/
cp -a aufs4-standalone/fs/ drm-intel/
cp aufs4-standalone/include/uapi/linux/aufs_type.h drm-intel/include/uapi/linux/
cp -a spl drm-intel/
cp -a zfs drm-intel/
cp -a ubuntu-xenial/ubuntu drm-intel/

cd drm-intel
# apply patches
patch -p1 --ignore-whitespace -i ../patches/0001-base-packaging.patch
patch -p1 --ignore-whitespace -i ../patches/0002-Makefile.patch
patch -p1 --ignore-whitespace -i ../patches/0003-configs-based-on-Ubuntu-4.4.0-0.7.patch
patch -p1 --ignore-whitespace -i ../aufs4-standalone/aufs4-kbuild.patch
patch -p1 --ignore-whitespace -i ../aufs4-standalone/aufs4-base.patch
patch -p1 --ignore-whitespace -i ../aufs4-standalone/aufs4-mmap.patch
patch -p1 --ignore-whitespace -i ../aufs4-standalone/aufs4-standalone.patch
patch -p1 --ignore-whitespace -i ../patches/aufs-config.patch
patch -p1 --ignore-whitespace -i ../patches/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r8-4.4.patch
patch -p1 --ignore-whitespace -i ../patches/0002-block-introduce-the-BFQ-v7r8-I-O-sched-for-4.4.patch
patch -p1 --ignore-whitespace -i ../patches/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r8-for-4.4.0.patch
patch -p1 --ignore-whitespace -i ../patches/bfq-config.patch
patch -p1 --ignore-whitespace -i ../patches/surface-touchpad.patch
patch -p1 --ignore-whitespace -i ../patches/surface-lid.patch
patch -p1 --ignore-whitespace -i ../patches/surface-cam.patch
patch -p1 --ignore-whitespace -i ../patches/surface-button.patch
patch -p1 --ignore-whitespace -i ../patches/surface-button-config.patch
patch -p1 --ignore-whitespace -i ../patches/uvcvideo-Enable-UVC-1.5-device-detection.patch
patch -p1 --ignore-whitespace -i ../patches/wacom-rollback.patch -R
patch -p1 --ignore-whitespace -i ../patches/HID-multitouch-Ignore-invalid-reports.patch
patch -p1 --ignore-whitespace -i ../patches/HID-multitouch-Add-MT_QUIRK_NOT_SEEN_MEANS_UP-to-MT_.patch
patch -p1 --ignore-whitespace -i ../patches/enable-rx-workqueue-when-rx-pending-is-high.patch
patch -p1 --ignore-whitespace -i ../patches/set-status-to-0-if-_STA-failed.patch
patch -p1 --ignore-whitespace -i ../patches/SPI-multiple-chipselects-hack-for-Braswell,Cherry_Trail.patch
patch -p1 --ignore-whitespace -i ../patches/remove-duplicate-definitions.patch
patch -p1 --ignore-whitespace -i ../patches/fix-system-hangup-on-BYT,BSW,CHT.patch
patch -p1 --ignore-whitespace -i ../patches/support-non-ACPI-platforms.patch
patch -p1 --ignore-whitespace -i ../patches/mipi-sequence-block-v3,etc.patch
patch -p1 --ignore-whitespace -i ../patches/intel-config.patch

sed -i 's/4.4.0-0.7)/4.4.0-rc8.7~14.04.3)/g' debian.master/changelog

# update execute flags
chmod a+x debian/rules
chmod a+x debian/scripts/*
chmod a+x debian/scripts/misc/*

# compile kernel
fakeroot debian/rules clean
fakeroot debian/rules binary-headers binary-generic
