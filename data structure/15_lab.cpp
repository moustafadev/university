//Специальные методы сортировки
#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cstdlib>
using namespace std;

int spos;

int* CreateMyself(int n)//создание массива с уникальными значениями
{
	if (n <= 10000 && n > 1)
	{
		spos = 1;
		int* mas = new int[n];
		int i = 0;
		for (int i = 0; i < n; i++)
			mas[i] = i;

		for (int i = 0; i < n * 100; i++)
			swap(mas[rand() % (n - 1)], mas[rand() % (n - 1)]);
		return mas;
	}
	else
		return NULL;
}

int* CreateAuto(int n)//создание массива автрматически
{
	if (n <= 10000 && n > 1)
	{
		spos = 0;
		int* mas = new int[n];
		for (int i = 0; i < n; i++)
			mas[i] = rand() % n;
		return mas;
	}
	else
		return NULL;
}

void Show(int* mas, int n)//показ массива
{
	cout << endl;
	for (int i = 0; i < n; i++)
		cout << mas[i] << " ";
	cout << endl;
}

void Copy(int* mas, int* copia, int n)//копировка основного массива
{
	for (int i = 0; i < n; i++)
		copia[i] = mas[i];
}

//Простейшая карманная сортировка
void KarmanWithDop(int* mas, int n)//Карманная сортировка с дополнительным массивом
{
	int moves = 0;
	int* sort = new int[n];
	for (int i = 0; i < n; i++, moves++)
		sort[mas[i]] = mas[i];
	Show(sort, n);
	cout << endl << "Сравнений не проводилось." << endl
		<< "Количество пересылок: " << moves << endl;
	delete[] sort;
}
//Карманная сортировка без дополнительного массива
void KarmanWithout(int* mas, int n)
{
	int moves = 0, srav = 0;
	for (int i = 0; i < n; i++)
		while (++srav && mas[i] != i)
		{
			int tmp = mas[i];
			mas[i] = mas[tmp];
			mas[tmp] = tmp;
			moves++;
		}
	Show(mas, n);
	cout << endl << "Количество сравнений: " << srav << endl
		<< "Количество перестановок: " << moves << endl;
}

struct ITEM
{
	int info;
	ITEM* next;
};

void AddItem(ITEM* pItem, int info)
{
	while (pItem->next != NULL)
		pItem = pItem->next;
	pItem->next = new ITEM;
	pItem->next->info = info;
	pItem->next->next = NULL;
}

void ClearList(ITEM* head)
{
	while (head != NULL)
	{
		ITEM* tmp = head;
		head = head->next;
		delete tmp;
	}
}

//Обобщенная карманная сортировка
void ShowKC(ITEM* mas, int n)
{
	cout << endl;
	for (int i = 0; i < n; i++)
	{
		ITEM* current = mas[i].next;
		while (current != NULL)
		{
			cout << current->info << " ";
			current = current->next;
		}
	}
	cout << endl;
}

void KarmCommon(int* mas, int n)
{
	ITEM* sort = new ITEM[n];
	int moves = 0;
	for (int i = 0; i < n; i++)
		sort[i].next = NULL;
	for (int i = 0; i < n; i++, moves++)
		AddItem(&sort[mas[i]], mas[i]);
	ShowKC(sort, n);
	cout << endl << "Количество пересылок: " << moves << endl;
	for (int i = 0; i < n; i++)
		ClearList(sort[i].next);
	delete[] sort;
}

//Поразрядная сортировка
void Razrad(int* mas, int n)
{
	ITEM* sort = new ITEM[10];
	int k = n - 1;
	int i = 0;
	int moves = 0;
	while (k >= 1)
	{
		i++;
		k /= 10;
		for (int j = 0; j < 10; j++)
			sort[j].next = NULL;
		for (int j = 0; j < n; j++)
		{
			int div = 1;
			for (int l = 0; l < i; l++, div *= 10);
			AddItem(&sort[((mas[j] % div) * 10) / div], mas[j]);
			moves++;
		}
		for (int j = 0, l = 0; l < n; j++)
		{
			ITEM* tmp = sort[j].next;
			while (tmp != NULL)
			{
				mas[l] = tmp->info;
				tmp = tmp->next;
				l++;
				moves++;
			}
		}
		for (int j = 0; j < 10; j++)
			ClearList(sort[j].next);
	}
	Show(mas, n);
	cout << "Количество пересылок: " << moves << endl;
	delete[] sort;
}

int main()
{
	setlocale(LC_ALL, "Russian");
	int* unsort = NULL;
	int* sort = NULL;
	int n = 0;
	char otv;
	do
	{
		system("cls"); //Очистка экрана

		puts("========================================================");
		puts("\tВыберите номер пункта меню:");
		puts("1 - Автоматическое создание массива с уникальными значениями");
		puts("2 - Автоматическое создание массива с повторяющимися значениями");
		puts("3 - Показать исходный массив");
		puts("4 - Карманная сортировка с дополнительным массивом");
		puts("5 - Карманная сортировка без дополнительного массива");
		puts("6 - Обобщенная карманная сортировка");
		puts("7 - Поразрядная сортировка");
		puts("8 - Выход");
		puts("--------------------------------------------------------");

		cout << "Выберите пункт: ";
		cin >> otv;
		switch (otv)
		{
		case '1':
			if (n > 0)
			{
				delete[] unsort;
				delete[] sort;
			}
			cout << endl << "Введите размер массива: ";
			cin >> n;
			unsort = CreateMyself(n);
			if (unsort != NULL)
			{
				sort = new int[n];
				cout << endl << "Массив создан" << endl;
			}
			else
			{
				cout << endl << "Невозможно создать массив" << endl;
				n = 0;
			}
			break;
		case '2':
			if (n > 0)
			{
				delete[] unsort;
				delete[] sort;
			}
			cout << endl << "Введите размер массива: ";
			cin >> n;
			unsort = CreateAuto(n);
			if (unsort != NULL)
			{
				sort = new int[n];
				cout << endl << "Массив создан" << endl;
			}
			else
			{
				cout << endl << "Невозможно создать массив" << endl;
				n = 0;
			}
			break;
		case '3':
			if (n > 0)
				Show(unsort, n);
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '4':
			if (n > 0)
			{
				if (spos)
				{
					Copy(unsort, sort, n);
					KarmanWithDop(sort, n);
				}
				else
					cout << endl << "Создайте массив с уникальными значениями" << endl;
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '5':
			if (n > 0)
			{
				if (spos)
				{
					Copy(unsort, sort, n);
					KarmanWithout(sort, n);
				}
				else
					cout << endl << "Создайте массив с уникальными значениями" << endl;
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '6':
			if (n > 0)
			{
				KarmCommon(unsort, n);
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '7':
			if (n > 0)
			{
				Copy(unsort, sort, n);
				Razrad(sort, n);
			}
			else
				cout << endl << "Массив пуст!" << endl;
			break;
		case '8':
			break;
		default:
			cout << endl << "Ошибка" << endl;
			break;
		}
		getchar();
	} while (otv != '8');
}