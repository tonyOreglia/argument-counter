section .data

section .text
    global _start
_start:
  call .getNumberOfArgs   ; expects return value in $rax
  mov rdi, rax
  call .printNumberOfArgs ; expects value to be in 1st argument, i.e. $rdi
  call .printNewline
  call .printArg
  call .printNewline
  call .exit

.getNumberOfArgs:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  pop rax         ; get argc from stack
  push rbx        ; return address of calling fxn to stack
  ret

; expects value to be in 1st argument, i.e. $rdi
.printNumberOfArgs:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  add rdi, 48     ; convert number of args to ascii (only works if < 10)
  push rdi        ; push the ascii converted argc to stack
  mov rsi, rsp    ; store value of rsp, i.e. pointer to ascii argc to param2 of sys_write fxn
  mov rdx, 8      ; param3 of sys_write fxn is the number of bits to print
  push rbx        ; return the address of the calling fxn to top of stack.
  call .print
  ; clean up the number that was pushed onto the stack. Retaining the return address currently on top of stack
  pop rbx
  pop rcx
  push rbx
  ret

.printArg:
  pop rcx         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc       
  mov rsi, [rsp]  ; contents of memory address of stack pointer
  mov rdx, 7      ; how long is the message?
  push rcx        ; push return address back onto stack where it is expected
  jmp .print

.printNewline:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  push 10         ; ascii newline character
  mov rsi, rsp    ; rsp points to top of stack. Newline has been pushed to top of stack. rsi is where 2nd param of sys_write is stored
  push rbx        ; return the address of the calling fxn to top of stack.
  call .print
  ; clean up the newline character pushed onto the stack. Retaining the return address currently on top of stack
  pop rbx
  pop rcx
  push rbx
  ret
  
.print:           ; print expects the calling location to be at the top of the stack
  mov rax, 1
  mov rdi, 1
  syscall
  ret             ; return to location pointed to at top of stack

.exit:
  mov rax, 60
  mov rdi, 0
  syscall
