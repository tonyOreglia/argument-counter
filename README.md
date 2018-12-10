# Unique Word Counter
Write a non-trivial program in assembly language

## Summary
Prompt user for a text file input.
Return the most commonly used word in the text file to standard output.

## Run and Debug on Docker
#### Build Image 
```
docker build -t linux-assembly .
```

#### Compile and Link
```
$ docker run --rm -v "$(pwd)":/app -w /app linux-assembly sh -c "nasm -f elf64 -F dwarf -g hellow.asm && ld -m elf_x86_64 -o hw hellow.o"
```

#### Run 
```
$ docker run --rm -v "$(pwd)":/app -w /app linux-assembly sh -c "./hw"
```

#### Debug
```
$ docker run --rm -it --cap-add=SYS_PTRACE -v "$(pwd)":/app -w /app linux-assembly sh -c "gdb hw"
```


