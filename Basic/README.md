# Table of Contents <!-- omit from toc -->

- [SSH](#ssh)
  - [Generate SSH key](#generate-ssh-key)
  - [Add SSH key to ssh-agent](#add-ssh-key-to-ssh-agent)
  - [Start SSH server](#start-ssh-server)
  - [Add SSH key to server](#add-ssh-key-to-server)
  - [SSH config](#ssh-config)
    - [Only allow SSH key authentication](#only-allow-ssh-key-authentication)
- [VNC](#vnc)
  - [Ubuntu](#ubuntu)
- [Package managers](#package-managers)
  - [APT](#apt)
  - [Brew](#brew)
  - [Snap](#snap)
  - [PIP](#pip)
  - [Chocolatey](#chocolatey)
- [Shell](#shell)
  - [Linux](#linux)
  - [Windows](#windows)



&nbsp;
# SSH

## Generate SSH key

```bash
ssh-keygen -t ed25519 -b 4096 -f "~/.ssh/{keyname}" -C "{name/email}"
```

## Add SSH key to ssh-agent

```bash
ssh-agent -k ; eval "$(ssh-agent -s)"  # kill and start ssh-agent [optional]
ssh-add ~/.ssh/{keyname}
```

## Start SSH server

```bash
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
sudo ufw allow ssh  # [optional]
```

## Add SSH key to server
  
```bash
ssh-copy-id -i ~/.ssh/{keyname}.pub {user}@{host}
```

## SSH config

### Only allow SSH key authentication

**Note**: Make sure to add your SSH Public Key using `ssh-copy-id` or paste it to `~/.ssh/authorized_keys` on the server before disabling password authentication, otherwise you will be locked out.


```bash
sudo nano /etc/ssh/sshd_config

---------------------------------------------------------
PermitRootLogin no
#PermitRootLogin prohibit-password

PasswordAuthentication no
UsePAM no
ChallengeResponseAuthentication no
PrintMotd no # [optional]
---------------------------------------------------------

sudo systemctl reload ssh
```

# VNC

## Ubuntu

```bash
sudo apt install -y xfce4 xfce4-goodies tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer dbus-x11
```

```bash
sudo nano ~/.vnc/xstartup

---------------------------------------------------------
#!/bin/sh
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
#vncconfig -iconic
#dbus-launch --exit-with-session gnome-session &
startxfce4
----------------------------------------------------------

sudo chmod +x ~/.vnc/xstartup
```

```bash
crontab -e

---------------------------------------------------------
@reboot vncserver -localhost 0 :1
---------------------------------------------------------
```

&nbsp;
# Package managers

## APT

```bash
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y 
```

## Brew

```bash
brew update && brew upgrade && brew cleanup --prune=all -s
```

## Snap

```bash
sudo snap refresh
```

## PIP

```bash
python3 -m pip list --outdated --format=json | jq -r '.[] | "\(.name)==\(.latest_version)"' | xargs -n1 pip3 install -U
```

## Chocolatey

```bash
choco upgrade all -y
```

&nbsp;
# Shell

Favorite Background: [YoRHa Background](https://raw.githubusercontent.com/snowline2015/Personal/main/Pictures/Terminal/YoRHa.png)

## Linux

Favorite: Iterm2 (MacOS) + [Fish](https://github.com/fish-shell/fish-shell) + [Dracula](https://github.com/dracula/iterm) + [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md) ([*Neolambda*](https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md#neolambda-1))

**Add Fish default shell**

```bash
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```

## Windows

Favorite: Terminal + [Dracula](https://draculatheme.com/windows-terminal) + [Oh My Posh](https://ohmyposh.dev/docs/themes) ([*kali*](https://ohmyposh.dev/docs/themes#kali))






