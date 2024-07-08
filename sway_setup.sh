sudo apt update
sudo apt install python3-pip python3-gi gir1.2-gtk-3.0 mpv sway -y

#sudo apt-get install pix-plym-splash -y
sudo apt-get install fbi -y

mkdir -p ~/.config/i3/
echo "exec /home/impulse/start.sh" > /home/impulse/.config/i3/config

cp file.mp4 ~/
cp code.py ~/
cp start.sh ~/
sudo chmod +x ~/start.sh

echo "disable_splash=1" | sudo tee -a /boot/firmware/config.txt
sudo sed -i 's/console=tty1/console=tty3/g' /boot/firmware/cmdline.txt
sudo sed -i '1s/$/ quiet splash plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0 consoleblank=0/' /boot/firmware/cmdline.txt

sudo cp splash.png /opt/
#sudo plymouth-set-default-theme --rebuild-initrd pix

#WIFI_SSID="SSID"
#WIFI_PASS=12345678
#WIFI_PSK=$(/usr/bin/wpa_passphrase "$WIFI_SSID" "$WIFI_PASS" | awk '/psk=/ {psk=$0} END {print psk}' | cut -d= -f2)
#/usr/lib/raspberrypi-sys-mods/imager_custom set_wlan "$WIFI_SSID" "$WIFI_PSK" 'PK'

#username="pi"
#password="123456" 
#password_hash=$(/usr/bin/openssl passwd -5 "$password")
#echo "$username:$password_hash" > /boot/userconf.txt

sudo cp sway.service /etc/systemd/user/
systemctl --user enable sway.service


sudo cp splash.service /etc/systemd/system/
sudo systemctl enable splash

echo "PS1='\w: '" >> ~/.bashrc
sudo rm /etc/motd
sudo touch /etc/motd
sudo sed -i '/session.*pam_lastlog.so/s/^/# /' /etc/pam.d/login
sudo sed -i '/session.*motd.dynamic/s/^/# /' /etc/pam.d/login

sudo cp change-console-color.sh /usr/local/bin/change-console-color.sh
sudo chmod +x /usr/local/bin/change-console-color.sh

sudo cp change-console-color /etc/initramfs-tools/hooks/change-console-color
sudo chmod +x /etc/initramfs-tools/hooks/change-console-color
sudo update-initramfs -u


mkdir -p ~/.config/sway/
cp config ~/.config/sway/

#Autologin
sudo raspi-config nonint do_boot_behaviour B2

sudo sed -i 's/--noclear/& --nohostname --nohints --noissue/' /etc/systemd/system/getty@tty1.service.d/autologin.conf
sed -i '1i clear\nsetterm -foreground black' ~/.profile


echo "Setup Finished. Please reboot to test"