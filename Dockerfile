FROM debian:jessie
WORKDIR /app
COPY hellow.asm ./

RUN apt-get update -y && apt-get install build-essential gdb nasm vim -y