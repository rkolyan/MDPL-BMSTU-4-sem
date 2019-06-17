SSTACK SEGMENT PARA STACK 'STACK'
        DB 64 DUP('СТЕК____')
SSTACK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
X       DB 0,1,2,3,4,5,6,7
B       DB 1B
K       DB ?
DSEG ENDS

SUBTTL ОСНОВНАЯ ПРОГРАММА
PAGE

 CSEG SEGMENT PARA PUBLIC 'CODE'

ASSUME CS:CSEG,DS:DSEG,SS:SSTACK

START PROC FAR
    mov AX, DSEG
    mov DS, AX

M1: 
    mov K, 2
    mov SI, 0
    mov CX, 8
    mov AL, B

M2: 
    test X[SI], AL
    jnz M3
    dec K
    jz M4

M3: 
    inc SI
    loop M2

M4: 
    add SI, '0'
    mov AH, 2
    mov DX, SI

M5: 
    int 21H

M6: 
    mov AH, 4CH
    mov AL, 0
    int 21h

START ENDP
CSEG ENDS
END START

Вообще что-либо лень описывать
Все команды, начинающиеся на букву J - условые переходы (jmp - безусловный)
loop = jmp + (CX--) - используется в качетсве цикла
X[SI] - значение по адресу SI относительно адреса, в котором лежит значение (начало) X
