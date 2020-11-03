DRIVE=$1

echo $DRIVE

sudo parted --script $DRIVE mklabel gpt \
    unit MiB\
    mkpart nameefi fat32 1 513\
    set 1 esp on\
    mkpart namelinux ext4 513 100%

sudo mkfs.vfat "$DRIVE"1
sudo mkfs.ext4 "$DRIVE"2

mkdir ~/mnt
mount "$DRIVE"2 ~/mnt
mkdir ~/mnt/boot
mount "$DRIVE"1 ~/mnt/boot

pacstrap ~/mnt base linux linux-firmware vim
genfstab -U ~/mnt >> ~/mnt/etc/fstab
