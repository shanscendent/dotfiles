# Setting up GPD Pocket 3

Some documentation on setting up the i3-1125G4 GPD Pocket 3 on Arch. We'll be using Omarchy for its excellent theming and Hyprland defaults.

The tips below are for P3, Arch or Hyprland quirks in no particular order, as Ubuntu mostly works out of the box.

Here are some additional tips on the [ArchWiki](https://wiki.archlinux.org/title/GPD_Pocket_3).

## Setup

Install Arch, run Omarchy installer

## Pocket 3 fixes

Boot and login screen rotation (boot doesn't rotate for me, but ymmv)

```
# append to options line of /boot/loader/entries/2025-08-08_03-38-37_linux.conf
fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up
```

Hyprland

- Rotate P3 monitor, touchscreen properly

```
# ~/.config/hypr/monitors.conf
monitor = DSI-1,preferred,auto,1.5,transform,3
# ~/.config/hypr/input.conf
input {
  touchdevice {
    transform = 3
  }
}
```

- Hold down middle click to scroll with one thumb easily

```
# ~/.config/hypr/input.conf
input {
  scroll_method = on_button_down
  scroll_button = 274
}
```

- Some additional stuff to bind to the lid switch

```
# ~/.config/hypr/bindings.conf
# Switch
# trigger when the switch is turning off
bindl = , switch:off:Lid Switch, exec, hyprctl keyword input:touchdevice:enabled true
# trigger when the switch is turning on
bindl = , switch:on:Lid Switch, exec, hyprctl keyword input:touchdevice:enabled false
bindl = , switch:on:Lid Switch, exec, hyprlock --immediate
```

## Screen auto rotation

```bash
yay -S iio-sensor-proxy iio-hyprland-git
```

```
# ~/.config/hypr/input.conf
exec-once = iio-hyprland DSI-1
```

## Fingerprint sensor setup

We need a proprietary libfprint from focaltech to make the sensor work.

The installation process seems to be slightly broken but the packages work great, so we'll need to rebuild the module after installing it from the AUR. We'll also set up fprintd.

```bash
yay -S fprintd focaltech-spi-dkms libfprint-ftexx00
sudo dkms status
```

You should get some output. If not, let's manually build and install it again.

```bash
sudo pacman -S linux-headers
cd /usr/src/focaltech-spi-dkms-1.0.3/
sudo dkms remove -m focaltech-spi-dkms -v 1.0.3 --all
sudo dkms add -m focaltech-spi-dkms -v 1.0.3
sudo dkms build -m focaltech-spi-dkms -v 1.0.3
sudo dkms install -m focaltech-spi-dkms -v 1.0.3
sudo dkms status
# focaltech-spi-dkms/1.0.3, 6.15.9-arch1-1, x86_64: installed
sudo modprobe focal_spi
sudo systemctl restart fprintd
```

Finally, enroll your fingerprint and it should just work!

```bash
fprintd-enroll
```

## Speakers

[This](https://github.com/Manawyrm/gpd-pocket-4-pipewire) pipewire DSP for the pocket 4 works surprisingly well for the pocket 3 as well!

The volume is a lot lower but it sounds a lot better. YMMV.

```bash
yay -S gpd-pocket-4-pipewire
```

Then configure it in audio control/pavucontrol.

## Brightness

External monitor control with ddcutil

```bash
echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf
yay -S ddcutil
ddcutil setvcp 10 <brightness>
```

## RDP

```bash
yay -S remmina freerdp
```

For proper audio and microphone redirection in Remmina, add these parameters in the Advanced tab

| Parameter                 | Setting               |
| ------------------------- | --------------------- |
| Audio output mode         | Local                 |
| Redirect local microphone | format:1,quality:high |

## Virtual machines

Setup - switch and replace iptables with iptables-nft, then change libvirt firewall backend

```bash
yay -S libvirt virt-manager qemu-full dnsmasq dmidecode iptables-nft
sudo usermod -aG libvirt $USER
# Add the following to /etc/libvirt/network.conf, then restart
firewall_backend=iptables
```

Autostart the default network

```bash
sudo virsh net-autostart default
sudo virsh net-start default
```

I did also enable ipv4 forwarding, but not sure if that's required now.

For ubuntu vms, at least, only ramfb video lets you start wayland, for some reason

For GPU acceleration, use the following settings, but it'll launch in xorg mode

- Hypervisor - Q35 chipset, UEFI firmware
- Video - Virtio, 3D acceleration enabled
- Display - Spice, Listen type None, OpenGL enabled

TODO: Enable 3D acceleration for wayland

## TODO

- Fix swayosd not showing up on internal monitor
- systemd-boot menu not rotated properly?
- auto powersave on battery
- fix weird graphical glitches on grouped windows

## References

- https://wiki.archlinux.org/title/Backlight
- https://bbs.archlinux.org/viewtopic.php?id=284664
