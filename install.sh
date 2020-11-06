set -e
# Drive argument and its pecularities if its sdX or nvmeXXXXpX
DRIVE=$1
if [ -z $DRIVE ]
then
    echo Please enter drive argument
fi
drive_suffix='';
if [[ $DRIVE == *"nvme"* ]]
then
	drive_suffix='p';
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

## CHROOT
echo "Enter new user name:"
read USER_NAME
cp chroot.sh ~/mnt/
arch-chroot ~/mnt ./chroot.sh $USER_NAME

# Clone this scripts repo to new user home(to run after install)
git clone . ~/mnt/home/$USER_NAME/scripts

