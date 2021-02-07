include console.inc

COMMENT *
   ¬вод целого числа и вывод суммы его цифр
*

.data ;m
	A db 0
	C db 9
	B dw ?
   X   dd  ?
   Sum db ?  ; —умма цифр

MaxLongint equ 80000000h

.code
Start:

COMMENT *
   mov A, 15  ;i
   outint A
   newline 
   
   ;Ax, Bx, Cx, Dx, Si, Di, Bp, Sp  - r
   mov ah, 4
   outint ah
   outstr  " "
   mov al, 1
   outint al
   outstr  " "
   outint ax
   newline
   
   ;mov m8: i8, r8
   ;mov m16: i16, r16
   ;mov r8: m8, i8, r8
   ;mov m8: m8 - NOOOOOOO
   ;mov A, C - NOOOOOOO

	inint ah
	inint al
	
	mov Sum, 0
	add Sum, ah
	add Sum, al
	
	
	outint Sum
	
	sub Sum, al
	outint Sum

	mov eax, 0

	mov al, 2
	mov ch, 5
	mul ch
	outint ax
	newline
	outint al
	newline
	
	mov ax, 700
	mov si, 100
	mul si
	outint dx
	newline
	outint ax
	newline
*	
	
	
	
	exit
end Start







