#include "funcs.h"

#define SIZE 8

int matr[SIZE][SIZE] = { {0, 1, 2, 3, 4},
					{5, 6, 7, 8, 9},
					{10, 11, 12, 13, 14},
					{15, 16, 17, 18, 19},
					{20, 21, 22, 23, 24}};

int main(void)
{
	print_matr(&matr[0][0], SIZE);
	asm_transpone(&matr[0][0], 5, SIZE);
	print_matr(&matr[0][0], SIZE);
	asm_transpone(&matr[0][0], 5, SIZE);

	print_matr(&matr[0][0], SIZE);
	cpp_transpone(&matr[0][0], 5, SIZE);
	print_matr(&matr[0][0], SIZE);
	return 0;
}
