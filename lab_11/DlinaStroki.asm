.386
.model FLAT,C
public DlinaStroki

.CODE
DlinaStroki:            ; Считает длину строки (как в си)
	push EBP            ; Сохраняем регистры в стеке согласно конвенции cdecl
	push EDI
	push EBX

	mov EBP, ESP
	mov EDI, [EBP+16]   ; EDI хранит в себе адрес начала строки
	mov EBX, EDI        ; EBX ---"---
	xor EAX, EAX        ; В EAX записан символ '0'
	repne scasb         ; Пока не ноль увеличиваем EDI
	sub EDI, EBX        ; Вычитаем из конечного адреса начальный (Полученная длина = длина строки + 1)
	dec EDI             ; Из полученной длины находим истинную длину строки
	mov EAX, EDI        ; В EAX должен храниться результат работы функции (конвенция cdecl) 

	pop EBX             ; Восстанавливаем регистры согласно конвенции cdecl
	pop EDI
	pop EBP
	ret
END
