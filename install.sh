set -e
# Drive argument and its pecularities if its sdX or nvmeXXXXpX
DRIVE=$1
if [ -z $DRIVE ]
then
    echo Please enter drive argument
fi
drive_suffix='';
if [ $DRIVE == *"nvme"* ]
then
	isNvme='p';
fi

# Partitoning
sudo parted --script $DRIVE mklabel gpt \
    unit MiB\
    mkpart nameefi fat32 1 513\
    set 1 esp on\
    mkpart namelinux ext4 513 100%

# Creating filesystems
sudo mkfs.vfat "$DRIVE""$drive_suffix"1
sudo mkfs.ext4 "$DRIVE""$drive_suffix"2

# Mounting, installing & fstab
mkdir ~/mnt
mount "$DRIVE""$drive_suffix"2 ~/mnt
mkdir ~/mnt/boot
mount "$DRIVE""$drive_suffix"1 ~/mnt/boot
pacstrap ~/mnt base base-devel linux linux-firmware vim
genfstab -U ~/mnt >> ~/mnt/etc/fstab
# Clone this scripts repo to drive (to run after install)
git clone . ~/mnt/arch

## CHROOT
arch-chroot ~/mnt
# Create users and passwords. Setup sudo.
pacman -S --noconfirm sudo grub efibootmgr networkmanager
echo "Enter new root password: "
passwd
echo "Enter new user name:"
read USER_NAME
useradd -m $USER_NAME
echo "Enter $USER_NAME password: "
passwd $USER_NAME
echo "$USER  ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Install bootloader
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

