NAME = $(shell whoami)
QMK_DIR = ../qmk_firmware
KEYBOARDS_PATH = $(QMK_DIR)/keyboards
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: cp/handwired/%
cp/handwired/%:
	@mkdir -p $(KEYBOARDS_PATH)/handwired/$*
	@cp -r handwired/$*/* $(KEYBOARDS_PATH)/handwired/$*

.PHONY: build\:handwired/%
build\:handwired/%: cp/handwired/%
	@cd $(QMK_DIR) && make handwired/$*

.PHONY: flash\:handwired/%
flash\:handwired/%: cp/handwired/%
	@cd $(QMK_DIR) && make handwired/$*:$(shell ruby $(ROOT_DIR)/programmer.rb $(KEYBOARDS_PATH)/handwired/$*)

.PHONY: cp/%
cp/%:
	@mkdir -p $(KEYBOARDS_PATH)/$*/keymaps/$(NAME)
	@cp -r $*/* $(KEYBOARDS_PATH)/$*/keymaps/$(NAME)

.PHONY: build\:%
build\:%: cp/%
	@cd $(QMK_DIR) && make $*:$(NAME)

.PHONY: flash\:%
flash\:%: cp/%
	@cd $(QMK_DIR) && make $*:$(NAME):$(shell ruby $(ROOT_DIR)/programmer.rb $(KEYBOARDS_PATH)/$*)
