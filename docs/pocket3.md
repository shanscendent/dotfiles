# Setting up GPD Pocket 3

Some documentation on setting up the i3-1125G4 GPD Pocket 3 on Arch. We'll be using Omarchy for its excellent theming and Hyprland defaults.

The tips below are for P3, Arch or Hyprland quirks in no particular order, as Ubuntu mostly works out of the box.

## Setup

Install Arch, run Omarchy installer

## Pocket 3 fixes

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

#TODO: Doesn't work yet!

```bash
yay -S libvirt virt-manager qemu-full dnsmasq
```

Add section for wayland 3d acceleration

## References

- https://wiki.archlinux.org/title/Backlight
- https://forums.gentoo.org/viewtopic-p-8674890.html
