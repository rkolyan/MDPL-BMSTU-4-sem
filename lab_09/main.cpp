#include <iostream>
#include "funcs.h"

int NF = 0;

int main(void)
{
    std::cout << "The result of non-recursive factorial is:" << factorial1(6, &NF) << std::endl;
	std::cout << "The result of recursive factorial is:" << factorial2(4, &NF) << std::endl;
	return 0;
}
