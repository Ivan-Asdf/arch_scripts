set -e
# Dependencies: netwrokmanager, bspwmrc, https://github.com/Ivan-Asdf/st
# Set up wifi
systemctl enable NetworkManager
systemctl start NetworkManager
nmcli device wifi
echo Enter wifi network name:
read NAME
echo Enter wifi network password:
read PASS
nmcli device wifi connect $NAME password $PASS

# Install bspwm(and its dependencies), alsa-utils & other general software.
pacman -S --noconfirm xorg xorg-xinit bspwm sxhkd dmenu firefox cloc ranger feh evince gvfs git alsa-utils
mkdir -p /home/$SUDO_USER/.config/bspwm
mkdir -p /home/$SUDO_USER/.config/sxhkd
#cp bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/bspwmrc /home/$SUDO_USER/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc /home/$SUDO_USER/.config/sxhkd/sxhkdrc

# Install st terminal. And set it as default in sxhkdrc
# TODO: Make this compatible with set -e(remove || true)
git clone https://github.com/Ivan-Asdf/st || true
cd st
make clean install
sed -i -e 's/urxvt/st/g' /home/$SUDO_USER/.config/sxhkd/sxhkdrc
pacman -Syu --noconfirm ttf-dejavu
echo "exec bspwm" > /home/$SUDO_USER/.xinitrc
