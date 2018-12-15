section .data
		SYS_WRITE equ 1
		STD_IN    equ 1
		SYS_EXIT  equ 60
		EXIT_CODE equ 0
    
section .text
    global _start
_start:
		pop rcx
		cmp rcx, 3
    mov rax, 60
    ;exit code
    mov rdi, 0
    syscall