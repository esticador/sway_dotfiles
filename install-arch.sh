#!/bin/bash
set -e

echo "==> Atualizando sistema"
sudo pacman -Syu --noconfirm

echo "==> Instalando pacotes base"

sudo pacman -S --needed --noconfirm \
  hyprland \
  waybar \
  rofi \
  kitty \
  btop \
  fastfetch \
  mpv \
  nautilus \
  pavucontrol \
  pipewire \
  wireplumber \
  starship \
  wl-clipboard \
  grim \
  slurp \
  polkit-gnome \
  xdg-user-dirs \
  networkmanager \
  network-manager-applet \
  xsettingsd \
  git \
  stow \
  noto-fonts \
  ttf-jetbrains-mono-nerd

echo "==> Habilitando NetworkManager"
sudo systemctl enable --now NetworkManager

# ---------------------------
# Instalar yay (AUR helper)
# ---------------------------
if ! command -v yay &> /dev/null; then
    echo "==> Instalando yay"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

echo "==> Instalando pacotes AUR"

yay -S --needed --noconfirm \
  swaync \
  nwg-look \
  nwg-panel \
  waypaper \
  python-pywal

echo "==> Atualizando diretórios padrão"
xdg-user-dirs-update

echo "==> Aplicando dotfiles com stow"

cd "$(dirname "$0")"

for dir in */ ; do
    case "$dir" in
        .git/)
            continue
            ;;
    esac
    stow "$(basename "$dir")"
done

echo "==> Setup concluído!"

