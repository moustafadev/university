#include <stdio.h>
#include <iostream>
#include <unistd.h>
#include <termios.h>
using namespace std;

int main()
{
	int i = 3;
	int* ptr_to_i = &i;
	int** ptr_to_ptr_to_i = &ptr_to_i;
	*ptr_to_i=4;
	cout << **ptr_to_ptr_to_i << endl;
	cout << i;

	return 0;
}

