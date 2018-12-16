section .data

section .text
    global _start
_start:
  call .printNumberOfArgs
  call .printNewline
  call .exit

.printNumberOfArgs:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  pop rcx         ; get argc from stack
  add rcx, 48     ; convert number of args to ascii (only works if < 10)
  push rcx        ; push the ascii converted argc to stack
  mov rsi, rsp    ; store value of rsp, i.e. pointer to ascii argc to param2 of sys_write fxn
  mov rdx, 8      ; param3 of sys_write fxn is the number of bits to print
  push rbx        ; return the address of the calling fxn to top of stack.
  jmp .print 

.printNewline:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  push 10         ; ascii newline character
  mov rsi, rsp    ; rsp points to top of stack. Newline has been pushed to top of stack. rsi is where 2nd param of sys_write is stored
  push rbx        ; return the address of the calling fxn to top of stack.
  call .print
  
.print:           ; print expects the calling location to be at the top of the stack
  mov rax, 1
  mov rdi, 1
  syscall
  ret             ; return to location pointed to at top of stack

.exit:
  mov rax, 60
  mov rdi, 0
  syscall