PUBLIC X, MES0, FLAG, SYMBOLS
EXTRN print10:NEAR, print10u:NEAR, print16:NEAR, print16u:NEAR, print2:NEAR, print2u:NEAR, read:NEAR, print_menu:NEAR

MYDATA	SEGMENT PARA PUBLIC 'DATA'
X	DW ?
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
FLAG	DB 0
SYMBOLS DB "0123456789ABCDEF"
MYDATA	ENDS

MYSTACK SEGMENT PARA STACK 'STACK'
	DW 100 DUP(0)
MYSTACK ENDS

MYCODE	SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:MYCODE, DS:MYDATA, SS:MYSTACK

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
