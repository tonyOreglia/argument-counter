section .data
  SYS_OPEN:         db  2
  SYS_READ:         db  0
  O_RDONLY:         dw  0x00
  bufsize:          dw  1024
  unableToOpenFile: db  "error: unable to open file", 10
  file:		          db  "./simple-words.txt", 0x00

section .bss
  buf:     resb    1024

section .text
    global _start
_start:
  call .openFileForReading  ; file handler returned in $rax
  mov rdi, file              ; move file handler to rdi
  call .readFile            ; read file pointed to by file handler 
  mov rsi, buf
  mov rdx, 20               ; param3 of sys_write fxn is the number of bits to print
  call .print
  call .printNewline
  call .exit

.printNumberOfArgs:
  add rdi, 48     ; convert number of args to ascii (only works if < 10)
  push rdi        ; push the ascii converted argc to stack
  mov rsi, rsp    ; store value of rsp, i.e. pointer to ascii argc to param2 of sys_write fxn
  mov rdx, 8      ; param3 of sys_write fxn is the number of bits to print
  call .print     ; prints top of the stack
  pop rdi         ; clean the stack
  ret


; expect NULL terminated filename in $rdi
; handler returned in rax
.openFileForReading:
  pop rcx
  pop r11
  pop r11
  pop rdi
  push rcx
  mov rax, SYS_OPEN
  mov rsi, O_RDONLY
  syscall
  mov r11, 0                ; for use in comparison next line
  cmp r11, rax              ; if rax is less than zero, this means file was not opened successfully
  jg .unableToOpenFileForReadingError
  ret

; expect file handler in $rdi
.readFile:
  mov rax, SYS_READ
  mov rsi, buf
  mov rdx, 20
  syscall
  ret


.getNumberOfArgs:
  pop r10         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  pop rax         ; get argc from stack
  push r10        ; return address of calling fxn to stack
  ret


.printNewline:
  pop r11         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  push 10         ; ascii newline character
  mov rsi, rsp    ; rsp points to top of stack. Newline has been pushed to top of stack. rsi is where 2nd param of sys_write is stored
  push r11        ; return the address of the calling fxn to top of stack.
  mov rdx, 2
  call .print
  ; clean up the newline character pushed onto the stack. Retaining the return address currently on top of stack
  pop r11
  pop rcx
  push r11
  ret
  
  ; print expects the calling location to be at the top of the stack
  ; print the value pointed to in $rsi
.print:
  mov rax, 1
  mov rdi, 1
  syscall
  ret             ; return to location pointed to at top of stack

.exit:
  mov rax, 60
  mov rdi, 0
  syscall

.unableToOpenFileForReadingError:
  mov rdx, 27               ; length of error message to print 
  mov rsi, unableToOpenFile
  call .print
  pop rdi
  call .printNumberOfArgs
  call .printNewline
  call .exit