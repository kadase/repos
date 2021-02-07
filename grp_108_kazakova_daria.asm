include console.inc

.data

.code
ZeroNeg macro X: req, N := <0>
local f
    f = 0
    for i, <eax, ebx, ecx, edx, ebp, esi, edi, esp>
        ifidn <X>, <i>
            f = 1
        endif
    endm
    if N eq 0
        if f eq 1
            sub X, X
        else
            mov X, 0
        endif
    else
        neg X
    endif
endm


Start:

        pause
        exit
end Start
