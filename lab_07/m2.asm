EXTRN X:WORD
PUBLIC print2, print2u

MYCODE	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:MYCODE

print2u PROC NEAR
	mov CX, 16
	mov BX, 0
	mov AX, X

CYCLE_PRINT2U:
	shl AX, 1
	jnc Proverka
	push AX
	mov BX, 1
	mov AH, 2
	mov DX, '1'
	int 21h
	pop AX
	jmp NEXT2u

Proverka:
	cmp BX, 0
	jz NEXT2u
	push AX
	mov AH, 2
	mov DX, '0'
	int 21h
	pop AX

NEXT2u:
	loop CYCLE_PRINT2U

	mov AH, 2
	mov DX, 10
	int 21h
	ret
print2u ENDP


;//////////////////////////////////


print2	PROC NEAR
	cmp X, 0
	js PRINT_MINUS_2
	call print2u
	jmp RETURN_PRINT2

PRINT_MINUS_2:
	mov DX, '-'
	mov AH, 2
	int 21h
	neg X
	call print2u
	neg X
	
RETURN_PRINT2:
	ret
print2	ENDP 
MYCODE ENDS
END
