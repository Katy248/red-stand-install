# Red stand install script

## What is this script do?

- [X] Install programs
- [X] Add desktop icons
- [ ] Change sleep settings
  - [X] GNOME
  - [X] KDE
  - [ ] Mate

## Packages to install

### `RPM` packages

- firefox
- yandex-browser-stable
- microsoft-edge-stable
- google-chrome-stable
- gimp
- r7-office
- master-pdf-editor
- thunderbird
- [chromium-gost](https://github.com/deemru/Chromium-Gost/releases/download/126.0.6478.56/chromium-gost-126.0.6478.56-linux-amd64.rpm)
- [my-office](https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm)
- snapd
- flatpak

### `Snap` packages

- skype

### `Flatpak` packages

- us.zoom.Zoom
- com.valvesoftware.Steam
- com.anydesk.Anydesk

## One script run

To run script without git run this:

```bash
sudo curl https://raw.githubusercontent.com/Katy248/red-stand-install/main/scripts/one-script-install.sh | bash
```

To only clone repository and run script on your own run this:

```bash
sudo curl https://raw.githubusercontent.com/Katy248/red-stand-install/main/scripts/one-script.sh | bash
```

## Usage

`./install.sh [options]`

Options:

- `--install-programs`
- `--add-shortcuts`
- `--disable-screenlock`
