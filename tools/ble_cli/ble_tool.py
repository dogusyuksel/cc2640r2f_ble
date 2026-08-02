#!/usr/bin/env python3
"""Small BLE GATT inspection tool for Linux hosts.

The tool intentionally keeps the workflow close to firmware debugging:
scan, list services/characteristics, read, write, and subscribe to notify.
It uses Bleak, which talks to BlueZ on Linux.
"""

from __future__ import annotations

import argparse
import asyncio
import sys
from datetime import datetime
from typing import Iterable

from bleak import BleakClient, BleakScanner
from bleak.exc import BleakError


def bytes_from_hex(text: str) -> bytes:
    compact = text.replace("0x", "").replace(",", " ").replace(":", " ")
    parts = compact.split()
    if len(parts) == 1 and len(parts[0]) > 2:
        raw = parts[0]
        if len(raw) % 2:
            raise argparse.ArgumentTypeError("hex string must contain an even number of digits")
        parts = [raw[i : i + 2] for i in range(0, len(raw), 2)]
    try:
        return bytes(int(part, 16) for part in parts)
    except ValueError as exc:
        raise argparse.ArgumentTypeError(f"invalid hex byte in {text!r}") from exc


def hex_bytes(data: Iterable[int]) -> str:
    return " ".join(f"{byte:02X}" for byte in data)


async def scan(args: argparse.Namespace) -> int:
    print(f"Scanning for {args.timeout:.1f}s...")
    devices = await BleakScanner.discover(timeout=args.timeout, return_adv=True)

    rows = []
    for device, adv in devices.values():
        name = device.name or adv.local_name or ""
        if args.name and args.name.lower() not in name.lower():
            continue
        rows.append((device.address, adv.rssi, name, ",".join(str(uuid) for uuid in adv.service_uuids)))

    if not rows:
        print("No devices found.")
        return 1

    for address, rssi, name, service_uuids in sorted(rows, key=lambda row: row[2].lower()):
        print(f"{address:20} RSSI={rssi:4}  {name}")
        if args.verbose and service_uuids:
            print(f"  services: {service_uuids}")
    return 0


async def services(args: argparse.Namespace) -> int:
    async with BleakClient(args.address, timeout=args.timeout) as client:
        print(f"Connected: {client.is_connected}")
        for service in client.services:
            print(f"[service] {service.uuid}  {service.description}")
            for char in service.characteristics:
                props = ",".join(char.properties)
                print(f"  [char] {char.uuid}  handle={char.handle}  props={props}  {char.description}")
                if args.descriptors:
                    for descriptor in char.descriptors:
                        print(f"    [desc] {descriptor.uuid}  handle={descriptor.handle}  {descriptor.description}")
    return 0


async def read(args: argparse.Namespace) -> int:
    async with BleakClient(args.address, timeout=args.timeout) as client:
        data = await client.read_gatt_char(args.characteristic)
        print(hex_bytes(data))
        if args.text:
            print(data.decode(args.encoding, errors="replace"))
    return 0


async def write(args: argparse.Namespace) -> int:
    data = bytes_from_hex(args.hex)
    async with BleakClient(args.address, timeout=args.timeout) as client:
        await client.write_gatt_char(args.characteristic, data, response=not args.without_response)
        mode = "without response" if args.without_response else "with response"
        print(f"Wrote {len(data)} byte(s) {mode}: {hex_bytes(data)}")
    return 0


async def notify(args: argparse.Namespace) -> int:
    def on_notify(_: int, data: bytearray) -> None:
        ts = datetime.now().isoformat(timespec="milliseconds")
        print(f"{ts}  {hex_bytes(data)}", flush=True)

    async with BleakClient(args.address, timeout=args.timeout) as client:
        await client.start_notify(args.characteristic, on_notify)
        print("Subscribed. Press Ctrl+C to stop.")
        try:
            while True:
                await asyncio.sleep(3600)
        finally:
            await client.stop_notify(args.characteristic)
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="BLE GATT CLI for Linux/BlueZ.")
    parser.add_argument("--timeout", type=float, default=10.0, help="BLE operation timeout in seconds.")

    subparsers = parser.add_subparsers(dest="command", required=True)

    scan_parser = subparsers.add_parser("scan", help="Scan nearby BLE devices.")
    scan_parser.add_argument("--name", help="Only show devices whose advertised name contains this text.")
    scan_parser.add_argument("-v", "--verbose", action="store_true", help="Show advertised service UUIDs.")
    scan_parser.set_defaults(func=scan)

    services_parser = subparsers.add_parser("services", help="List GATT services and characteristics.")
    services_parser.add_argument("address", help="BLE device address.")
    services_parser.add_argument("--descriptors", action="store_true", help="Also list characteristic descriptors.")
    services_parser.set_defaults(func=services)

    read_parser = subparsers.add_parser("read", help="Read a characteristic value.")
    read_parser.add_argument("address", help="BLE device address.")
    read_parser.add_argument("characteristic", help="Characteristic UUID or handle.")
    read_parser.add_argument("--text", action="store_true", help="Also print the value as text.")
    read_parser.add_argument("--encoding", default="utf-8", help="Text encoding used with --text.")
    read_parser.set_defaults(func=read)

    write_parser = subparsers.add_parser("write", help="Write hex bytes to a characteristic.")
    write_parser.add_argument("address", help="BLE device address.")
    write_parser.add_argument("characteristic", help="Characteristic UUID or handle.")
    write_parser.add_argument("hex", help='Hex bytes, for example "01 02 0A" or "01020A".')
    write_parser.add_argument("--without-response", action="store_true", help="Use write-without-response.")
    write_parser.set_defaults(func=write)

    notify_parser = subparsers.add_parser("notify", help="Subscribe to notifications or indications.")
    notify_parser.add_argument("address", help="BLE device address.")
    notify_parser.add_argument("characteristic", help="Characteristic UUID or handle.")
    notify_parser.set_defaults(func=notify)

    return parser


async def async_main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    try:
        return await args.func(args)
    except KeyboardInterrupt:
        print()
        return 130
    except BleakError as exc:
        print(f"BLE error: {exc}", file=sys.stderr)
        return 2


def main() -> int:
    return asyncio.run(async_main())


if __name__ == "__main__":
    raise SystemExit(main())
