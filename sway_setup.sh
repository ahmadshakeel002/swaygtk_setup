sudo apt update
sudo apt install python3-pip python3-gi gir1.2-gtk-3.0 mpv sway -y

sudo apt-get install pix-plym-splash -y

mkdir -p /home/pi/.config/i3/
echo "exec /home/pi/start.sh" > /home/pi/.config/i3/config

cp file.mp4 /home/pi/
cp code.py /home/pi/
cp start.sh /home/pi/
sudo chmod +x /home/pi/start.sh

sudo echo "disable_splash=1" >> /boot/config.txt
sudo sed -i 's/console=tty1/console=tty3/g' /boot/cmdline.txt
sudo sed -i '1s/$/ quiet splash plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0/' /boot/cmdline.txt
sudo cp splash.png /usr/share/plymouth/themes/pix/
sudo plymouth-set-default-theme --rebuild-initrd pix

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

#Autologin
sudo raspi-config nonint do_boot_behaviour B2

echo "Setup Finished. Please reboot to test"