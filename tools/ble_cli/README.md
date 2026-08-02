# BLE CLI for Linux

This is a small command-line BLE GATT tool for native Ubuntu/Linux hosts. It is meant for firmware debugging: scan devices, inspect services and characteristics, read values, write hex payloads, and subscribe to notifications.

The tool uses Python and [Bleak](https://bleak.readthedocs.io/), which uses BlueZ on Linux.

## When To Use This

Use this tool when you want a Linux-friendly replacement for the older Windows WinForms BLE UI under `tools/BLE_UI`.

It supports:

- BLE device scanning
- GATT service and characteristic discovery
- Characteristic reads
- Characteristic writes with or without response
- Notification/indication subscription

It does not include the old 3D cuboid/quaternion visualization yet. Notification output is printed as timestamped hex bytes, which is usually the most useful starting point for firmware work.

## Native Ubuntu Setup

Install system packages:

```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip bluez bluetooth rfkill
```

Make sure Bluetooth is enabled:

```bash
sudo systemctl enable --now bluetooth
rfkill list bluetooth
sudo rfkill unblock bluetooth
```

Create a virtual environment:

```bash
cd tools/ble_cli
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Run a scan:

```bash
python ble_tool.py scan
python ble_tool.py scan --name Simple -v
```

## Usage

List nearby devices:

```bash
python ble_tool.py scan --timeout 15
```

List services and characteristics:

```bash
python ble_tool.py services AA:BB:CC:DD:EE:FF
python ble_tool.py services AA:BB:CC:DD:EE:FF --descriptors
```

Read a characteristic:

```bash
python ble_tool.py read AA:BB:CC:DD:EE:FF 0000ffe1-0000-1000-8000-00805f9b34fb
python ble_tool.py read AA:BB:CC:DD:EE:FF 0000ffe1-0000-1000-8000-00805f9b34fb --text
```

Write hex bytes:

```bash
python ble_tool.py write AA:BB:CC:DD:EE:FF 0000ffe1-0000-1000-8000-00805f9b34fb "01 02 03"
python ble_tool.py write AA:BB:CC:DD:EE:FF 0000ffe1-0000-1000-8000-00805f9b34fb 010203 --without-response
```

Subscribe to notifications:

```bash
python ble_tool.py notify AA:BB:CC:DD:EE:FF 0000ffe1-0000-1000-8000-00805f9b34fb
```

Stop notifications with `Ctrl+C`.

## Docker Usage On Native Linux

Docker BLE access works best on a real Linux host where BlueZ controls the Bluetooth adapter. The container should use the host network and the host system D-Bus socket.

Build the image:

```bash
cd tools/ble_cli
docker build -t cc2640r2-ble-cli .
```

Run a scan:

```bash
docker run --rm -it \
  --net=host \
  --privileged \
  -v /run/dbus:/run/dbus \
  cc2640r2-ble-cli scan --timeout 15
```

List services:

```bash
docker run --rm -it \
  --net=host \
  --privileged \
  -v /run/dbus:/run/dbus \
  cc2640r2-ble-cli services AA:BB:CC:DD:EE:FF --descriptors
```

Subscribe to notifications:

```bash
docker run --rm -it \
  --net=host \
  --privileged \
  -v /run/dbus:/run/dbus \
  cc2640r2-ble-cli notify AA:BB:CC:DD:EE:FF 0000ffe1-0000-1000-8000-00805f9b34fb
```

## WSL Notes

This tool is designed for native Ubuntu/Linux first. WSL usually does not expose the Windows Bluetooth adapter as a normal Linux BlueZ adapter. If you need BLE from WSL, use a USB Bluetooth dongle passed through with `usbipd-win`, then run BlueZ inside WSL. Native Linux is simpler and more reliable.

## Troubleshooting

Check that BlueZ sees an adapter:

```bash
bluetoothctl list
bluetoothctl show
```

If no adapter appears:

```bash
sudo systemctl status bluetooth
rfkill list bluetooth
```

If Docker cannot see Bluetooth devices, verify the host can scan first:

```bash
bluetoothctl scan on
```

Then retry the container with `--net=host`, `--privileged`, and `/run/dbus` mounted.
