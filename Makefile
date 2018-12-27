current_dir = $(shell pwd)

build = nasm -f elf64 -F dwarf -g $(asm).asm && ld -m elf_x86_64 $(asm).o

# default assembly code location
ifeq ($(asm),)
  asm = unique-word-counter
endif

build-base:
	docker build -f Dockerfile.base -t linux-assembly .

copy:
	docker build -f Dockerfile.cp -t unique-word-counter .

build: copy
	docker run --rm -w /app unique-word-counter sh -c "nasm -f elf64 -F dwarf -g $(asm).asm && ld -m elf_x86_64 $(asm).o"

run: copy
	docker run --rm -w /app unique-word-counter sh -c "$(build) && ./a.out"

run-with-args: copy
	docker run --rm -w /app unique-word-counter sh -c "$(build) && ./a.out $(args)"

debug: build
	docker run --rm -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(current_dir):/app -w /app linux-assembly sh -c "$(build) && gdb a.out"

run-container:
	docker run --rm -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(current_dir):/app -w /app linux-assembly


