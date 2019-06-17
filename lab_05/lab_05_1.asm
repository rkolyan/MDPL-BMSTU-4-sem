MYDATA SEGMENT PARA 'DATA'
MATRIX	DW 0, 1, 2, 3, 4
        DW 5, 6, 7, 8, 9
        DW 10, 11, 12, 13, 14
        DW 15, 16, 17, 18, 19
        DW 20, 21, 22, 23, 24
MES1	DB "Before transposition:", 13, '$'
MES2	DB "After transposition:", 13, '$'
I1	DW 0
I2	DW 0
MYDATA ENDS

MYSTACK SEGMENT PARA STACK 'STACK'
	DB 100 dup(0)
MYSTACK ENDS

MYCODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:MYCODE, DS:MYDATA, SS:MYSTACK

print_one_element PROC NEAR
	mov BP, SP
	push AX
	push BX
	push CX
	push DX
	mov AX, [BP+2]
	mov BH, 10
	mov CX, 0

CYCLE_WRITE:
	div BH	
	mov DX, AX
	mov DL, DH
	mov DH, 0
	push DX
	inc CX
	mov AH, 0
	cmp AX, 0
	je CYCLE_READ
	jmp CYCLE_WRITE

CYCLE_READ:
	cmp CX, 0
	je FINISH2
	pop DX
	add DX, '0'
	mov AH, 2
	int 21h
	loop CYCLE_READ
	
FINISH2:
	pop DX
	pop CX
	pop BX
	pop AX
	ret 2
print_one_element ENDP

print_matrice PROC NEAR
	push BP
	mov BP, SP
	push AX
	push BX
	push CX
	push DX
	mov DI, 0
	mov CH, 5
	mov CL, 5

CYCLE1:
	cmp CL, 0
	je FINISH1
	mov CH, 5

CYCLE2:
	mov BX, [DI]
	push BX
	call print_one_element
	mov DX, 20H
	mov AH, 2H
	int 21h
	dec CH
	add DI, 2
	cmp CH, 0
	jne CYCLE2

	dec CL
	mov AH, 2H
	mov DX, 10
	int 21h
	jmp CYCLE1
	
FINISH1:
	pop DX
	pop CX
	pop BX
	pop AX
	pop BP
	ret
print_matrice ENDP

;/////////////////////////////////////////////////////////////////////////
;Осторожно! Дальше идут шутки про секс!
BEGIN:
	mov AX, MYDATA
	mov DS, AX
	mov I1, 5                  ;Счетчик строк
	mov AX, 0

MAIN_CYCLE:
	cmp I1, 0
	je END_TRANSPORT
	mov BX, AX
	mov CX, BX
	mov DX, I1
	mov I2, DX                 ;Кол-во проверяемых элементов в строке (каждый раз на единицу меньше)

SUB_CYCLE:
	cmp I2, 0
	je END_CYCLE
	push [BX]                  ;BX указывает на адрес относительно регистра DS
	mov DI, CX
	mov DX, [DI]
	mov [BX], DX
	pop DX
	mov [DI], DX

	add CX, 10
	add BX, 2
	dec I2
	jmp SUB_CYCLE

END_CYCLE:
	dec I1
	add AX, 12
	jmp MAIN_CYCLE

END_TRANSPORT:
	call print_matrice
	mov AH, 4CH
	int 21h
;////////////////////////////////////////////////////////////////////////
MYCODE ENDS	
END BEGIN

Эх, если б вы только знали как я еб-ся с выводом чисел...
