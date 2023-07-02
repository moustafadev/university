

//Простейшие методы сортировки – алгоритмически простые методы сортировки массивов с трудоемкостью порядка n2
//алгоритмически достаточно сложные методы сортировки массивов с трудоемкостью порядка  n*logn

//улучшенные методы сортировки
//Пирамидальная сортировка – улучшенный метод сортировки массивов, основанный на специальном 
//представлении исходного массива в виде так называемой пирамиды

//Метод Шелла - основанный на многократном группировании элементов массива с уменьшающимся шагом и последующей сортировкой методом вставок
//Быстрая сортировка -основанный на разбиении набора данных на все меньшие подмассивы с последующей сортировкой каждого из них


//Улучшенные методы сортировки массивов
#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cstdlib>
using namespace std;

int* Create(int n)//Создание массива
{
	if (n <= 10000)
	{
		int* mas;
		mas = new int[n];
		for (int i = 0; i < n; i++)
			mas[i] = rand() % 100;
		return mas;
	}
	return NULL;
}

void Copy(int* mas, int* copia, int n)//копировка основного массива
{
	for (int i = 0; i < n; i++)
		copia[i] = mas[i];
}

void Show(int* mas, int n)//Показ неотсортированного массива
{
	for (int i = 0; i < n; i++)
		cout << mas[i] << " ";
}

void ShowSort(int* mas, int n, int srav, int moves)//Показ сортированного массива
{
	for (int i = 0; i < n; i++)
		cout << mas[i] << " ";
	cout << endl << "Количество сравнений: " << srav
		<< endl << "Количество перестановок: " << moves;
	cout << endl << endl;;
}

//Метод Шелла(вставок)
void Shell(int* mas, int n, int* steps, int t)
{
	int srav = 0, moves = 0;
	for (int m = 0; m < t; m++)
	{
		int k = steps[m];
		for (int i = k; i < n; i++)
		{
			int tmp = mas[i];
			int j = i - k;
			moves++;
			while (srav++ && j >= 0 && tmp < mas[j])
			{
				mas[j + k] = mas[j];
				j = j - k;
				moves++;
			}
			moves++;
			mas[j + k] = tmp;
		}
	}
	ShowSort(mas, n, srav, moves / 3);
}

//Метод быстрой сортировки(обмен)
void QuickSort(int* mas, int left, int right, int& srav, int& moves)
{
	int i = left;
	int j = right;
	int mid = mas[(left + right) / 2];
	while (i <= j)
	{
		while (++srav && mas[i] < mid) i++;
		while (++srav && mas[j] > mid) j--;
		if (i <= j)
		{
			int tmp = mas[i];
			mas[i] = mas[j];
			mas[j] = tmp;
			i++;
			j--;
			moves++;
		}
	}
	if (left < j)
		QuickSort(mas, left, j, srav, moves);
	if (i < right)
		QuickSort(mas, i, right, srav, moves);
}

//Метод пирамидальной сортировки(выбор)
int srav = 0, moves = 0;
void Sito(int* mas, int k, int n)
{
	while (1)
	{
		int left = 2 * k + 1;
		int right = 2 * k + 2;
		int largest;
		if (left<n && mas[left]>mas[k])
			largest = left;
		else
			largest = k;
		srav++;
		if (right<n && mas[right]>mas[largest])
			largest = right;
		if (largest == k)
			break;
		int tmp = mas[k];
		mas[k] = mas[largest];
		mas[largest] = tmp;
		moves++;
		k = largest;
	}
}

void PyramidalSort(int* mas, int n)
{
	for (int i = (n - 1) / 2; i >= 0; i--)
		Sito(mas, i, n);
	for (int i = n - 1; i >= 1; i--)
	{
		int tmp = mas[0];
		mas[0] = mas[i];
		mas[i] = tmp;
		moves++;
		Sito(mas, 0, i);
	}
	ShowSort(mas, n, srav, moves);
	srav = 0; moves = 0;
}

int main()
{
	setlocale(LC_ALL, "Russian");
	char otv;
	int num;
	int* unsort = NULL;
	int* sort = NULL;
	do
	{
		system("cls"); //Очистка экрана

		puts("\tВыберите номер пункта меню:");
		puts("1 - Создать массив");
		puts("2 - Показать неотсортированный массив");
		puts("3 - Метод Шелла");
		puts("4 - Метод быстрой сортировки");
		puts("5 - Метод пирамидальной сортировки");
		puts("0 - Выход");

		cout << "Выберите пункт: ";
		cin >> otv;
		system("cls");
		switch (otv)
		{
		case '1':
			if (unsort != NULL)
			{
				delete[] unsort;
				delete[] sort;
			}
			cout << "Введите количество элементов для добаления: ";
			cin >> num;
			unsort = Create(num);
			if (unsort != NULL)
			{
				sort = new int[num];
				cout << "Массив создан!" << endl;
			}
			else
				cout << "Массив невозможно создать!" << endl;
			break;
		case '2':
			if (unsort != NULL)
			{
				Show(unsort, num);
				cout << endl;
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '3':
			if (unsort != NULL)
			{
				cout << "Введите количество шагов: ";
				int t;
				cin >> t;
				cout << endl << "Значения шагов: ";
				int* pSteps = new int[t];
				for (int i = 0; i < t; i++)
					cin >> pSteps[i];
				cout << endl;
				Copy(unsort, sort, num);
				Shell(sort, num, pSteps, t);
				delete[] pSteps;
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '4':
			if (unsort != NULL)
			{
				int moves = 0, srav = 0;
				Copy(unsort, sort, num);
				QuickSort(sort, 0, num - 1, srav, moves);
				ShowSort(sort, num, srav, moves);
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '5':
			if (unsort != NULL)
			{
				Copy(unsort, sort, num);
				PyramidalSort(sort, num);
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '0':
			delete[] sort;
			delete[] unsort;
			break;
		default:
			printf("Произошла ошибка!\n");
		}

		getchar();
	} while (otv != '0');
}

