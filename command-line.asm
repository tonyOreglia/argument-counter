section .data
		SYS_WRITE equ 1
		STD_IN    equ 1
		SYS_EXIT  equ 60
		EXIT_CODE equ 0

		NEW_LINE   db 0xa
		WRONG_ARGC db "Must be two command line argument", 0xa
section .text
        global _start

_start:
		pop rcx
		cmp rcx, 3
		jne argcError

		add rsp, 8
		pop rsi
		call str_to_int

		mov r10, rax
		pop rsi
		call str_to_int
		mov r11, rax

		add r10, r11

argcError:
    ;; sys_write syscall
    mov     rax, 1
    ;; file descritor, standard output
	  mov     rdi, 1
    ;; message address
    mov     rsi, WRONG_ARGC
    ;; length of message
    mov     rdx, 34
    ;; call write syscall
    syscall
    ;; exit from program
	jmp exit

str_to_int:
  xor rax, rax
  mov rcx,  10

next:
  cmp [rsi], byte 0
  je return_str
  mov bl, [rsi]
  sub bl, 48
  mul rcx
  add rax, rbx
  inc rsi
  jmp next


return_str:
	    ret

print:
	;;;; calculate number length
	mov rax, 1
	mul r12
	mov r12, 8
	mul r12
	mov rdx, rax

	;;;; print sum
	mov rax, SYS_WRITE
	mov rdi, STD_IN
	mov rsi, rsp
	;; call sys_write
	syscall

  jmp exit

exit:
	mov rax, SYS_EXIT
	;exit code
	mov rdi, EXIT_CODE
	syscall