#include <iostream>
#include "funcs.h"

using namespace std;

void asm_transpone(int *matr, int l, int lmax)
{
	__asm
	{
		push EBP	
		mov ECX, l
		mov EBX, matr	; EBX <==> n1
		shl lmax, 2	; lmax = lmax * 4 (int занимает 4 байта, поэтому длина одной строки будет = lmax * 4 байт)

	CYCLE1:
		push ECX	; Постоянно сохраняет текущее значение счетчика, чтобы пользоваться счетчиком во вложенном цикле
		mov EAX, EBX 	; EAX <==> n2
		mov EDX, EAX 	; EDX <==> n3
		push EBX

	CYCLE2:			; Если присмотреться, то здесь код можно было бы сделать короче, но Евтих хочет 3 XCHG
		mov EBX, [EAX]	; Альтернативная реализация:
		xchg EBX, [EAX]	; mov EBX, [EAX]
		xchg [EDX], EBX	; xchg [EDX], EBX
		xchg [EAX], EBX	; mov [EAX], EBX
		
		add EAX, 4	; Размер int == 4, поэтому следующий элемент будет лежать через 4 байта
		add EDX, lmax	; Следующий элемент в текущем столбце
		loop CYCLE2
		
		pop EBX
		add EBX, lmax	
		add EBX, 4	; Переход на следующий элемент на главной диагонали
		pop ECX
		loop CYCLE1
		pop EBP
	}
}

void cpp_transpone(int *matr, int l, int lmax)
{
	int n1 = 0, n2 = 0, n3 = 0;
	int tmp = 0;
	for (int i = l; i > 0; i--)
	{
		n2 = n1;
		n3 = n2;
		for (int j = i; j > 0; j--)
		{
			tmp = matr[n2];
			matr[n2] = matr[n3];
			matr[n3] = tmp;
			n2++;
			n3 += lmax;
		}
		n1 += lmax + 1;
	}
}

void print_matr(int *matr, int l)
{
	cout << "Matrix:" << endl;
	for (int i = 0; i < l; i++)
	{
		for (int j = 0; j < l; j++)
		{
			cout << matr[i * l + j] << '\t';
		}
		cout << endl;
	}
}
