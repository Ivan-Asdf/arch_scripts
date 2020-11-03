USB=$1
if [ -z $USB ]
then
    echo Please enter usb block device argument!
    exit
fi
#wget http://mirrors.evowise.com/archlinux/iso/2020.11.01/archlinux-2020.11.01-x86_64.iso
sudo dd if=archlinux-2020.11.01-x86_64.iso of=$1 bs=8M
mkdir mnt
mount "$USB"1 mnt
cp install.sh post_install.sh mnt/
