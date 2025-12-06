CC = gcc
CFLAGS = -Wall -O2
LINUX_SRC = src/linux/main.c
WINDOWS_SRC = src/windows/main.c
LINUX_OUT = dist/linux/bin/ws_handler
WINDOWS_OUT = dist/windows/bin/ws_handler.exe

# Try to find libevdev include path
LIBEVDEV_INC = $(shell find /usr/include -name "libevdev.h" 2>/dev/null | head -n 1 | xargs dirname | xargs dirname)
ifneq ($(LIBEVDEV_INC),)
	CFLAGS += -I$(LIBEVDEV_INC)
endif

.PHONY: all linux windows clean

all: linux

linux:
	@mkdir -p $(dir $(LINUX_OUT))
	$(CC) $(CFLAGS) -o $(LINUX_OUT) $(LINUX_SRC) -levdev
	@echo "Linux binary built at $(LINUX_OUT)"

windows:
	@mkdir -p $(dir $(WINDOWS_OUT))
	x86_64-w64-mingw32-gcc $(CFLAGS) -o $(WINDOWS_OUT) $(WINDOWS_SRC) -lvjoyinterface
	@echo "Windows binary built at $(WINDOWS_OUT)"

clean:
	rm -f $(LINUX_OUT) $(WINDOWS_OUT)
