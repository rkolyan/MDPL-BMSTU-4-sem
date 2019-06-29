.386
.model FLAT,C
public factorial1
.CODE
factorial1 PROC         ;Нерекурсивный вариант факториала
	push EBP
	mov EBP, ESP
	mov ECX, [EBP+8]    ;Степень факториала
	mov EBX, [EBP+12]   ;Адрес, куда будет записан результат
	mov EAX, 1          ;EAX тоже должна будет возвращать результат
	cmp ECX, 0
	jnz CYCLE
	mov ECX, 1

CYCLE:
	mul ECX
	loop CYCLE          ;Какой-то придурок говорил, что это вызывает рекурсию, но я хз...

	mov [EBX], EAX
	pop EBP
	ret
factorial1 ENDP
END
