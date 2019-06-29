.386
.model FLAT,C
public CopyStr

.CODE
CopyStr:                ; Копирует(пересылает) из одной строки в другую подстрочку некой заданной длины
	push EBP            ; Сохраняем регистры согласно конвенции cdecl
	push EDI
	push ESI
	push EBX

	mov EBP, ESP
	mov EBX, [EBP+20]   ; Первый параметр - адрес строки, из которой идет копирование (строка для чтения)
	mov EDX, [EBP+24]   ; Второй параметр - адрес строки, в которую производится запись (строка для записи)
	mov ECX, [EBP+28]   ; Кол-во символов
	mov ESI, EBX        ; ESI = адрес первой строки
	mov EDI, EDX        ; EDI = адрес второй строки
	rep movsb           ; Пока ECX != 0 выполняй [EDI] = [ESI], ESI++, EDI++, ECX-- (Команда пересылки строк)

RETURN:
    pop EBX             ; Восстанавливаем регистры согласно конвенции cdecl
	pop ESI
	pop EDI
	pop EBP
	ret

END
