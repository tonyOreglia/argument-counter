current_dir = $(shell pwd)

build-image:
	docker build -t linux-assembly .

build:
	docker run --rm -v $(current_dir):/app -w /app linux-assembly sh -c "nasm -f elf64 -F dwarf -g hellow.asm && ld -m elf_x86_64 -o hw hellow.o"

run: 
	docker run --rm -v "$(current_dir)":/app -w /app linux-assembly sh -c "./hw"

debug: 
	docker run --rm -it --cap-add=SYS_PTRACE -v "$(current_dir)":/app -w /app linux-assembly sh -c "gdb hw"


