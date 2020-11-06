pacman -S --noconfirm sudo grub efibootmgr networkmanager
echo "Enter new root password: "
passwd
# TODO: Add prompt for new user name
# TODO: Add maybe check to see if already there?
echo 'ivan  ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo "Enter new ivan password: "
useradd -m ivan
passwd ivan

grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
