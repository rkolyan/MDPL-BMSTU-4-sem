.386
.model FLAT,C
public factorial2
.CODE
factorial2 PROC         ;Рекурсивная версия факториала
	push EBP
	mov EBP, ESP
	mov ECX, [EBP+8]    ;Степень факториала
	mov EBX, [EBP+12]   ;Адрес, куда будет записан результат
	
	cmp ECX, 1
	je FIRST
	jz FIRST
	
	dec ECX

	push EBX
	push ECX
	call factorial2
	pop ECX
	pop EBX

	inc ECX
	mul ECX
	mov [EBX], EAX
	jmp RETURN

FIRST:
	mov EAX, 1          ;В EAX записывается значение, которое будет возвращать функция

RETURN:
	pop EBP
	ret
factorial2 ENDP
END
