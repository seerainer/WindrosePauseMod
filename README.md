# Windrose Pause Mod

A pause toggle mod for [Windrose](https://store.steampowered.com/app/3041230/Windrose/) (Steam) built on [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS). Freeze and unfreeze the game at any time with a single keypress.

---

## Keybinds

| Key | Action |
|-----|--------|
| `Pause/Break` | Toggle pause on/off |
| `Ctrl+P` | Toggle pause on/off (alternative) |

> **Note:** Works in solo / offline play only. In multiplayer the server is authoritative and the pause request may be ignored.

---

## Requirements

- **Windrose** — Steam version (App ID 3041230), Unreal Engine 5.6.1 build
- **UE4SS** experimental build `RE-UE4SS-43-Client-g265115c0-1777160526` — included in this release

---

## Installation

1. **Locate your Windrose `Win64` folder.** The default path is:
   ```
   C:\Program Files (x86)\Steam\steamapps\common\Windrose\R5\Binaries\Win64
   ```

2. **Copy the contents of the `Win64\` folder** from this release into that directory. Merge when prompted — no existing game files will be overwritten.

   Your `Win64\` folder should look like this afterward:
   ```
   Win64\
   ├── dwmapi.dll                   ← UE4SS loader hook
   └── ue4ss\
       ├── UE4SS.dll                ← UE4SS runtime
       ├── UE4SS-settings.ini       ← pre-configured for Windrose
       └── Mods\
           ├── mods.txt             ← mod load order
           ├── PauseMod\
           │   └── scripts\
           │       └── main.lua     ← pause mod script
           ├── shared\              ← UE4SS shared Lua libraries
           └── ...                  ← other stock UE4SS mods
   ```

3. **Launch Windrose** normally through Steam.

4. **Load into a level**, then press `Pause/Break` or `Ctrl+P` to toggle pause.

---

## Verification

After launching, open `Win64\ue4ss\UE4SS.log`. A successful load looks like:

```
Starting Lua mod 'PauseMod'
[PauseMod] Loaded. Pause/Break or Ctrl+P to toggle pause.
```

When toggling in-game:

```
[PauseMod] Game PAUSED
[PauseMod] Game RESUMED
```

---

## Uninstallation

Delete these two entries from your `Win64\` folder:

```
Win64\dwmapi.dll
Win64\ue4ss\
```

No game files are modified by this mod.

---

## Troubleshooting

**Nothing happens when I press the key**
- Make sure you are fully loaded into a level. The mod does not work from the main menu.
- Check `UE4SS.log` for any errors on startup.

**The game paused but I can't unpause**
- Press the same key again. UE4SS keybind callbacks run on a native thread and remain active while the game is paused.
- If you are still stuck, close the game with `Alt+F4` or Task Manager.

**UE4SS.log shows `Fatal Error: Engine version is not supported`**
- Verify `UE4SS-settings.ini` contains the following under `[EngineVersionOverride]`:
  ```ini
  MajorVersion = 5
  MinorVersion = 6
  ```
- Make sure you are using the exact UE4SS build listed in [Requirements](#requirements).
