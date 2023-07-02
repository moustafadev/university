//внутреннее хеширование 
#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cstdlib>
#include <string>
using namespace std;

const int M = 10;

void Initial(string* Table)
{
	for (int i = 0; i < M; i++)
		Table[i] = "";
}

int Hash(string key, int j)
{
	int sum = j;
	for (int i = 0; i < key.size(); i++)
		sum += (int)key[i];
	return sum % M;
}

int Add(string* Table, string key, int& count)
{
	int flag = 0;
	int hash;
	for (int i = 0; i < M; i++)
	{
		hash = Hash(key, i);
		count++;
		if (Table[hash].empty())
		{
			Table[hash] = key;
			flag = 1;
			break;
		}
	}
	if (flag == 1)
		return 1;
	else
		return 0;
}

int Search(string* Table, string key, int& count)
{
	int flag = 0;
	int hash;
	for (int i = 0; i < M; i++)
	{
		hash = Hash(key, i);
		count++;
		if (Table[hash] == key)
		{
			flag = 1;
			break;
		}
	}
	if (flag == 1)
		return hash;
	else
		return -1;
}

void Show(string* Table)
{
	for (int i = 0; i < M; i++)
		cout << "Table[" << i << "] = " << Table[i] << endl;
}

int main()
{
	setlocale(LC_ALL, "Russian");
	string Table[M];
	Initial(Table);
	string key;
	int count;
	char otv;
	do
	{
		system("cls"); //Очистка экрана

		puts("========================================================");
		puts("\tВыберите номер пункта меню:");
		puts("1 - Добавить");
		puts("2 - Поиск");
		puts("3 - Показать");
		puts("4 - Выход");
		puts("--------------------------------------------------------");

		cout << "Выберите пункт: ";
		cin >> otv;
		switch (otv)

		{
		case '1':
			count = 0;
			cout << endl << "Введите значение ключа = ";
			cin >> key;
			if (Search(Table, key, count) != -1)
				cout << endl << "Данный ключ уже использовался. Кол-во сравнений = " << count << endl;
			else
			{
				count = 0;
				if (Add(Table, key, count) == 1)
					cout << endl << "Ключ добавлен. Кол-во сравнений = " << count << endl;
				else
					cout << endl << "Ключ не добавлен" << endl;
			}
			break;
		case '2':
			count = 0;
			cout << endl << "Введите значение ключа = ";
			cin >> key;
			if (Search(Table, key, count) != -1) {
				count = 0;
				cout << endl << "Индекс = " << Search(Table, key, count) << " Кол-во сравнений = " << count << endl;
			}
			else
				cout << endl << "Ключ не найден" << endl;
			break;
		case '3':
			Show(Table);
			break;
		case '4':
			break;
		default:
			cout << endl << "Ошибка" << endl;
			break;
		}
		getchar();
	} while (otv != '4');
}

