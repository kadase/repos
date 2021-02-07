	.386p
DGROUP	GROUP	_BSS,_DATA
	ASSUME	CS:_CODE,ES:DGROUP,DS:DGROUP,SS:DGROUP

	EXTRN	U_$TYPES_$$_MY: NEAR
	EXTRN	U_$TYPES_$$_VAL: NEAR
	EXTRN	fpc_dynarray_high: NEAR
	EXTRN	SORT_POP: NEAR
	EXTRN	U_$TYPES_$$_DIE: NEAR
	EXTRN	TYPES_$$_CHOOSE_PARENTS: NEAR
	EXTRN	MAKING_CHILD: NEAR
	EXTRN	U_$TYPES_$$_CHILD: NEAR
	EXTRN	MUTATION: NEAR
	EXTRN	U_$TYPES_$$_ENT: NEAR
	EXTRN	TYPES_$$_FUN_X$WORD$$REAL: NEAR
	EXTRN	U_$TYPES_$$_F_X: NEAR
; Begin asmlist al_begin
; End asmlist al_begin
; Begin asmlist al_stabs
; End asmlist al_stabs
; Begin asmlist al_procedures

_CODE		SEGMENT	PARA PUBLIC USE32 'CODE'
	ALIGN 16
	PUBLIC	GEN_OPERATIONS_$$_CROSSING$SMALLINT$SMALLINT
GEN_OPERATIONS_$$_CROSSING$SMALLINT$SMALLINT:
; Temps allocated between ebp-20 and ebp+0
; [gen_operations.pas]
; [298] begin
		push	ebp
		mov	ebp,esp
		sub	esp,20
		push	ebx
		push	esi
		push	edi
; Var crossbreeding_method located in register ax
; Var mutation_method located in register ax
; Var i located in register ax
; Var n located in register bx
; Var crossbreeding_type located in register si
; Var mutation_type located in register di
		mov	ax,word ptr [ebp+8]
		mov	word ptr [ebp-16],ax
		mov	ax,word ptr [ebp+12]
		mov	word ptr [ebp-20],ax
; [299] sort_pop(val, my.population_volume);
		movzx	eax,word ptr [U_$TYPES_$$_MY]
		push	eax
		mov	eax,dword ptr [U_$TYPES_$$_VAL]
		call	fpc_dynarray_high
		push	eax
		mov	eax,dword ptr [U_$TYPES_$$_VAL]
		push	eax
		call	SORT_POP
; [300] for i:=0 to die -1 do
		movzx	eax,word ptr [U_$TYPES_$$_DIE]
		dec	eax
		mov	word ptr [ebp-12],ax
; Var i located in register ax
		mov	word ptr [ebp-8],0
		mov	ax,word ptr [ebp-12]
		cmp	ax,word ptr [ebp-8]
		jb	@@j16
		dec	word ptr [ebp-8]
@@j17:
		inc	word ptr [ebp-8]
; [303] if crossbreeding_method = 1 then
		cmp	word ptr [ebp-16],1
		jne	@@j19
; [304] crossbreeding_type := 0;
		mov	si,0
@@j19:
; [305] if crossbreeding_method = 2 then
		cmp	word ptr [ebp-16],2
		jne	@@j23
; [306] crossbreeding_type := 1;
		mov	si,1
@@j23:
; [307] if crossbreeding_method = 3 then
		cmp	word ptr [ebp-16],3
		jne	@@j27
; [308] crossbreeding_type := 2;
		mov	si,2
@@j27:
; [309] if crossbreeding_method = 4 then
		cmp	word ptr [ebp-16],4
		jne	@@j31
; [310] crossbreeding_type := 3;
		mov	si,3
@@j31:
; [313] if mutation_method = 1 then
		cmp	word ptr [ebp-20],1
		jne	@@j35
; [314] mutation_type := 0;
		mov	di,0
@@j35:
; [315] if mutation_method = 2 then
		cmp	word ptr [ebp-20],2
		jne	@@j39
; [316] mutation_type := 1;
		mov	di,1
@@j39:
; [317] if mutation_method = 3 then
		cmp	word ptr [ebp-20],3
		jne	@@j43
; [318] mutation_type := 2;
		mov	di,2
@@j43:
; [319] choose_parents;
		call	TYPES_$$_CHOOSE_PARENTS
; [320] child:= making_child(crossbreeding_type);
		push	esi
		call	MAKING_CHILD
		mov	word ptr [U_$TYPES_$$_CHILD],ax
; [321] child:= mutation(mutation_type);
		push	edi
		call	MUTATION
		mov	word ptr [U_$TYPES_$$_CHILD],ax
; [322] n:= my.population_volume - die + i;
		movzx	eax,word ptr [U_$TYPES_$$_MY]
		movzx	ecx,word ptr [U_$TYPES_$$_DIE]
		mov	edx,eax
		sub	edx,ecx
		movzx	eax,word ptr [ebp-8]
		lea	eax,dword ptr [edx+eax]
		mov	bx,ax
; [323] ent[n]:= child;
		mov	eax,dword ptr [U_$TYPES_$$_ENT]
		movzx	edx,bx
		mov	cx,word ptr [U_$TYPES_$$_CHILD]
		mov	word ptr [eax+edx*2],cx
; [324] val[n]:= child*4/65535;
		mov	eax,dword ptr [U_$TYPES_$$_VAL]
		movzx	edx,bx
		movzx	ecx,word ptr [U_$TYPES_$$_CHILD]
		shl	ecx,2
		mov	dword ptr [ebp-4],ecx
		fild	dword ptr [ebp-4]
		fld	tbyte ptr [_$GEN_OPERATIONS$_Ld1]
		fmulp	st(1),st
		fstp	qword ptr [eax+edx*8]
; [325] f_x[n]:=fun_x(n)
		mov	ax,bx
		call	TYPES_$$_FUN_X$WORD$$REAL
		mov	edx,dword ptr [U_$TYPES_$$_F_X]
		movzx	eax,bx
		fstp	qword ptr [edx+eax*8]
		mov	ax,word ptr [ebp-12]
		cmp	ax,word ptr [ebp-8]
		ja	@@j17
@@j16:
; [328] end;
		pop	edi
		pop	esi
		pop	ebx
		leave
		ret	8
; End asmlist al_procedures
; Begin asmlist al_globals
; End asmlist al_globals
; Begin asmlist al_const
; End asmlist al_const
; Begin asmlist al_typedconsts
_CODE		ENDS

_DATA		SEGMENT	PARA PUBLIC USE32 'DATA'
	ALIGN 16
_$GEN_OPERATIONS$_Ld1		DT	 1.52590218966964217602e-0005
; End asmlist al_typedconsts
; Begin asmlist al_rotypedconsts
; End asmlist al_rotypedconsts
; Begin asmlist al_threadvars
; End asmlist al_threadvars
; Begin asmlist al_imports
; End asmlist al_imports
; Begin asmlist al_exports
; End asmlist al_exports
; Begin asmlist al_resources
; End asmlist al_resources
; Begin asmlist al_rtti
; End asmlist al_rtti
; Begin asmlist al_dwarf_frame
; End asmlist al_dwarf_frame
; Begin asmlist al_dwarf_info
; End asmlist al_dwarf_info
; Begin asmlist al_dwarf_abbrev
; End asmlist al_dwarf_abbrev
; Begin asmlist al_dwarf_line
; End asmlist al_dwarf_line
; Begin asmlist al_picdata
; End asmlist al_picdata
; Begin asmlist al_indirectpicdata
; End asmlist al_indirectpicdata
; Begin asmlist al_resourcestrings
; End asmlist al_resourcestrings
; Begin asmlist al_objc_data
; End asmlist al_objc_data
; Begin asmlist al_objc_pools
; End asmlist al_objc_pools
; Begin asmlist al_end
; End asmlist al_end
_DATA		ENDS
	END

