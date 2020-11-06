set -e
# Dependencies: bspwmrc, https://github.com/Ivan-Asdf/st
# Set up wifi
pacman -S --noconfirm networkmanager

#systemctl start NetworkManager
#nmcli device wifi
#echo Enter wifi network name:
#read NAME
#echo Enter wifi network password:
#read PASS
#nmcli device wifi connect $NAME password $PASS

# TODO: Fix the installation of software so it always works
#pacman -S --noconfirm xorg xorg-xinit bspwm sxhkd firefox cloc ranger feh evince gvfs
# TODO: Make relative paths dynamic since they dont work when script run with sudo
pacman -S --noconfirm bspwm sxhkd dmenu
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd
#cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
cp bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc /home/ivan/.config/sxhkd/sxhkdrc
# Set st as default terminal
sed -i -e 's/urxvt/st/g' /home/ivan/.config/sxhkd/sxhkdrc
# Pull, compile & install st terminal
# TODO: Make this compatible with set -e(remove || true)
git clone https://github.com/Ivan-Asdf/st || true
cd st
pacman -S --noconfirm base-devel
make clean install

pacman -S --noconfirm alsa-utils
pacman -Syu --noconfirm
