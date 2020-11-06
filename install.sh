DRIVE=$1

if [ -z $DRIVE ]
then
    echo Please enter drive argument
fi

sudo parted --script $DRIVE mklabel gpt \
    unit MiB\
    mkpart nameefi fat32 1 513\
    set 1 esp on\
    mkpart namelinux ext4 513 100%

sudo mkfs.vfat "$DRIVE"p1
sudo mkfs.ext4 "$DRIVE"p2

mkdir ~/mnt
mount "$DRIVE"p2 ~/mnt
mkdir ~/mnt/boot
mount "$DRIVE"p1 ~/mnt/boot

pacstrap ~/mnt base base-devel linux linux-firmware vim
genfstab -U ~/mnt >> ~/mnt/etc/fstab

mkdir -p ~/mnt/arch
cp post_install.sh post_install2.sh ~/mnt/arch
