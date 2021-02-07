.686
.model flat
.data
	EXTRN	SYSTEM_$$_RANDOM$LONGINT$$LONGINT: NEAR
	EXTRN	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE: NEAR
	EXTRN	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE: NEAR
	EXTRN	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE: NEAR
	EXTRN	U_$TYPES_$$_MOM: NEAR
	EXTRN	U_$TYPES_$$_PAPA: NEAR
	EXTRN	U_$TYPES_$$_MY: NEAR
	EXTRN	U_$TYPES_$$_CHILD_CUR: NEAR
	EXTRN	U_$TYPES_$$_CHILD: NEAR
	EXTRN	U_$TYPES_$$_F_X: NEAR
	EXTRN	U_$TYPES_$$_ENT: NEAR
	EXTRN	U_$TYPES_$$_DIE: NEAR
	EXTRN	U_$TYPES_$$_VAL: NEAR
	EXTRN	fpc_dynarray_high: NEAR
	EXTRN	TYPES_$$_CHOOSE_PARENTS: NEAR
	EXTRN	TYPES_$$_FUN_X$WORD$$REAL: NEAR
	
	const_1		DQ	-1.0000000000000000e000
	const_2		DQ	-1.0000000000000000e003
	const_3		DQ	-1.0000000000000000e000
	const_4		DQ	-1.0000000000000000e003
	const_5		DT	 1.52590218966964217602e-0005
.code
PUBLIC SINGLE_POINT_CROSSING
SINGLE_POINT_CROSSING proc
	push	ebx
	push	esi
	push	edi
	mov	eax,16
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	mov	bx,ax
	cmp	bx,15
	ja	S_P_C_LABEL_1
	dec	bx
S_P_C_LABEL_2:
		inc	bx
		mov	dl,bl
		mov	ax,word ptr [U_$TYPES_$$_MOM]
		call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
		movzx	ax,al
		mov	di,ax
		mov	dl,bl
		mov	ax,word ptr [U_$TYPES_$$_PAPA]
		call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
		
		movzx	ax,al
		mov	si,ax
		cmp	di,si
		je	S_P_C_LABEL_3
		cmp	di,1
		jne	S_P_C_LABEL_5
		mov	dl,bl
		mov	eax,offset U_$TYPES_$$_MOM
		call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

		mov	dl,bl
		mov	eax,offset U_$TYPES_$$_PAPA
		call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
		jmp	S_P_C_LABEL_4
S_P_C_LABEL_5:
		mov	dl,bl
		mov	eax,offset U_$TYPES_$$_PAPA
		call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

		mov	dl,bl
		mov	eax,offset U_$TYPES_$$_MOM
		call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
		
S_P_C_LABEL_4:
S_P_C_LABEL_3:
		cmp	bx,15
		jb	S_P_C_LABEL_2
S_P_C_LABEL_1:

		pop	edi
		pop	esi
		pop	ebx
		ret
SINGLE_POINT_CROSSING endp

PUBLIC DOUBLE_POINT_CROSSING
DOUBLE_POINT_CROSSING proc
	push	ebx
	push	esi
	push	edi
	sub	esp,8
	mov	eax,16
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	mov	ebx,eax
	movzx	edx,bx
	mov	eax,16
	sub	eax,edx
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	movzx	edx,bx
	lea	eax,dword ptr [eax+edx]
	mov	word ptr [esp],ax
	mov	word ptr [esp+4],bx
	mov	ax,word ptr [esp+4]
	cmp	word ptr [esp],ax
	jb	D_P_C_LABEL_1
	dec	word ptr [esp+4]
D_P_C_LABEL_2:
	inc	word ptr [esp+4]
	mov	dl,byte ptr [esp+4]
	mov	ax,word ptr [U_$TYPES_$$_MOM]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	movzx	ax,al
	mov	bx,ax
	mov	dl,byte ptr [esp+4]
	mov	ax,word ptr [U_$TYPES_$$_PAPA]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	movzx	ax,al
	mov	si,ax
	cmp	bx,si
	je	D_P_C_LABEL_3
	cmp	bx,1
	jne	D_P_C_LABEL_4
	mov	dl,byte ptr [esp+4]
	mov	eax,offset U_$TYPES_$$_MOM
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

	mov	dl,byte ptr [esp+4]
	mov	eax,offset U_$TYPES_$$_PAPA
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
	jmp	D_P_C_LABEL_5
D_P_C_LABEL_4:
	mov	dl,byte ptr [esp+4]
	mov	eax,offset U_$TYPES_$$_PAPA
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

	mov	dl,byte ptr [esp+4]
	mov	eax,offset U_$TYPES_$$_MOM
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
D_P_C_LABEL_5:
D_P_C_LABEL_3:
		mov	ax,word ptr [esp+4]
		cmp	word ptr [esp],ax
		ja	D_P_C_LABEL_2
D_P_C_LABEL_1:
		add	esp,8
		
		pop	edi
		pop	esi
		pop	ebx
		ret
DOUBLE_POINT_CROSSING endp

PUBLIC UNIFORM_CROSSING
UNIFORM_CROSSING proc
	push	ebx
	push	esi

	movzx	eax,word ptr [U_$TYPES_$$_MY+12]
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	mov	si,ax
	mov	bl,0
	dec	bl
U_C_LABEL_1:
	inc	bl
	mov	dl,bl
	mov	ax,si
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	test	al,al
	jne	U_C_LABEL_2
	mov	dl,bl
	mov	ax,word ptr [U_$TYPES_$$_MOM]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	test	al,al
	jne	U_C_LABEL_3
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD_CUR
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE
	
	jmp	U_C_LABEL_4
U_C_LABEL_3:
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD_CUR
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
		
	jmp	U_C_LABEL_4
U_C_LABEL_2:
	mov	dl,bl
	mov	ax,word ptr [U_$TYPES_$$_PAPA]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	test	al,al
	jne	U_C_LABEL_5
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD_CUR
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE
	
	jmp	U_C_LABEL_6
U_C_LABEL_5:
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD_CUR
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
		
U_C_LABEL_6:
U_C_LABEL_4:
	cmp	bl,15
	jb	U_C_LABEL_1
	
	pop	esi
	pop	ebx
	ret
UNIFORM_CROSSING endp

PUBLIC UNIVERSAL_CROSSING
UNIVERSAL_CROSSING proc
	push	ebx
	push	esi
	push	edi
	sub	esp,4

	mov	byte ptr [esp],0
	dec	byte ptr [esp]
UNIVERSAL_C_LABEL_1:
	inc	byte ptr [esp]
	mov	dl,byte ptr [esp]
	mov	ax,word ptr [U_$TYPES_$$_MOM]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
		
	movzx	ax,al
	mov	si,ax
	mov	dl,byte ptr [esp]
	mov	ax,word ptr [U_$TYPES_$$_PAPA]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
		
	movzx	ax,al
	mov	di,ax
	mov	eax,2
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
		
	mov	bx,ax
	test	bx,bx
	jne	S_P_C_LABEL_3
	cmp	si,di
	je	S_P_C_LABEL_5
	cmp	si,1
	jne	UNIVERSAL_C_LABEL_2
	mov	dl,byte ptr [esp]
	mov	eax,offset U_$TYPES_$$_MOM
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE
	
	mov	dl,byte ptr [esp]
	mov	eax,offset U_$TYPES_$$_PAPA
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
	jmp	UNIVERSAL_C_LABEL_3
UNIVERSAL_C_LABEL_2:
	mov	dl,byte ptr [esp]
	mov	eax,offset U_$TYPES_$$_PAPA
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

	mov	dl,byte ptr [esp]
	mov	eax,offset U_$TYPES_$$_MOM
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
UNIVERSAL_C_LABEL_3:
S_P_C_LABEL_5:
S_P_C_LABEL_3:
	cmp	byte ptr [esp],15
	jb	UNIVERSAL_C_LABEL_1
	add	esp,4
	
	pop	edi
	pop	esi
	pop	ebx
	ret
UNIVERSAL_CROSSING endp

PUBLIC CHANGE_ONE_BIT
CHANGE_ONE_BIT proc
	push	ebx
	
	mov	eax,16
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	mov	bl,al
	mov	dl,bl
	mov	ax,word ptr [U_$TYPES_$$_CHILD]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	cmp	al,1
	jne	S_P_C_LABEL_1
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE
	
	jmp	C_O_B_LABEL_1
S_P_C_LABEL_1:
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
		
C_O_B_LABEL_1:

	pop	ebx
	ret
CHANGE_ONE_BIT endp

PUBLIC CHANGE_SOME_BITS
CHANGE_SOME_BITS proc
	push	ebx
	sub	esp,8

	mov	eax,16
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	mov	byte ptr [esp+4],al
	mov	eax,16
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	mov	byte ptr [esp],al
	mov	dl,byte ptr [esp+4]
	mov	ax,word ptr [U_$TYPES_$$_CHILD]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	mov	bl,al
	mov	dl,byte ptr [esp+4]
	mov	ax,word ptr [U_$TYPES_$$_CHILD]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	cmp	bl,al
	je	C_S_B_LABEL_1
	mov	dl,byte ptr [esp+4]
	mov	ax,word ptr [U_$TYPES_$$_CHILD]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	cmp	al,1
	jne	C_S_B_LABEL_2
	mov	dl,byte ptr [esp+4]
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

	mov	dl,byte ptr [esp]
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
	jmp	C_S_B_LABEL_3
C_S_B_LABEL_2:
	mov	dl,byte ptr [esp]
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

	mov	dl,byte ptr [esp+4]
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
C_S_B_LABEL_3:
C_S_B_LABEL_1:
	add	esp,8
		
	pop	ebx
	ret
CHANGE_SOME_BITS endp

PUBLIC REVERSE_BITS
REVERSE_BITS proc
	push	ebx

	mov	eax,16
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	mov	bl,al
	cmp	bl,8
	ja	S_P_C_LABEL_1
	dec	bl
S_P_C_LABEL_2:
	inc	bl
	mov	dl,bl
	mov	ax,word ptr [U_$TYPES_$$_CHILD]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	test	al,al
	jne	R_B_LABEL_1
	movzx	eax,bl
	mov	edx,15
	sub	edx,eax
	mov	ax,word ptr [U_$TYPES_$$_CHILD]
	call	BIT_FUNCTIONS_$$_GETBIT$WORD$BYTE$$BYTE
	
	cmp	al,1
	jne	R_B_LABEL_1
	movzx	eax,bl
	mov	edx,15
	sub	edx,eax
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE

	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
	jmp	D_P_C_LABEL_3
R_B_LABEL_1:
	movzx	eax,bl
	mov	edx,15
	sub	edx,eax
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_SETBIT$WORD$BYTE
	
D_P_C_LABEL_3:
	mov	dl,bl
	mov	eax,offset U_$TYPES_$$_CHILD
	call	BIT_FUNCTIONS_$$_UNSETBIT$WORD$BYTE
	
	cmp	bl,8
	jb	S_P_C_LABEL_2
S_P_C_LABEL_1:

	pop	ebx
	ret
REVERSE_BITS endp

PUBLIC SORT_POP
SORT_POP proc
	push	ebp
	mov	ebp,esp
	sub	esp,28
	push	ebx
	push	esi
	push	edi

	mov	eax,dword ptr [ebp+8]
	mov	dword ptr [ebp-28],eax
	mov	eax,dword ptr [ebp+12]
	mov	ax,word ptr [ebp+16]
	mov	word ptr [ebp-24],ax
	movzx	eax,word ptr [ebp-24]
	dec	eax
	mov	word ptr [ebp-20],ax
	mov	word ptr [ebp-12],0
	mov	ax,word ptr [ebp-20]
	cmp	ax,word ptr [ebp-12]
	jb	SORT_POP_LABEL_1
	dec	word ptr [ebp-12]
SORT_POP_LABEL_2:
	inc	word ptr [ebp-12]
	movzx	eax,word ptr [ebp-24]
	dec	eax
	mov	bx,ax
	movzx	eax,word ptr [ebp-12]
	inc	eax
	mov	dx,ax
	cmp	bx,dx
	jb	R_B_LABEL_1
	dec	dx
C_S_B_LABEL_1:
	inc	dx
	mov	esi,dword ptr [U_$TYPES_$$_F_X]
	movzx	ecx,word ptr [ebp-12]
	movzx	eax,dx
	fld	qword ptr [esi+eax*8]
	fld	qword ptr [esi+ecx*8]
	fcompp
	
	fnstsw	ax
	sahf
	jp	D_P_C_LABEL_1
	jnb	D_P_C_LABEL_1
	mov	eax,dword ptr [U_$TYPES_$$_F_X]
	movzx	ecx,word ptr [ebp-12]
	lea	edi,dword ptr [ebp-8] ; x
	lea	esi,dword ptr [eax+ecx*8] ; f_x + i
	mov	ecx,8 ; copy 8 bytes from f_x[i] to x
	rep	movsb
	mov	edi,dword ptr [U_$TYPES_$$_F_X]
	movzx	eax,word ptr [ebp-12]
	mov	ecx,dword ptr [U_$TYPES_$$_F_X]
	movzx	esi,dx
	lea	edi,dword ptr [edi+eax*8] ; f_x[i]
	lea	esi,dword ptr [ecx+esi*8] ; f_x[j]
	mov	ecx,8
	rep	movsb
	mov	ecx,dword ptr [U_$TYPES_$$_F_X]
	movzx	eax,dx
	lea	edi,dword ptr [ecx+eax*8]
	lea	esi,dword ptr [ebp-8]
	mov	ecx,8
	rep	movsb
	movzx	eax,word ptr [ebp-12]
	lea	edi,dword ptr [ebp-8]
	mov	ecx,dword ptr [ebp-28]
	lea	esi,dword ptr [ecx+eax*8]
	mov	ecx,8
	rep	movsb
	movzx	eax,word ptr [ebp-12]
	movzx	ecx,dx
	mov	esi,dword ptr [ebp-28]
	lea	edi,dword ptr [esi+eax*8]
	mov	eax,dword ptr [ebp-28]
	lea	esi,dword ptr [eax+ecx*8]
	mov	ecx,8
	rep	movsb
	movzx	eax,dx
	mov	ecx,dword ptr [ebp-28]
	lea	edi,dword ptr [ecx+eax*8]
	lea	esi,dword ptr [ebp-8]
	mov	ecx,8
	rep	movsb
	mov	esi,dword ptr [U_$TYPES_$$_ENT]
	movzx	eax,word ptr [ebp-12]
	mov	cx,word ptr [esi+eax*2]
	mov	word ptr [ebp-16],cx
	mov	esi,dword ptr [U_$TYPES_$$_ENT]
	movzx	ecx,word ptr [ebp-12]
	mov	edi,dword ptr [U_$TYPES_$$_ENT]
	movzx	eax,dx
	mov	ax,word ptr [edi+eax*2]
	mov	word ptr [esi+ecx*2],ax
	mov	ecx,dword ptr [U_$TYPES_$$_ENT]
	movzx	eax,dx
	mov	si,word ptr [ebp-16]
	mov	word ptr [ecx+eax*2],si
D_P_C_LABEL_1:
	cmp	bx,dx
	ja	C_S_B_LABEL_1
R_B_LABEL_1:
	mov	ax,word ptr [ebp-20]
	cmp	ax,word ptr [ebp-12]
	ja	SORT_POP_LABEL_2
SORT_POP_LABEL_1:

	pop	edi
	pop	esi
	pop	ebx
	leave
	ret	12
SORT_POP endp

PUBLIC RANDOM_SELECTION
RANDOM_SELECTION proc
	push	ebp
	mov	ebp,esp
	sub	esp,8
	push	ebx
	push	esi
	push	edi
	
	mov	word ptr [U_$TYPES_$$_DIE],0
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	movzx	edx,word ptr [U_$TYPES_$$_MY+2]
	sub	eax,edx
	mov	word ptr [ebp-8],ax
	mov	ax,word ptr [U_$TYPES_$$_MY+4]
	mov	word ptr [ebp-4],ax
	cmp	word ptr [ebp-8],ax
	jb	S_P_C_LABEL_1
	dec	word ptr [ebp-4]
S_P_C_LABEL_2:
	inc	word ptr [ebp-4]
	mov	eax,2
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	mov	bx,ax
	test	bx,bx
	jne	D_P_C_LABEL_2
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	movzx	edx,word ptr [ebp-4]
	lea	edi,dword ptr [eax+edx*8]
	mov	esi,offset const_1
	mov	ecx,8
	rep	movsb
	mov	eax,dword ptr [U_$TYPES_$$_F_X]
	movzx	edx,word ptr [ebp-4]
	lea	edi,dword ptr [eax+edx*8]
	mov	esi,offset const_2
	mov	ecx,8
	rep	movsb
	inc	word ptr [U_$TYPES_$$_DIE]
D_P_C_LABEL_2:
	mov	ax,word ptr [ebp-8]
	cmp	ax,word ptr [ebp-4]
	ja	S_P_C_LABEL_2
S_P_C_LABEL_1:
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	movzx	edx,word ptr [U_$TYPES_$$_DIE]
	sub	eax,edx
	push	eax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	call	fpc_dynarray_high
	
    push eax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	push	eax
	call	SORT_POP

	pop	edi
	pop	esi
	pop	ebx
	leave
	ret
RANDOM_SELECTION endp

PUBLIC SELECTION_TOURNAMENT
SELECTION_TOURNAMENT proc
	push	ebp
	mov	ebp,esp
	sub	esp,12
	push	ebx
	push	esi
	push	edi

	mov	word ptr [U_$TYPES_$$_DIE],0
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	dec	eax
	movzx	edx,word ptr [U_$TYPES_$$_MY+4]
	sub	eax,edx
	movzx	edx,word ptr [U_$TYPES_$$_MY+2]
	sub	eax,edx
	test	eax,eax
	jns	SORT_POP_LABEL_2
	inc	eax
SORT_POP_LABEL_2:
	sar	eax,1
	mov	word ptr [ebp-12],ax
	mov	word ptr [ebp-8],0
	mov	ax,word ptr [ebp-12]
	cmp	ax,word ptr [ebp-8]
	jl	R_B_LABEL_1
	dec	word ptr [ebp-8]
C_S_B_LABEL_1:
	inc	word ptr [ebp-8]
S_T_LABEL_1:
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	mov	bx,ax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	movsx	edx,bx
	fld	qword ptr [const_3]
	fld	qword ptr [eax+edx*8]
	fcompp
	fnstsw	ax
	sahf
	jp	D_P_C_LABEL_2
	je	S_T_LABEL_1
D_P_C_LABEL_2:
S_T_LABEL_2:
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT
	
	mov	word ptr [ebp-4],ax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	movsx	edx,word ptr [ebp-4]
	fld	qword ptr [const_3]
	fld	qword ptr [eax+edx*8]
	fcompp
	fnstsw	ax
	sahf
	jp	UNIVERSAL_C_LABEL_2
	je	S_T_LABEL_2
UNIVERSAL_C_LABEL_2:
	cmp	word ptr [ebp-4],bx
	je	S_T_LABEL_2
	mov	eax,dword ptr [U_$TYPES_$$_F_X]
	movsx	ecx,bx
	movsx	edx,word ptr [ebp-4]
	fld	qword ptr [eax+edx*8]
	fld	qword ptr [eax+ecx*8]
	fcompp
	fnstsw	ax
	sahf
	jp	D_P_C_LABEL_3
	jnae	D_P_C_LABEL_3
	mov	edx,dword ptr [U_$TYPES_$$_VAL]
	movsx	eax,word ptr [ebp-8]
	lea	edi,dword ptr [edx+eax*8]
	mov	esi,offset const_3
	mov	ecx,8
	rep	movsb
	mov	eax,dword ptr [U_$TYPES_$$_F_X]
	movsx	edx,bx
	lea	edi,dword ptr [eax+edx*8]
	mov	esi,offset const_4
	mov	ecx,8
	rep	movsb
	inc	word ptr [U_$TYPES_$$_DIE]
	jmp	S_T_LABEL_3
D_P_C_LABEL_3:
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	movsx	edx,word ptr [ebp-8]
	lea	edi,dword ptr [eax+edx*8]
	mov	esi,offset const_3
	mov	ecx,8
	rep	movsb
	mov	edx,dword ptr [U_$TYPES_$$_F_X]
	movsx	eax,word ptr [ebp-4]
	lea	edi,dword ptr [edx+eax*8]
	mov	esi,offset const_4
	mov	ecx,8
	rep	movsb
	inc	word ptr [U_$TYPES_$$_DIE]
S_T_LABEL_3:
	mov	ax,word ptr [ebp-12]
	cmp	ax,word ptr [ebp-8]
	jg	C_S_B_LABEL_1
R_B_LABEL_1:
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	movzx	edx,word ptr [U_$TYPES_$$_DIE]
	sub	eax,edx
	push	eax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	call	fpc_dynarray_high
	
	push	eax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	push	eax
	call	SORT_POP

	pop	edi
	pop	esi
	pop	ebx
	leave
	ret
SELECTION_TOURNAMENT endp

PUBLIC SELECTION
SELECTION proc
	push	ebp
	mov	ebp,esp

	mov	ax,word ptr [ebp+8]
	cmp	ax,1
	jne	SELECTION_LABEL_1
	call	RANDOM_SELECTION
	
	jmp	UNIVERSAL_C_LABEL_1
SELECTION_LABEL_1:
		call	SELECTION_TOURNAMENT
		
UNIVERSAL_C_LABEL_1:

		leave
		ret	4
SELECTION endp

PUBLIC MUTATION
MUTATION proc
	push	ebp
	mov	ebp,esp
	push	ebx

	mov	bx,word ptr [ebp+8]
	test	bx,bx
	jne	SELECTION_LABEL_1
	call	CHANGE_ONE_BIT
	
SELECTION_LABEL_1:
	cmp	bx,1
	jne	SORT_POP_LABEL_1
	call	CHANGE_ONE_BIT
	
SORT_POP_LABEL_1:
	cmp	bx,2
	jne	S_P_C_LABEL_1
	call	REVERSE_BITS
S_P_C_LABEL_1:
	mov	ax,word ptr [U_$TYPES_$$_CHILD]

	pop	ebx
	leave
	ret	4
MUTATION endp

PUBLIC MAKING_CHILD
MAKING_CHILD proc
	push	ebp
	mov	ebp,esp
	push	ebx

	mov	bx,word ptr [ebp+8]
	test	bx,bx
	jne	SELECTION_LABEL_1
	call	SINGLE_POINT_CROSSING
	
SELECTION_LABEL_1:
	cmp	bx,1
	jne	SORT_POP_LABEL_1
	call	DOUBLE_POINT_CROSSING
	
SORT_POP_LABEL_1:
	cmp	bx,2
	jne	S_P_C_LABEL_1
	call	UNIVERSAL_CROSSING
	
S_P_C_LABEL_1:
	cmp	bx,3
	jne	M_C_LABEL_1
	call	UNIFORM_CROSSING
	
M_C_LABEL_1:
	cmp	bx,3
	je	C_S_B_LABEL_1
	mov	eax,2
	call	SYSTEM_$$_RANDOM$LONGINT$$LONGINT

	test	ax,ax
	jne	M_C_LABEL_2
	mov	ax,word ptr [U_$TYPES_$$_MOM]
	jmp	M_C_LABEL_3
M_C_LABEL_2:
	mov	ax,word ptr [U_$TYPES_$$_PAPA]
	jmp	M_C_LABEL_3
C_S_B_LABEL_1:
	mov	ax,word ptr [U_$TYPES_$$_CHILD_CUR]
M_C_LABEL_3:

	pop	ebx
	leave
	ret	4
MAKING_CHILD endp

PUBLIC CROSSING
CROSSING proc
	push	ebp
	mov	ebp,esp
	sub	esp,20
	push	ebx
	push	esi
	push	edi

	mov	ax,word ptr [ebp+8]
	mov	word ptr [ebp-16],ax
	mov	ax,word ptr [ebp+12]
	mov	word ptr [ebp-20],ax
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	push	eax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	call	fpc_dynarray_high
	push	eax
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	push	eax
	call	SORT_POP

	movzx	eax,word ptr [U_$TYPES_$$_DIE]
	dec	eax
	mov	word ptr [ebp-12],ax
	mov	word ptr [ebp-8],0
	mov	ax,word ptr [ebp-12]
	cmp	ax,word ptr [ebp-8]
	jb	D_P_C_LABEL_1
	dec	word ptr [ebp-8]
D_P_C_LABEL_2:
	inc	word ptr [ebp-8]
	cmp	word ptr [ebp-16],1
	jne	C_O_B_LABEL_1
	mov	si,0
C_O_B_LABEL_1:
	cmp	word ptr [ebp-16],2
	jne	CROSSING_LABEL_1
	mov	si,1
CROSSING_LABEL_1:
	cmp	word ptr [ebp-16],3
	jne	S_P_C_LABEL_5
	mov	si,2
S_P_C_LABEL_5:
	cmp	word ptr [ebp-16],4
	jne	D_P_C_LABEL_3
	mov	si,3
D_P_C_LABEL_3:
	cmp	word ptr [ebp-20],1
	jne	CROSSING_LABEL_2
	mov	di,0
CROSSING_LABEL_2:
	cmp	word ptr [ebp-20],2
	jne	CROSSING_LABEL_3
	mov	di,1
CROSSING_LABEL_3:
	cmp	word ptr [ebp-20],3
	jne	CROSSING_LABEL_4
	mov	di,2
CROSSING_LABEL_4:
	call	TYPES_$$_CHOOSE_PARENTS

	push	esi
	call	MAKING_CHILD
	
	mov	word ptr [U_$TYPES_$$_CHILD],ax

	push	edi
	call	MUTATION
	
	mov	word ptr [U_$TYPES_$$_CHILD],ax
	movzx	eax,word ptr [U_$TYPES_$$_MY]
	movzx	ecx,word ptr [U_$TYPES_$$_DIE]
	mov	edx,eax
	sub	edx,ecx
	movzx	eax,word ptr [ebp-8]
	lea	eax,dword ptr [edx+eax]
	mov	bx,ax
	mov	eax,dword ptr [U_$TYPES_$$_ENT]
	movzx	edx,bx
	mov	cx,word ptr [U_$TYPES_$$_CHILD]
	mov	word ptr [eax+edx*2],cx
	mov	eax,dword ptr [U_$TYPES_$$_VAL]
	movzx	edx,bx
	movzx	ecx,word ptr [U_$TYPES_$$_CHILD]
	shl	ecx,2
	mov	dword ptr [ebp-4],ecx
	fild	dword ptr [ebp-4]
	fld	tbyte ptr [const_5]
	fmulp	st(1),st
	fstp	qword ptr [eax+edx*8]
	mov	ax,bx
	call	TYPES_$$_FUN_X$WORD$$REAL
	
	mov	edx,dword ptr [U_$TYPES_$$_F_X]
	movzx	eax,bx
	fstp	qword ptr [edx+eax*8]
	mov	ax,word ptr [ebp-12]
	cmp	ax,word ptr [ebp-8]
	ja	D_P_C_LABEL_2
D_P_C_LABEL_1:

	pop	edi
	pop	esi
	pop	ebx
	leave
	ret	8
CROSSING endp
End