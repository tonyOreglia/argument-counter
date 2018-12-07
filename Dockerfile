FROM debian:jessie
WORKDIR /app
COPY hellow.asm ./

RUN apt-get update -y && apt-get install build-essential gdb nasm vim -y

RUN ["nasm", "-f", "elf64", "-o", "hello_world.o", "hellow.asm"]

RUN ld hello_world.o -o hw

CMD ./hw