current_dir = $(shell pwd)

# default assembly code location
ifeq ($(asm),)
  asm = "hellow"
endif

build-image:
	docker build -t linux-assembly .

build:
	docker run --rm -v $(current_dir):/app -w /app linux-assembly sh -c "nasm -f elf64 -F dwarf -g $(asm).asm && ld -m elf_x86_64 $(asm).o"

run: 
	docker run --rm -v "$(current_dir)":/app -w /app linux-assembly sh -c "./a.out"

debug: 
	docker run --rm -it --cap-add=SYS_PTRACE -v "$(current_dir)":/app -w /app linux-assembly sh -c "gdb a.out"


