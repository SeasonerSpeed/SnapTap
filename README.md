# Snap Tap for AutoHotkey v2

A lightweight AutoHotkey v2 script that adds **Snap Tap-style movement** to any keyboard.

## ✨ Features

- A/D Snap Tap
- W/S Snap Tap
- Simple ON/OFF toggle
- Clean background GUI
- Automatically releases the opposite movement key
- Automatically releases movement keys when disabled or closed
- Works with standard keyboards — no special hardware required

## 🖥️ How It Works

Snap Tap prioritizes the most recently pressed movement key.

For example:

```text
Hold A
   ↓
Press D
   ↓
A is released
   ↓
D becomes the active direction
```

The same behavior works with **W/S**.

## 📦 Requirements

- Windows
- [AutoHotkey v2](https://www.autohotkey.com/)
- Any keyboard

## 🚀 Installation

1. Install **AutoHotkey v2**.
2. Download `SnapTap.ahk` from this repository.
3. Double-click `SnapTap.ahk`.
4. The Snap Tap window will appear.
5. Click **Enable** or **Disable** whenever you want.

## 🎮 Supported Keys

| Keys | Feature |
|------|---------|
| A + D | Horizontal Snap Tap |
| W + S | Vertical Snap Tap |

## 🟢 Using Snap Tap

When Snap Tap is enabled:

```text
A → D
```

Pressing **D** while holding **A** automatically releases **A**.

Likewise:

```text
D → A
```

Pressing **A** while holding **D** automatically releases **D**.

The same behavior applies to **W/S**.

## 🔴 Disabling Snap Tap

Click **Disable** in the GUI.

The script will release:

```text
A
D
W
S
```

and return your movement keys to normal behavior.

## ⚙️ How It Works

The script uses AutoHotkey's `GetKeyState()` to check whether the opposite movement key is physically being held.

For example:

```ahk
if GetKeyState("d", "P")
    Send "{d up}"
```

If **D** is physically held while **A** is pressed, the script releases D.

## ⚠️ Disclaimer

This project is an **AutoHotkey-based implementation inspired by Snap Tap-style input behavior**.

It is **not Razer's official Snap Tap implementation** and does not require Razer hardware.

Use it responsibly and check the rules of any game or tournament before using input automation software.

## 📄 License

This project is provided for personal and educational use.
