SSTACK SEGMENT PARA STACK 'STACK'       ; Вместо PUBLIC пишется STACK, чтобы не вводить постоянно ASSUME SS:SSTACK (То есть указывается, что это главный стек) 
        DB 64 DUP('СТЕК____')           ; У дедов очень странное чувство юмора...
SSTACK ENDS                             ; Стек 8 раз запоняется словом 'CTEK____' (размер стека - 64)

DSEG SEGMENT PARA PUBLIC 'DATA'         ; Как вы поняли, это переменные типа байт и строки
CA      DB 'A'                          ; Переменная
KA      DB '65'                         ; Переменная
TXT     DB 'символ "'                   ; Начало строки TXT
C$      DB ?                            ; Переменная C$ (как часть строки TXT)
        DB '" имеет код '               ; Продолжение строки TXT
KCH1    DB ?                            ; Ещё одна перееменная внутри TXT (записывает разряд десяток)
KCH2    DB ?                            ; ------"------- (записывает разряд единиц)
        DB 10,13,'$'                    ; Конец строки TXT
MSG0    DB 'НАЧАЛО РАБОТЫ',13,10,'$'    ; Дальше сами догадаетесь...
MSG1    DB 'КОНЕЦ РАБОТЫ',13,10,'$'     
DSEG ENDS

SUBTTL ОСНОВНАЯ ПРОГРАММА
PAGE
CSEG SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CSEG,DS:DSEG,SS:SSTACK
BEGIN PROC FAR
    PUSH DS                             ; поместить в стек номер параграфа адреса возврата
    MOV AX,0
    PUSH AX

M1: 
    MOV AX,DSEG
    MOV DS,AX

M2: 
    MOV AH,9
    MOV DX,OFFSET MSG0
    INT 21H
                                        ; вывод стоки "СИМВОЛ 'A' имеет код 65"

MA:
    MOV AL,CA
    MOV C$,AL
    MOV AX,WORD PTR KA
    MOV WORD PTR KCH1,AX
    MOV AH,9
    MOV DX,OFFSET TXT
    INT 21H

MB: 
    INC C$
    INC KCH1+1
    INT 21H

MC: 
    INC C$
    INC KCH1+1
    INT 21H

M3: 
    MOV AH,9
    MOV DX,OFFSET MSG1
    INT 21H
    RET

BEGIN ENDP
CSEG ENDS
END BEGIN

PUSH кладет в стек значение уменьшая значение SP (указатель на начало стека)
INC - инкремент
