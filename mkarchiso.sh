set -e
# Drive name argument
DRIVE=$1
if [ -z $DRIVE ]
then
	echo Please enter usb drive to write!
	exit
fi

# Dependencies
pacman -S --noconfirm archiso git

# Remove previous generation
rm *.iso releng work -rf

# Create custom iso
cp -r /usr/share/archiso/configs/releng .
git clone . releng/airootfs/root/scripts 
echo "git" >> releng/packages.x86_64

mkarchiso -v -o . releng

# Write to Usb
iso_name=$(ls *.iso)
dd if=$iso_name of=$DRIVE bs=64K status="progress"


