Linux Mint 17.3 (RC1/BETA) for the Surface Pro 3

Here are the scripts and patches necessary to build the kernel from the customized LiveCD that is on my Google Drive (links below).

To compile, simply run ./build_kernel.sh - it takes about an hour and 15 minutes on my SP3 i7.

If you then want to make your own LiveCD, firstly download and install JLIVECD from https://github.com/neurobin/JLIVECD and run JLstart.

Go through the prompts using defaults (I use ~/mylivecd as folder), then when the chroot has launched in a new terminal, copy the compiled debs into ~/mylivecd/edit/tmp.

You will also need the linux-firmware_1.127.18_all.deb from http://packages.ubuntu.com/trusty/all/linux-firmware/download or my Google Drive, copy that to the same location.

Finally for Bluetooth to work you will need to run:

```
git clone git://git.marvell.com/mwifiex-firmware.git  
mkdir ~/mylivecd/edit/tmp/mrvl
cp mwifiex-firmware/mrvl/* ~/mylivecd/edit/tmp/mrvl/
```

Now you need to install the debs and copy the Marvell firmware files that you just downloaded. In the chroot terminal:

```
cd /tmp
dpkg -i *.deb
mkdir -p /lib/firmware/mrvl/  
cp mrvl/* /lib/firmware/mrvl/ 
rm *.deb
rm -Rf mrvl
```

Optionally, you can now install blueman to have a better Bluetooth manager:

```
add-apt-repository ppa:cschramm/blueman
apt-get update
apt-get install blueman
```

One final optional tweak is to change the wifi adapter to always have power management off. To do so:

```
mkdir -p /etc/pm/power.d
sudo nano /etc/pm/power.d/wifi_pwr_off
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

......Enter the kernel version (take your time on this one): 3.19.0-32-generic
```

Now let JLIVECD finish, but delete the generated ISO file, as you need to generate it differently for UEFI support. You can substitute linuxmint-17.3-cinnamon-x64-sp3-RC1.iso in both commands with whatever you choose, as long as they match.

```
cd ~/mylivecd/extracted
mkisofs -U -A "LinuxMint_64" -V "LinuxMint_64" -volset "LinuxMint_64" -J -joliet-long -r -v -T -o "../linuxmint-17.3-cinnamon-x64-sp3-RC1.iso" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
cd ..
isohybrid --uefi linuxmint-17.3-cinnamon-x64-sp3-RC1.iso
```


The link to the final LiveCD on my Google Drive: https://drive.google.com/file/d/0B0E-zt0RT0Y_eVVfS1FBZVg3TjQ/view?usp=sharing

The folder for the compiled kernel debs and linux-firmware_1.127.18_all.deb on my Google Drive: https://drive.google.com/folderview?id=0B0E-zt0RT0Y_ZkktbXU4QUtIZUE&usp=sharing
