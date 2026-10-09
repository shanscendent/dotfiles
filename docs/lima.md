## Lima VMs

To get lima VMs to work on macos

```bash
brew install lima -y
limactl start
limactl start template:ubuntu --name=ubuntu-vm
infocmp -x xterm-ghostty | limactl shell ubuntu-vm tic -x -
limactl shell ubuntu-vm
```

Treesitter compile will crash due to OOM

```bash
limactl edit --set '.memory = "8GiB"' ubuntu-vm
```
