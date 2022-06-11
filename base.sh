#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "timbreza" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 timbreza.localdomain timbreza" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers xdg-user-dirs xdg-utils bluez bluez-utils pipewire pipewire-pulse bash-completion zsh openssh rsync acpi acpi_call tlp acpid os-prober ntfs-3g terminus-font dosfstools exfat-utils

pacman -S --noconfirm xf86-video-intel xf86-video-amdgpu

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=LOGOS #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable tlp
systemctl enable fstrim.timer
systemctl enable acpid

useradd -m j
echo j:password | chpasswd

echo "j ALL=(ALL) ALL" >> /etc/sudoers.d/j


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
