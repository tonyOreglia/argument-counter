current_dir = $(shell pwd)

# default assembly code location
ifeq ($(asm),)
  asm = argument-printer
endif

build-image:
	docker build -t linux-assembly .

build:
	docker run --rm -v $(current_dir):/app -w /app linux-assembly sh -c "nasm -f elf64 -F dwarf -g $(asm).asm && ld -m elf_x86_64 $(asm).o"

run: build
	docker run --rm -v $(current_dir):/app -w /app linux-assembly sh -c ./a.out

run-with-args: build
	docker run --rm -v $(current_dir):/app -w /app linux-assembly sh -c "./a.out $(args)"

debug: build
	docker run --rm -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(current_dir):/app -w /app linux-assembly sh -c "gdb a.out"

run-container:
	docker run --rm -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(current_dir):/app -w /app linux-assembly


