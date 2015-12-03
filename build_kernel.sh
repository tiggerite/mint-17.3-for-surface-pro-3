# download sources
wget https://launchpad.net/ubuntu/+archive/primary/+files/linux_3.19.0.orig.tar.gz
wget https://launchpad.net/ubuntu/+archive/primary/+files/linux_3.19.0-32.37.diff.gz

# decompress
tar xf linux_3.19.0.orig.tar.gz
gunzip linux_3.19.0-32.37.diff.gz

# apply patches
cd linux-3.19
patch -p1 --ignore-whitespace -i ../linux_3.19.0-32.37.diff
patch -p1 --ignore-whitespace -i ../patches/0003-configs-based-on-Ubuntu-3.19.0-32.37.patch
patch -p1 --ignore-whitespace -i ../patches/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r8-3.19.0.patch
patch -p1 --ignore-whitespace -i ../patches/0002-block-introduce-the-BFQ-v7r8-I-O-sched-for-3.19.0.patch
patch -p1 --ignore-whitespace -i ../patches/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r8-for-3.19.0.patch
patch -p1 --ignore-whitespace -i ../patches/bfq-config.patch
#patch -p1 --ignore-whitespace -i ../patches/3.19-sched-bfs-461.patch
#patch -p1 --ignore-whitespace -i ../patches/bfs462-rtmn-fix.patch
#patch -p1 --ignore-whitespace -i ../patches/bfs-config.patch
#patch -p1 --ignore-whitespace -i ../patches/remove-i810.patch
patch -p1 --ignore-whitespace -i ../patches/version.patch
patch -p1 --ignore-whitespace -i ../patches/surface-lid.patch
patch -p1 --ignore-whitespace -i ../patches/surface-button-cam.patch
patch -p1 --ignore-whitespace -i ../patches/surface-config.patch
patch -p1 --ignore-whitespace -i ../patches/surface-sleep.patch
patch -p1 --ignore-whitespace -i ../patches/surface-battery.patch
patch -p0 --ignore-whitespace -i ../patches/surface-screen.patch
#patch -p1 --ignore-whitespace -i ../patches/surface-i915.patch
patch -p1 --ignore-whitespace -i ../patches/mwifiex-0001.patch
patch -p1 --ignore-whitespace -i ../patches/mwifiex-0002.patch
patch -p1 --ignore-whitespace -i ../patches/mwifiex-0003.patch

# update execute flags
chmod a+x debian/rules
chmod a+x debian/scripts/*
chmod a+x debian/scripts/misc/*

# compile kernel
fakeroot debian/rules clean
sed -i 's/3.19.0-32.37)/3.19.0-32.37~14.04.3)/g' debian/changelog
fakeroot debian/rules binary-headers binary-generic
