section .data

section .text
    global _start
_start:
  call .getNumberOfArgs   ; expects return value in $rax
  mov rdi, rax
  mov rbx, rdi            ; rbx is preserved reg
  call .printNumberOfArgs ; expects value to be in 1st argument, i.e. $rdi
  call .printAllArgs      ; expect rdi to have number of args
  call .exit

.getNumberOfArgs:
  pop r10         ; this is the address of the calling fxn. Remove it from the stack for a moment so I can get to the argc
  pop rax         ; get argc from stack
  push r10        ; return address of calling fxn to stack
  ret

; expects value to be in 1st argument, i.e. $rdi
.printNumberOfArgs:
  add rdi, 48     ; convert number of args to ascii (only works if < 10)
  push rdi        ; push the ascii converted argc to stack
  mov rsi, rsp    ; store value of rsp, i.e. pointer to ascii argc to param2 of sys_write fxn
  mov rdx, 8      ; param3 of sys_write fxn is the number of bits to print
  call .print     ; prints top of the stack
  pop rdi         ; clean the stack
  ret

; expects * char array in $rdi
.strlen:
  mov rax, 1             ; initialize strlen counter
.loop:
  add rdi, 1              ; increment char * to next character
  add rax, 1              ; increment strlen counter
  cmp byte [rdi], 0x00    ; if value at [rdi] is 0x00 return
  jne .loop               ; loop if not at end of string
  ret


.printAllArgs:
  call .printNewline   ; fxn prints newline
  pop r11              ; pop address of the calling fxn. Remove temporarily
  mov rsi, [rsp]       ; stack pointer memory address. Holding argument to print.
  mov rdi, rsi
  call .strlen         ; expect strlen to be in $rax after funtion returns
  mov rdx, rax         ; how long is the message. TO DO: calculate argument length
  push r11             ; push return address back onto the stack
  call .print
  pop r11              ; pop return address
  pop rcx              ; this is the already printed arg
  push r11             ; push return address back onto the stack
  sub rbx, 1           ; rbx is the argument count. Iterate down 1
  cmp rbx, 0           ; are there zero args left to print? 
  jne .printAllArgs    ; if more args to print, loop again
  call .printNewline   ; otherwise print Newline and return
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
  
.print:           ; print expects the calling location to be at the top of the stack
  mov rax, 1
  mov rdi, 1
  syscall
  ret             ; return to location pointed to at top of stack

.exit:
  mov rax, 60
  mov rdi, 0
  syscall
