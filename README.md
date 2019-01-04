## Summary
Goal started out to Write a trivial program in x86_64 assembly language. 

This program prints out the number of arguments provided to the program and prints them out to the terminal. 

`nasm` is used for compiling the program, `ld` for linking and `gdb` for debugging. Docker is used to containerize the workflow within an alpine-linux image. 

See the wiki with process, learnings and guidance [here](https://github.com/tonyOreglia/unique-word-counter/wiki)

## Dependencies
* [Docker](https://www.docker.com/get-started)
* [Make](https://www.tutorialspoint.com/unix_commands/make.htm) command line utility

## Run and Debug on Docker
#### Build Image 
```sh
make build-image
```

#### Compile and Link
```sh
make build
```

#### Build and Run the executable
```sh
make run
```

#### Build and Run with Arguments
```sh
make run-with-args args="arg1 arg2 arg3"
```

#### Build and Debug
```sh
make debug
```

#### Run the Container Attached via Terminal
```sh 
make run-container
```
