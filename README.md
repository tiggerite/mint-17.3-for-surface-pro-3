Linux Mint 17.3 for the Surface Pro 3

Here are the scripts and patches necessary to build the kernel from the customized LiveCD that is on my Google Drive (links below).

To compile, simply run ./build_kernel_4.2.6.sh - it takes about an hour on my SP3 i7. Alternatively, to build the beta version, run ./build_kernel_4.3.sh instead.

If you then want to make your own LiveCD, firstly download the ISO file from a mirror, e.g. http://www.mirrorservice.org/sites/www.linuxmint.com/pub/linuxmint.com//stable/17.3/linuxmint-17.3-cinnamon-64bit.iso

Next, download and install JLIVECD from https://github.com/neurobin/JLIVECD and run JLstart.

Go through the prompts using defaults (I use ~/mylivecd as folder), then when the chroot has launched in a new terminal, copy the compiled debs into ~/mylivecd/edit/tmp.

You will also need the linux-firmware_1.127.18_all.deb from http://packages.ubuntu.com/trusty/all/linux-firmware/download or my Google Drive, copy that to the same location.

Then for Bluetooth to work you will need to run:

```
git clone git://git.marvell.com/mwifiex-firmware.git  
mkdir ~/mylivecd/edit/tmp/mrvl
cp mwifiex-firmware/mrvl/* ~/mylivecd/edit/tmp/mrvl/
```

Finally, when you install the new kernel, because the version is different the virtualbox dkms module will automatically be rebuilt. However, this needs gcc 4.9, but the LiveCD only has 4.8 by default. So, to install gcc-4.9:

```
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get install gcc-4.9 g++-4.9 cpp-4.9
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 20
update-alternatives --config gcc
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 20
update-alternatives --config g++
update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-4.9 20
update-alternatives --config cpp
gcc --version
```

Now you can install the new kernel and copy the Marvell firmware files that you downloaded earlier. In the chroot terminal:

```
rm /initrd.img
rm /vmlinuz
cd /tmp
dpkg -i *.deb
mkdir -p /lib/firmware/mrvl/  
cp mrvl/* /lib/firmware/mrvl/ 
rm *.deb
rm -Rf mrvl
```

When installing the 4.2.0-19 (or 4.3.0-5 if using the beta) kernel-image debs, although the virtualbox module will now build without a hitch, the ndiswrapper one will not, causing the system to spit out a warning. As you have downloaded the Surface wifi drivers and integrated them into the kernel, ndiswrapper isn't needed, and this can be safely ignored.

Now, let's tidy up the ISO image by removing the bundled version:

```
apt-get purge linux-headers-3.19.0-32
apt-get purge linux-image-3.19.0-32-generic
```

Removing these should remove the other two related packages, namely linux-headers-3.19.0-32-generic and linux-image-extra-3.19.0-32-generic.

Optionally, you can now install blueman to have a better Bluetooth manager:

```
add-apt-repository ppa:cschramm/blueman
apt-get update
apt-get install blueman
```

One final optional tweak is to change the wifi adapter to always have power management off. To do so:

```
mkdir -p /etc/pm/power.d
nano /etc/pm/power.d/wifi_pwr_off
```

And copy/paste the following into the file, before saving (Ctrl+X, Y):

```
#!/bin/sh
/sbin/iwconfig mlan0 power off
```

Once saved:
```
chmod a+x /etc/pm/power.d/wifi_pwr_off
```

You can now exit the chroot. Once control passes back to JLIVECD, be sure to enter "y" and enter the correct kernel version at the next prompt:

```
......have you installed new kernel and want to boot the new kernel in live cd/dvd: (y/n)?

......Enter the kernel version (take your time on this one): 4.2.0-19-generic
```

(with the beta, this should be 4.3.0-5-generic)

Now let JLIVECD finish, but delete the generated ISO file, as you need to generate it differently for UEFI support. You can substitute linuxmint-17.3-cinnamon-x64-sp3-RC1.iso in both commands with whatever you choose, as long as they match.

```
cd ~/mylivecd/extracted
sudo mkisofs -U -A "LinuxMint_64" -V "LinuxMint_64" -volset "LinuxMint_64" -J -joliet-long -r -v -T -o "../linuxmint-17.3-cinnamon-x64-sp3.iso" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
cd ..
sudo isohybrid --uefi linuxmint-17.3-cinnamon-x64-sp3.iso
```


The link to the final LiveCD on my Google Drive (with the latest Beta in its own sub-folder): https://drive.google.com/drive/folders/0B0E-zt0RT0Y_OFltXzJSYTBtU1k

The folder for the compiled 4.2.0-19.23 kernel debs and linux-firmware_1.127.18_all.deb on my Google Drive: https://drive.google.com/drive/folders/0B0E-zt0RT0Y_TElxbHN6R1d2V3M and the 4.3.0-5.16 debs: https://drive.google.com/drive/folders/0B0E-zt0RT0Y_b3M3YkxBSnBpblk

