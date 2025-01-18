## Create `uinput` group

```bash
sudo groupadd uinput
```
  
## Add user to group

```bash
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
```

### Create udev rule

At `/etc/udev/rules.d/kanata.rules`

```rules
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
```

## Set right permission

```bash
sudo chmod +x /etc/udev/rules.d/kanata-input.rules
```

## Load drivers

```bash
sudo modprobe uinput
```

## Create service

```service
[Unit]
Description=Kanata Service
Requires=local-fs.target
After=local-fs.target

[Service]
ExecStartPre=/usr/sbin/modprobe uinput
ExecStart=/usr/bin/kanata -c /home/bine/.config/kanata/kanata.kbd
Restart=no

[Install]
WantedBy=sysinit.target
```

## Start and enable service

```bash
sudo systemctl start kanata.service
sudo systemctl enable kanata.service
```
