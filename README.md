# qmk_keymaps

Standalone keymap support for QMK.

## Features

- Put QMK in your keymaps instead of your keymaps in QMK
- Resolves flasher for you so you don't have to remember dfu/avrdude/teensy/etc

## Usage

    make flash:KEYBOARD

Or to just build:

    make build:KEYBOARD

## Install

1. Clone `qmk_firmware`
2. Clone `qmk_keymaps` next to `qmk_firmware`
3. Create a directory for your keymaps next to `qmk_firmware`
  - Create a Makefile
  - Create a keymap directory named after the keyboard
  - Place your keymap files in the keyboard directory
  - Commit your keymaps

Makefile contents (this is what glues it all together):

    include ../qmk_keymaps/rules.mk

### Options

| Option | Default | Description |
|--------|---------|-------------|
| NAME   | `whoami`| Your keymap name in QMK. |
| QMK_DIR| ../qmk_firmware | Path to qmk_firmware/ |

Check [`nicinabox/keymaps`](https://github.com/nicinabox/keymaps) for an example.

## Requirements

- Ruby >= 2.0
- avrdude/dfu-programmer/teensy-cli as needed for your keyboards

## License

MIT Copyright 2018 Nic Haynes
