# Setting up GPD Pocket 3

Some documentation on setting up the i3-1125G4 GPD Pocket 3 with Omarchy 4.

I don't quite like how it's completely vibe coded and want to check out ML4W or cachyos-hypr-noctalia but it's just much easier to upgrade from Omarchy 3 at the moment.

The tips below are for P3, Arch or Hyprland quirks in no particular order, as Ubuntu mostly works out of the box.

Here are some additional tips on the [ArchWiki](https://wiki.archlinux.org/title/GPD_Pocket_3).

## Omarchy fixes for my dotfiles

Omarchy ships with a tmux config, which I don't want to use.

Rename ~/.config/tmux/tmux.conf to tmux.conf.bak

## Setup

Install Omarchy from the ISO installer

## Pocket 3 fixes

Boot and login screen rotation

```
# add to /boot/limine.conf
interface_rotation: 90
# add to /etc/default/limine
KERNEL_CMDLINE[default]+="video=DSI-1:panel_orientation=right_side_up"

# then run
sudo limine-update
```

Hyprland

- Rotate P3 monitor, touchscreen, hold down middle click to scroll with both thumbs easily

```
# ~/.config/hypr/monitors.lua
hl.monitor({ output = "DSI-1", mode = "preferred", position = "auto", scale = omarchy_monitor_scale, transform = 3 })
# ~/.config/hypr/input.lua
hl.config({
	input = {
		touchdevice = {
			transform = 3,
		},
		scroll_method = "on_button_down",
		scroll_button = 274,
	},
})
```

- Some additional stuff to bind to the lid switch (might not be needed anymore)

```
# ~/.config/hypr/bindings.conf
# Switch
# trigger when the switch is turning off
bindl = , switch:off:Lid Switch, exec, hyprctl keyword input:touchdevice:enabled true
# trigger when the switch is turning on
bindl = , switch:on:Lid Switch, exec, hyprctl keyword input:touchdevice:enabled false
bindl = , switch:on:Lid Switch, exec, hyprlock --immediate
```

- Idle settings in `~/.config/omarchy/shell.json`, also toggleable with `omarchy toggle idle`

## Screen auto rotation

The `iio-hyprland-git` version in the AUR is a bit old, let's use the latest fork with hyprland lua support (needs meson to build)

```bash
yay -S iio-sensor-proxy meson
cd /tmp
git clone https://github.com/ThorTuwy/lua-iio-hyprland
cd lua-iio-hyprland
sudo make install
```

```
# ~/.config/hypr/input.lua
hl.on("hyprland.start", function()
	hl.exec_cmd("iio-hyprland DSI-1")
end)
```

## Fingerprint sensor setup

Outdated? Might not need these instructions anymore.

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

Ain't nobody here but us chickens!

## References

- https://wiki.archlinux.org/title/Backlight
- https://bbs.archlinux.org/viewtopic.php?id=284664
