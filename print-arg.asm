section .data
  msg db "print me"

section .text
    global _start
_start:
  pop rcx
  add rcx, 48
  push rcx
  mov rsi, rsp  ; store value of rsp, i.e. pointer to message in rsi (2nd param of syscall print
  mov rax, 1      ;
  mov rdi, 1
  mov rdx, 8
  syscall
  mov rax, 60
  mov rdi, 0
  syscall