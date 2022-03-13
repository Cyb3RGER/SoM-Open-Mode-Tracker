# Secret of Mana Open World Tracker Package for PopTracker

This a tracker package for PopTracker or other comapible programms to use with the Open World Mode of the [Secret of Mana Randomizer](https://secretofmanaancientcave.blogspot.com).

Also check out the Secret of Mana Randomizer Discord [here](https://discord.gg/YfmUHqU).

PopTracker can be found [here](https://github.com/black-sliver/PopTracker/releases).

Alternatively, EmoTracker can be found [here](https://emotracker.net).

## Installation

Just download the lastest build and put in your packs folder (as a zip or unpacked, both works).

### PopTracker

For PopTracker the packs folder can be under `USER/Documents/PopTracker/packs`, `USER/PopTracker/packs` or `APP/packs`, where `USER` stands for your user directory and `APP` for the PopTracker installation directory.

### EmoTracker

For EmoTracker the packs folder can be found under `USER/Documents/EmoTracker/packs`, where `USER` stands for your user directory.

## Customization

### PopTracker

For Customization in PopTracker just edit the pack's files. Documenation for PopTracker's pack format can be found [here](https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md).
For example: if you want to change the broadcast layout, you can add your desired layout to the `layout/broadcast.json` file.
Make sure you have you layout backed up tho, so you don't lose it when you override the file while updating the pack.

### EmoTracker

For Customization in EmoTracker you overwrite the pack's file by placing the file in EmoTracks overrides folder (`USER/Documents/EmoTracker/user_overides`). Good luck finding a documenation for EmoTracker tho :3.

## Autotracking

This pack supports autotracking for items and locations in PopTracker.
Requirements for Autotracking in PopTracker can be found [here](https://github.com/black-sliver/PopTracker/#auto-tracking).

## Known Issues

Role randomizer features are not supported in EmoTracker.

## Troubleshooting

### My Items are being tracked correctly but the Locations are not being tracked

If you are using an emulator it is most likely that you are using an emulator that does not allow the tracker to access the ROM. For example snes9x 1.5X and below does not allow that. Update to snes9x 1.60+ in that case.

If you are on hardware it is possible that the pack reads garbage as the event table before the game is started. Normally a reload of the pack should fix this. If not close the tracker and start it **after** the game is started.
