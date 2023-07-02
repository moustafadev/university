//открытого хеширования
#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cstdlib>
#include <string>
using namespace std;

const int M = 7;

struct ITEM
{
	string key;
	ITEM* next;
};

struct LIST
{
	string key;
	ITEM* headitem;
};

LIST list[M];

void Initial()
{
	for (int i = 0; i < M; i++)
	{
		list[i].key.empty();
		list[i].headitem = new ITEM;
		list[i].headitem->next = NULL;
	}
}

int Hash(string key)
{
	int sum = 0;
	for (unsigned int i = 0; i < key.size(); i++)
		sum += key[i];
	return sum % M;
}

ITEM* GetItem(int index, int& count)
{
	ITEM* CurrentItem = list[index].headitem;
	while (++count && CurrentItem->next != NULL)
		CurrentItem = CurrentItem->next;
	return CurrentItem;
}

int Add(string key)
{
	int count = 0;
	int hash = Hash(key);
	if (++count && list[hash].key.empty())
		list[hash].key = key;
	else
	{
		cout << endl << "Возникла конфликтная ситуация" << endl;
		ITEM* CurrentItem = GetItem(hash, count);
		ITEM* tmp = new ITEM;
		tmp->key = key;
		tmp->next = NULL;
		CurrentItem->next = tmp;
		CurrentItem = tmp;
	}
	return count;
}

int Search(string key, int& count)
{
	int flag = 0;
	int hash = Hash(key);
	if (++count && list[hash].key == key)
		flag = 1;
	else
	{
		ITEM* tmp = list[hash].headitem->next;
		while (++count && tmp != NULL)
		{
			if (tmp->key == key)
			{
				flag = 1;
				break;
			}
			tmp = tmp->next;
		}
	}
	if (flag)
		return 1;
	else
		return 0;
}

void Show()
{
	cout << endl;
	for (int i = 0; i < M; i++)
	{
		cout << "Table[" << i << "] = " << list[i].key << " : ";
		ITEM* tmp = list[i].headitem->next;
		while (tmp != NULL)
		{
			cout << tmp->key << " ";
			tmp = tmp->next;
		}
		cout << endl;
	}
}

int Del(string key)
{
	int flag = 0;
	int hash = Hash(key);
	if (list[hash].key == key)
	{
		if (list[hash].headitem->next == NULL)
		{
			flag = 1;
			list[hash].key = "";
		}
		else
		{
			list[hash].key = list[hash].headitem->next->key;
			ITEM* tmp = list[hash].headitem->next;
			list[hash].headitem->next = tmp->next;
			flag = 1;
			delete tmp;
		}
	}
	else
	{
		ITEM* prev = list[hash].headitem;
		ITEM* tmp = list[hash].headitem->next;
		while (tmp != NULL)
		{
			if (tmp->key == key)
			{
				prev->next = tmp->next;
				delete tmp;
				flag = 1;
				break;
			}
			else
			{
				prev = tmp;
				tmp = tmp->next;
			}
		}
	}
	return flag;
}

int main()
{
	setlocale(LC_ALL, "Russian");
	string key;
	Initial();
	int count;
	char otv;
	do
	{
		system("cls"); //Очистка экрана

		puts("========================================================");
		puts("\tВыберите номер пункта меню:");
		puts("1 - Добавить");
		puts("2 - Искать");
		puts("3 - Показать");
		puts("4 - Удалить");
		puts("5 - Выход");
		puts("--------------------------------------------------------");

		cout << "Выберите пункт: ";
		cin >> otv;
		switch (otv)

		{
		case '1':
			cout << endl << "Введите ключ = ";
			cin >> key;
			count = 0;
			if (Search(key, count) != 0)
				cout << endl << "Ключ был использован, сравнений = " << count << endl;
			else
			{
				count = Add(key);
				cout << endl << "Ключ добавлен. Cравнений = " << count << endl;
			}
			break;
		case '2':
			cout << endl << "Введите ключ = ";
			cin >> key;
			count = 0;
			if (Search(key, count) != 0)
				cout << endl << "Найдено, сравнений = " << count << endl;
			else
				cout << endl << "Не найдено" << endl;
			break;
		case '3':
			Show();
			break;
		case '4':
			cout << endl << "Введите ключ = ";
			cin >> key;
			if (Del(key) == 1)
				cout << endl << "Удалено" << endl;
			else
				cout << endl << "Не найдено" << endl;
			break;
		case '5':
			break;
		default:
			cout << endl << "Ошибка" << endl;
			break;
		}
		getchar();
	} while (otv != '5');
}