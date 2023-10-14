#pragma once
#include "Manager.h"
int CorrectInput();

class Section
{
private:

	struct Info {
		string name;
	} section;

	Manager* head = new Manager();

public:

	Section() {
		section.name = "";
	}

	Section(string _name) {
		
		section.name = _name;
	}

	~Section() {
		while (head) {
			Manager* temp = head;
			head = head->GetNext();
			delete(temp);
		}
	}

	bool IsEmpty() {
		return head == nullptr;
	}

	void Add(Manager* manager, bool fromFile = false) {

		if (IsEmpty())
		{
			head = manager;
		}
		else
		{
			if (!fromFile) //���� ���� ���������� �� �� �����, �.�. ������������, ��/����� ���� ��������
			{
				cout << "Выберите тип добавления:" << endl <<
					"1 - Добавить до..." << endl <<
					"2 - Добавить после..." << endl;


				int choice = CorrectInput();

				
				while (choice != 1 && choice != 2) {
					cout << "Некорректный выбор типа добавления." << endl <<
						"Выберите тип добавления:" << endl <<
						"1 - Добавить до..." << endl <<
						"2 - Добавить после..." << endl;
					choice = CorrectInput();
				}


				cout << "Фамилия ""опорного"" менеджера:" << endl;
				string surname;
				cin.ignore();
				getline(cin, surname);
				Manager* temp = Search(surname);

				if (temp != nullptr)
				{
					if (choice == 1)//Добавление до...
					{
						if (head == temp) //Если добавляем до первого элемента списка
						{
							head = manager;
							manager->SetNext(temp);
						}
						else //В остальных случаях
						{
							Manager* before = head;
							while (before->GetNext() != temp)
								before = before->GetNext();

							before->SetNext(manager);
							manager->SetNext(temp);
						}
					}
					else //Добавление после...
					{
						manager->SetNext(temp->GetNext());
						temp->SetNext(manager);
					}
				}
				else
					cout << "Искомый менеджер не найден." << endl;
			}
			else //В случае, если ввод из файла, новый элемент всегда добавляется в конец
			{
				Manager* before = head;
				while (before->GetNext() != nullptr)
					before = before->GetNext();

				before->SetNext(manager);
			}

		}
	}

	Manager* Search(string surname) {
		if (!IsEmpty())
		{

			Manager* temp = head;
			while (temp != nullptr) {

				if (temp->GetSurname() == surname)
					return temp;
				else
					temp = temp->GetNext();
			}

		}
		return nullptr;
	}

	bool Delete(string surname) {
		Manager* toDelete = Search(surname);

		if (toDelete) {

			if (toDelete == head)  //Если удаляемый элемент - первый в списке
			{
				delete head;
				head = nullptr;
			}
			else//В остальных случаях
			{
				Manager* before = head;
				while (before->GetNext() != toDelete)
					before = before->GetNext();

				Manager* after = toDelete->GetNext();
				before->SetNext(after);

				delete toDelete;
			}

			return true;
		}
		return false;
	}

	void Show() {
		cout << "	Название отдела: " << section.name << endl;

		if (IsEmpty())
			cout << "Менеджеров нет!" << endl;
		else
		{
			Manager* temp = head;
			while (temp != nullptr)
			{
				cout << "		Фамилия менеджера: " << temp->GetSurname() << "; зарплата: " << temp->GetSalary() << " у.е." << endl;
				temp = temp->GetNext();
			}
		}
	}


	void WriteInTXT(ofstream &out) {
		out << section.name;
		Manager* temp = head;
		while (temp != nullptr)
		{
			out << "$" << temp->GetSurname() << "$" << temp->GetSalary();
			temp = temp->GetNext();
		}
		out << endl;
	}

	void SetName(string _name) {
		section.name = _name;
	}

	string GetName() {
		return section.name;
	}
};