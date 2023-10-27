//8. Статический стек неупорядоченных динамических списков
//9. Магазин (название) - композиция отделов (наименование),
//   Отдел - композиция менеджеров по продажам (фамилия, зарплата)

#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cstdlib>
#include <string>
#include <fstream>
#include "Shop.h"
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <ctime>
#include <locale.h>
Shop* shop;

int CorrectInput() {
	int answer;
	while (!(cin >> answer) || (cin.peek() != '\n') || (answer < 0))
	{
		cin.clear();
		while (cin.get() != '\n');
		cout << "Ошибка: введено некорректное число. " << endl <<
			"Повторите: " << endl;
	}
	return answer;
}

void Dialog() {
	shop = new Shop();
	int answer = -1;
	while (answer != 0)
	{
		cout << "Введите одно из предложенных чисел: " << endl <<
			"1 - Создать новый магазин." << endl <<
			"2 - Cоздать пустой магазин." << endl <<
			"3 - Добавить отдел в стек." << endl <<
			"4 - Удалить отдел из стека." << endl <<
			"5 - Добавить менеджера в список." << endl <<
			"6 - Удалить менеджера из списка." << endl <<
			"7 - Найти отдел." << endl <<
			"8 - Найти менеджера в выбранном отделе." << endl <<
			"9 - Найти менеджера по всему магазину." << endl <<
			"10 - Вывести состояние структуры в консоль." << endl <<
			"11 - Загрузить структуру из файла." << endl <<
			"12 - Сохранить структуру в файл." << endl <<
			"0 - Завершить работу." << endl;
		answer = CorrectInput();
		
		system("cls");
		switch (answer)
		{
		case 1:
		{
			if (shop->IsNotEmpty()){
				cout << "Магазин уже существует!\nМагазин успешно удален." << endl;
				shop = new Shop();
			}
			string name;
			cout << "Название магазина: " << endl;
			cin.ignore();
			getline(cin, name);
			shop = new Shop(name);
			cout << "Успешно!" << endl;

			break;
		}
		case 2:
		{
			shop = new Shop();
			cout << "Успешно!" << endl;
			break;
		}
		case 3:
		{
			shop->Show();
			cout << "Наименование отдела: " << endl;
			string name;
			cin.ignore();
			getline(cin, name);
			if (!shop->Push(Section(name)))
				cout << "Ошибка добавления!" << endl;
			break;
		}
		case 4:
		{
			shop->Show();

			string name = shop->Pop();
			if (name != "")
				cout << "Отдел " << name << " удалён!" << endl;
			else
				cout << "Ошибка удаления." << endl;

			break;
		}
		case 5:
		{
			shop->Show();

			string name;
			string surname;
			int salary;

			cout << "Введите наименование отдела: " << endl;
			cin.ignore();
			getline(cin, name);

			cout << "Фамилия менеджера:" << endl;
			getline(cin, surname);

			cout << "Зарплата (руб.): " << endl;
			salary = CorrectInput();

			if (shop->AddInSubList(name, surname, salary))
				cout << "Успешно! " << endl;
			else
				cout << "Ошибка добавления." << endl;

			break;
		}
		case 6:
		{
			shop->Show();
			string name, surname;

			cout << "Введите наименование отдела: " << endl;
			cin.ignore();
			getline(cin, name);

			cout << "Фамилия менеджера:" << endl;
			getline(cin, surname);

			if (shop->DeleteFromSubList(name, surname))
				cout << "Успешно!" << endl;
			else
				cout << "Ошибка удаления." << endl;

			break;
		}
		case 7:
		{
			shop->Show();
			string name;
			cout << "Введите наименование искомого отдела: " << endl;
			cin.ignore();
			getline(cin, name);

			if (shop->Search(name) != -1)
				cout << "Отдел найден!" << endl;
			else
				cout << "Отдел не найден." << endl;

			break;
		}
		case 8:
		{
			shop->Show();
			string name, surname;

			cout << "Введите наименование отдела: " << endl;
			cin.ignore();
			getline(cin, name);

			cout << "Фамилия искомого менеджера:" << endl;
			getline(cin, surname);

			if (shop->SearchInSubList(name, surname))
				cout << "Менеджер найден!" << endl;
			else
				cout << "Менеджер не найден!" << endl;
			
			break;
		}
		case 9:
		{
			shop->Show();
			string surname;

			cout << "Фамилия искомого менеджера:" << endl;
			cin.ignore();
			getline(cin, surname);

			string name = shop->FullSearch(surname);
			if (name != "")
				cout << "Менеджер найден!" << endl
				<< "Он работает в отделе: " << name << endl;
			else
				cout << "Менеджер не найден!" << endl;

			break;
		}
		case 10:
		{
			shop->Show();
			break;
		}
		case 11:
		{
			ifstream in;
			in.open("save.txt");
			bool successful = true;

			if (!in.is_open())
			{
				cout << "Ошибка чтения файла." << endl;
				successful = false;
				break;
			}
			else
			{
				char line[1000];
				char* parts;

				in.getline(line, 1000);
				string name = line;

				shop = new Shop(line);

				while (!in.eof()) {
					 

					in.getline(line, 1000);

					char* parts = strtok(line, "$");

					if (parts == NULL)
						continue;

					string name = parts;

					if (!shop->Push(Section(name)))
					{
						cout << "Ошибка: массив переполнен." << endl;
						successful = false;
						break;
					}

					parts = strtok(NULL, "$");

					if (parts == NULL)
						continue;

					while (parts != NULL) {

						string surname = parts;
						parts = strtok(NULL, "$");

						if (parts == NULL)
						{
							cout << "Ошибка: не хватает данных." << endl;
							successful = false;
							break;
						}

						int salary = atoi(parts);

						string str = parts;

						for (int i = 0; i < str.length(); i++)
						{
							if (str[i] < '0' || str[i] > '9')
							{
								cout << "Ошибка: некорректный тип данных." << endl;
								successful = false;
								break;
							}
						}

						parts = strtok(NULL, "$");

						if (shop->AddInSubList(name, surname, salary, true))
						{
							cout << "Ошибка: массив переполнен." << endl;
							successful = false;
							break;
						}
					}
					if (!successful)
						break;
					
				}
			}
			in.close();
			if (successful)
				cout << "Данные успешно загружены!" << endl;
			else
			{
				shop = new Shop();
				cout << "Нарушение структуры записи файла." << endl;
			}

			break;
		}
		case 12:
		{
			ofstream out;
			out.open("save.txt");

			if (!out.is_open())
			{
				cout << "Ошибка чтения файла." << endl;
			}
			else
			{
				shop->WriteInTXT(out);

				out.close();
				cout << "Данные успешно выгружены!" << endl;
			}
			break;
		}
		case 0:
			cout << "Удачи!" << endl;
			break;

		default:
			cout << "Ошибка: выбранного вами пункта не существует." << endl;
			break;
		}
		system("pause");
		system("cls");
	}
}

int main() {
	// SetConsoleCP(1251);
	// SetConsoleOutputCP(1251);
	Dialog();
	return 0;
}
