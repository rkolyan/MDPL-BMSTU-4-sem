EXTRN X:WORD
PUBLIC print10, print10u

MYCODE	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:MYCODE

print10u PROC NEAR
	mov BX, 10
	mov CX, 0
	mov DX, 0
	mov AX, X

CYCLE_PRINT10U1:
	div BX
	push DX
	inc CX
	mov DX, 0
	cmp AX, 0
	jne CYCLE_PRINT10U1

CYCLE_PRINT10U2:
	cmp CX, 0
	je RETURN_PRINT10U
	pop DX
	add DX, '0'
	push AX
	mov AH, 2
	int 21h
	pop AX
	loop CYCLE_PRINT10U2

RETURN_PRINT10U:
	mov AH, 2H
	mov DX, 10
	int 21h
	ret
print10u ENDP


;//////////////////////////////////


print10	 PROC NEAR
	cmp X, 0
	js PRINT_MINUS
	call print10u
	jmp RETURN_PRINT10

PRINT_MINUS:
	mov AH, 2
	mov DX, '-'
	int 21h
	neg X
	call print10u
	neg X

RETURN_PRINT10:
	ret
print10	 ENDP

MYCODE ENDS
END
