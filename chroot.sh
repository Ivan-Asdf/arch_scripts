# Create users and passwords. Setup sudo.
pacman -S --noconfirm sudo grub efibootmgr networkmanager
echo "Enter new root password: "
passwd
USER_NAME=$1
if [ -z $USER_NAME ]
then
	echo WTF NO USER NAME Argument give to chroot.sh!!!!
	exit
fi
useradd -m $USER_NAME
echo "Enter $USER_NAME password: "
passwd $USER_NAME
echo "$USER_NAME  ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Install bootloader
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
exit
