MYDATA SEGMENT PARA 'DATA'
ARRAY	DW 20, 21, 22, 23, 24, 16, 13, 18, 23, 1
MES	DB "Result array:", 13, 10, '$'
SBX	DW 0
MYDATA ENDS

MYSTACK SEGMENT PARA STACK 'STACK'
	DB 100 dup(?)
MYSTACK ENDS

MYCODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:MYCODE, DS:MYDATA

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

print_array PROC NEAR
	mov DX, OFFSET ARRAY
	mov DI, 0
	mov CX, 0

CYCLE:
	cmp CX, 10
	je FINISH
	mov BX, [DI]
	push BX
	call print_one_element
	add DI, 2
	inc CX
	mov AH, 2h
	push DX
	mov DX, 20h
	int 21h
	pop DX
	jmp CYCLE

FINISH:
	ret
print_array ENDP

BEGIN:
	mov AX, MYDATA
	mov DS, AX
	mov AX, 0
	mov DX, OFFSET ARRAY

CYCLE1:
	mov SBX, 0
	mov CX, 11
	mov DI, 0

CYCLE2:
	mov BX, [DI+2]
	cmp [DI], BX
	jna NOT_CHANGE
	mov AX, [DI]
	mov BX, [DI+2]
	mov [DI], BX
	mov [DI+2], AX
	mov SBX, 1

NOT_CHANGE:
	add DI, 2
	loop CYCLE2

	cmp SBX, 1
	je CYCLE1

END_SORT:
	mov DX, OFFSET MES
	mov AH, 9
	int 21h
	call print_array
	mov AH, 4CH
	int 21h

MYCODE ENDS	
END BEGIN

Здесь написана простая сортировка пузырьком
Для того, чтобы сортировать массивы больших размеров, необходимо изменять значение CX
SBX - переменная, определяющая, поменялись ли элементы местами...
