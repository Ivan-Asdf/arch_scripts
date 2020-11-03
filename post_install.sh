pacman -S sudo
echo "Enter new root password"
passwd
su
echo 'ivan  ALL=(ALL:ALL) ALL' >> /etc/sudeors
echo "Enter new ivan password"
passwd ivan
exit

sudo grub-mkinstall --efi-directory=/boot
pacman -S osprober
grub-mkconfig -o /boot/grub/grub.cfg

# add connect to wifi comment and software installation and setup
