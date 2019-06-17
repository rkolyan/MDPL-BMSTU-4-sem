EXTRN MES0:BYTE, X:WORD
PUBLIC read, print_menu

MYCODE	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:MYCODE

print_menu PROC NEAR
	mov DX, OFFSET MES0
	mov AH, 9H
	int 21h
	ret
print_menu ENDP


;/////////////////////////////////////


read PROC NEAR
	mov X, 0

CYCLE_READ:
	mov AH, 1H
	int 21h
	cmp AL, 13
	je RETURN_READ
	cmp AL, '-'
	je NEGATIVE
	mov BL, AL
	sub BL, '0'
	mov AX, X
	mov DL, 10
	mul DL
	mov X, AX
	mov BH, 0
	add X, BX
	jmp CYCLE_READ

NEGATIVE:
	mov DH, 1
	jmp CYCLE_READ

RETURN_READ:
	cmp DH, 0
	je FINISH_READ
	neg X

FINISH_READ:
	mov AH, 2H
	mov DX, 10
	int 21h
	ret

read ENDP
MYCODE ENDS
END
