#!/bin/bash

# Options
aur_helper=true

sudo timedatectl set-ntp true
sudo hwclock --systohc

# sudo firewall-cmd --add-port=1025-65535/tcp --permanent
# sudo firewall-cmd --add-port=1025-65535/udp --permanent
# sudo firewall-cmd --reload

if [[ $aur_helper = true ]]; then
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru/;makepkg -si --noconfirm;cd
fi


echo "MAIN PACKAGES"
sleep 5

sudo pacman -S xorg firefox polkit-gnome xwallpaper lxappearance ranger ueberzug bc picom arandr libnotify dunst sxiv ffmpeg ffmpegthumbnailer gnome-keyring neovim mpd mpc mpv man-db ncmpcpp noto-fonts-emoji pamixer maim unclutter unzip lynx xcape xclip xdotool yt-dlp zathura zathura-pdf-mupdf poppler mediainfo atool fzf bat moreutils


echo "installing brave"
sleep 5

paru -S --noconfirm brave-bin


echo "intalling fonts"
sleep 5

# Install fonts
sudo pacman -S --noconfirm dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji


echo "suck less"
sleep 5

# Pull Git repositories and install
cd /tmp
repos=( "dmenu" "dwm" "st" )
for repo in ${repos[@]}
do
    git clone git://git.suckless.org/$repo
    cd $repo;make;sudo make install;cd ..
done

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
