sudo apt update
sudo apt install python3-pip python3-gi gir1.2-gtk-3.0 mpv sway -y

sudo apt-get install fbi -y

cp file.mp4 ~/
cp code.py ~/
cp start.sh ~/
sudo chmod +x ~/start.sh

echo "disable_splash=1" | sudo tee -a /boot/firmware/config.txt
sudo sed -i 's/console=tty1/console=tty3/g' /boot/firmware/cmdline.txt
sudo sed -i '1s/$/ quiet splash plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0 consoleblank=0/' /boot/firmware/cmdline.txt

sudo cp splash.png /opt/

sudo cp sway.service /etc/systemd/user/
systemctl --user enable sway.service

sudo cp splash.service /etc/systemd/system/
sudo systemctl enable splash

mkdir -p ~/.config/sway/
cp config ~/.config/sway/

#Autologin
sudo raspi-config nonint do_boot_behaviour B2
sed -i '1i clear\nsetterm -foreground black' ~/.profile
echo "PS1='\w:'" >> ~/.bashrc

sudo mkdir /etc/systemd/system/getty@tty3.service.d/
sudo cp /etc/systemd/system/getty@tty1.service.d/* /etc/systemd/system/getty@tty3.service.d/
sudo systemctl enable getty@tty3.service
sudo systemctl disable getty@tty1.service

echo "Setup Finished. Please reboot to test"