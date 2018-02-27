NAME = $(shell whoami)
QMK_DIR = ../qmk_firmware
KEYBOARDS_PATH = $(QMK_DIR)/keyboards
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
QMK_KEYMAPS_VERSION = 1.0.0

.PHONY: version
version:
	@echo $(QMK_KEYMAPS_VERSION)

.PHONY: cp/handwired/%
cp/handwired/%:
	@mkdir -p $(KEYBOARDS_PATH)/handwired/$*
	@cp -r handwired/$*/* $(KEYBOARDS_PATH)/handwired/$*

.PHONY: build\:handwired/%
build\:handwired/%: cp/handwired/%
	@cd $(QMK_DIR) && make handwired/$*

.PHONY: flash\:handwired/%
flash\:handwired/%: cp/handwired/%
	@FLASHER=$(shell ruby $(ROOT_DIR)/bootloader.rb $(KEYBOARDS_PATH)/handwired/$*); \
	cd $(QMK_DIR) && make handwired/$*:$$FLASHER

.PHONY: cp/%
cp/%:
	@mkdir -p $(KEYBOARDS_PATH)/$*/keymaps/$(NAME)
	@cp -r $*/* $(KEYBOARDS_PATH)/$*/keymaps/$(NAME)

.PHONY: build\:%
build\:%: cp/%
	@cd $(QMK_DIR) && make $*:$(NAME)

.PHONY: flash\:%
flash\:%: cp/%
	@FLASHER=$(shell ruby $(ROOT_DIR)/bootloader.rb $(KEYBOARDS_PATH)/$*); \
	cd $(QMK_DIR) && make $*:$(NAME):$$FLASHER
