include console.inc


.data
  X dd ?
  Y dd ?

.code
Process_num proc
push ebp
mov ebp, esp
push eax ;тут будет offset x
push ebx ;тут будет y
push edx


mov eax, [ebp+8]
mov ebx, [ebp + 12]
mov eax, [eax]
cdq
idiv ebx
add edx, 1
mov eax, edx


pop edx
pop ebx
pop edx
pop ebp
ret 4*2
Process_num endp

Start:
   ...
   exit
   end Start
   
