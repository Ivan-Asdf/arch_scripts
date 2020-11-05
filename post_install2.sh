# Dependencies: bspwmrc, https://github.com/Ivan-Asdf/st
# Set up wifi
pacman -S networkmanager
nmcli defice wifi
echo Enter wifi network name:
read NAME
echo Enter wifi network password:
read PASSWORD
nmcli defice wifi connect $NAME password $PASS

# Install some software and config bspwm
pacman -S xorg xorg_xinit bspwm sxhkd firefox cloc ranger feh evince gfvs
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd
#cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
cp bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
# Set st as default terminal
sed -i -e 's/urxvt/st/g' ~/.config/sxhkd/sxhkdr
# Pull, compile & install st terminal
git clone https://github.com/Ivan-Asdf/st
cd st
make clean install

pacman -S alsautils
pacman -Syu
