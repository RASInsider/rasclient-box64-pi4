# Parallels RAS Linux amd64 on Raspberry Pi 4 via Box64

Unofficial experimental proof of concept for running the Parallels RAS Linux
amd64 client on Raspberry Pi OS ARM64 using Box64.

## Status

Validated on one Raspberry Pi 4 ARM64 laboratory system running Raspberry Pi OS
Trixie in QEMU on an Apple Silicon Mac:

- Box64 starts the official amd64 `appserverclient` binary.
- `2XClient` starts with Qt/XCB.
- A private RAS Gateway connection succeeds over SSL.
- The published-application list is displayed.
- A published Windows application (Notepad) launches successfully.

This is not validated on Raspberry Pi 3, 5, or other ARM64 boards. It is not a
Parallels product, is not supported or endorsed by Parallels, and is not a
replacement for an official ARM64 client.

## Important licensing notice

This repository does not contain the Parallels client, its libraries, or a
prebuilt `.deb`. You must obtain the official Parallels RAS Linux amd64 package
under your own licence and provide it locally to the build script.

Parallels, the Parallels logo, and Parallels RAS are trademarks and/or
copyrighted properties of Parallels International GmbH. This project is an
independent laboratory integration and does not represent Parallels. Do not
redistribute Parallels binaries or the generated package unless your agreement
with Parallels explicitly permits it.

## Build on a Raspberry Pi 4

Run the scripts on the Pi itself. The build needs network access for Debian
packages and the Box64 source, and a working official Parallels `.deb`.

```sh
export RASCLIENT_DEB="$HOME/Downloads/RASClient-22.0.28160_x86_64.deb"
./scripts/build-box64-pi4.sh
./scripts/build-x86-root.sh
./scripts/build-rasclient-deb.sh
sudo apt install ./rasclient-box64_0.1.0_arm64.deb
```

The resulting package installs:

- `rasclient-box64` — graphical Parallels Client launcher;
- `rasclient-appserverclient` — published-application launcher;
- a desktop/menu entry for the graphical client.

The generated package is for private testing and is intentionally not stored
in this repository.

## Scope and limitations

The POC was validated with one RAS 22 laboratory Gateway and one published
application. USB and some peripheral integrations produced warnings during
the test. Authentication, MFA variants, printing, smart cards, USB redirection,
clipboard edge cases, audio, multi-monitor behavior, upgrades, and production
performance require separate validation.

Never use this project to bypass licensing, authentication, certificate checks,
or server security controls.
