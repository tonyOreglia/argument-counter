FROM debian:jessie
WORKDIR /app
COPY hellow.asm ./

RUN apt-get update -y && apt-get install build-essential gdb nasm vim -y

RUN ["nasm", "-f", "elf64", "-F", "dwarf", "-g", "hellow.asm"]

RUN ["ld", "-m", "elf_x86_64", "-o", "hw", "hellow.o"]

CMD /bin/bash