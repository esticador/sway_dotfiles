#!/bin/bash
set -e

echo "==> Atualizando sistema"
sudo dnf update -y

echo "==> Instalando pacotes essenciais"

sudo dnf install -y \
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
  swaync \
  nwg-look \
  nwg-panel \
  waypaper \
  xsettingsd \
  NetworkManager \
  network-manager-applet \
  wl-clipboard \
  grim \
  slurp \
  polkit-gnome \
  xdg-user-dirs \
  git \
  stow \
  python3 \
  python3-pip \
  jetbrains-mono-fonts

echo "==> Instalando pywal"
pip3 install --user pywal

echo "==> Habilitando NetworkManager"
sudo systemctl enable --now NetworkManager

echo "==> Atualizando diretórios padrão"
xdg-user-dirs-update

echo "==> Aplicando dotfiles com stow"

# vai para a pasta do script (assumindo que está dentro do repo)
cd "$(dirname "$0")"

for dir in */ ; do
    case "$dir" in
        packages/|install/|.git/)
            continue
            ;;
    esac
    echo "Aplicando $dir"
    stow "$(basename "$dir")"
done

echo "==> Setup concluído!"
