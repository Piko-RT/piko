TOP = user/mpy
PY_SRC ?= $(TOP)/py
BUILD = $(TOP)/build
PY_BUILD = $(BUILD)/py

# where autogenerated header files go
HEADER_BUILD = $(BUILD)/genhdr

# file containing qstr defs for the core Python bit
PY_QSTR_DEFS = $(PY_SRC)/qstrdefs.h

include $(TOP)/py.mk

# If qstr autogeneration is not disabled we specify the output header
# for all collected qstrings.
ifneq ($(QSTR_AUTOGEN_DISABLE),1)
QSTR_DEFS_COLLECTED = $(HEADER_BUILD)/qstrdefs.collected.h
endif

CP = cp
MKDIR = mkdir
SED = sed
PYTHON = python3

CFLAGS += \
	-Iuser/mpy \
	-Iuser/mpy/build \

CSRC += \
	$(wildcard user/mpy/py/*.c) \
	user/mpy/mphalport.c \
	user/mpy/_frozen_mpy.c \
	user/mpy/lib/utils/pyexec.c \
	user/mpy/lib/mp-readline/readline.c \
	user/mpy/extmod/moductypes.o \
	user/mpy/extmod/modujson.o \
	user/mpy/extmod/modure.o \
	# user/mpy/extmod/moduzlib.o \
	# user/mpy/extmod/moduheapq.o \
	# user/mpy/extmod/modutimeq.o \
	# user/mpy/extmod/moduhashlib.o \
	# user/mpy/extmod/modubinascii.o \
	# user/mpy/extmod/virtpin.o \
	# user/mpy/extmod/machine_mem.o \
	# user/mpy/extmod/machine_pinbase.o \
	# user/mpy/extmod/machine_signal.o \
	# user/mpy/extmod/machine_pulse.o \
	# user/mpy/extmod/machine_i2c.o \
	# user/mpy/extmod/machine_spi.o \
	# user/mpy/extmod/modussl_axtls.o \
	# user/mpy/extmod/modussl_mbedtls.o \
	# user/mpy/extmod/modurandom.o \
	# user/mpy/extmod/moduselect.o \
	# user/mpy/extmod/modwebsocket.o \
	# user/mpy/extmod/modwebrepl.o \
	# user/mpy/extmod/modframebuf.o \
	# user/mpy/extmod/vfs.o \
	# user/mpy/extmod/vfs_reader.o \
	# user/mpy/extmod/vfs_fat.o \
	# user/mpy/extmod/vfs_fat_diskio.o \
	# user/mpy/extmod/vfs_fat_file.o \
	# user/mpy/extmod/vfs_fat_misc.o \
	# user/mpy/extmod/utime_mphal.o \
	# user/mpy/extmod/uos_dupterm.o \
	# user/mpy/lib/embed/abort_.o \

CSRC := $(filter-out user/mpy/py/frozen_mpy.o, $(CSRC))

include $(TOP)/py/mkrules.mk