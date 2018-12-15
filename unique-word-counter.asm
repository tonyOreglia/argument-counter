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
  ; get file name from command line parameter
  ; open and read file 