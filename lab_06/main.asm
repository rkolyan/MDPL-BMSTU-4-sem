MYDATA	SEGMENT PARA PUBLIC 'DATA'
FLAG	DB 0
X	DW ?
SYMBOLS DB "0123456789ABCDEF"
MES	DB "Input option(0..8):", 13, 10, '$'
MES0	DB "0)Show this menu", 13, 10
	DB "1)Input signed decimal number", 13, 10
	DB "2)Output number in binary without sign", 13, 10
	DB "3)Output number in binary with sign", 13, 10
	DB "4)Output number in decimal without sign", 13, 10
	DB "5)Output number in decimal with sign", 13, 10
	DB "6)Output number in heximal without sign", 13, 10
	DB "7)Output number in heximal with sign", 13, 10
	DB "8)Exit", 13, 10, '$'
MYDATA	ENDS

MYSTACK SEGMENT PARA STACK 'STACK'
	DW 100 DUP(0)
MYSTACK ENDS

MYCODE	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:MYCODE, DS:MYDATA, SS:MYSTACK


;////////////////////////////////////


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


;/////////////////////////////////////


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


;//////////////////////////////////


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


;//////////////////////////////////


print16u PROC NEAR
	mov DX, X
	mov CX, 4
	mov FLAG, 0

CYCLE_16u:
	mov BL, CL
	mov CL, 4
	rol DX, CL 		;Циклически сдвигает каждый раз на 4 чтобы проверять тетрэдру
	mov CL, BL
	mov AX, 15
	and AX, DX
	mov BX, offset SYMBOLS
	cmp AL, 0
	jne DOIT
	cmp FLAG, 0
	je NEXT_16u

DOIT:
	mov FLAG, 1
	xlat
	mov BX, DX
	mov DX, AX
	mov AH, 2
	int 21h
	mov DX, BX

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



MAIN:
	mov AX, MYDATA
	mov DS, AX

CYCLE:
	mov DX, OFFSET MES
	mov AH, 9H
	int 21H
	mov AH, 7
	int 21H
	cmp AL, '0'
	je OPTION0
	cmp AL, '1'
	je OPTION1
	cmp AL, '2'
	je OPTION2
	cmp AL, '3'
	je OPTION3
	cmp AL, '4'
	je OPTION4
	cmp AL, '5'
	je OPTION5
	cmp AL, '6'
	je OPTION6
	cmp AL, '7'
	je OPTION7
	cmp AL, '8'
	je FINAL
	jmp CYCLE

OPTION0:
	mov BX, print_menu
	jmp NEXT

OPTION1:
	mov BX, read
	jmp NEXT

OPTION2:
	mov BX, print2u
	jmp NEXT

OPTION3:
	mov BX, print2
	jmp NEXT

OPTION4:
	mov BX, print10u
	jmp NEXT

OPTION5:
	mov BX, print10
	jmp NEXT

OPTION6:
	mov BX, print16u
	jmp NEXT

OPTION7:
	mov BX, print16

NEXT:
	call BX
	jmp CYCLE

FINAL:
	mov AH, 4Ch
	int 21h
	
MYCODE	ENDS
END MAIN

Одна из самых бесячих лаб...
Способы печати:
1)2-ные числа - Сдвиг влево с проверкой флага CF. Если CF = 1, то печатаем '1', иначе '0'
2)10-ные числа - Деление с сохранением остатка в стеке
3)16-ные числа - Каждый раз циклически сдвигаем на 4 бита влево, затем логически умножаем на 1111, после этого остается тетраеда (4 битовое число),
размер которой соответствует положению какого-то символа. Использование команды xlat обязательно :(
