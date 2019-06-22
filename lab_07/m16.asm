PUBLIC print16, print16u
EXTRN X:word, SYMBOLS:byte, FLAG:byte

MYCODE	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:MYCODE

print16u PROC NEAR
	mov DX, X
	mov CX, 4
	mov FLAG, 0
	mov BX, OFFSET SYMBOLS

CYCLE_16u:
	mov CH, CL
	mov CL, 4
	rol DX, CL 		;Циклически сдвигает каждый раз на 4 чтобы проверять тетрэдру
	mov CL, CH
	mov CH, 0
	mov AX, 15
	and AX, DX

	cmp AL, 0
	jne DOIT
	cmp FLAG, 0
	je NEXT_16u

DOIT:
	mov FLAG, 1
	xlat
	push DX
	mov DX, AX
	mov AH, 2
	int 21h
	pop DX

NEXT_16u:
	loop CYCLE_16u

RETURN_PRINT16U:
	mov AH, 2H
	mov DX, 10
	int 21h
	ret
print16u ENDP



print16  PROC NEAR
	cmp X, 0
	js PRINT16_MINUS
	call print16u
	jmp RETURN_PRINT16

PRINT16_MINUS:
	mov DX, '-'
	mov AH, 2
	int 21h
	neg X
	call print16u
	neg X
	
RETURN_PRINT16:
	ret
print16	 ENDP
MYCODE ENDS
END
