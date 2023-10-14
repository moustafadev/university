#pragma once
#include "Section.h"
int CorrectInput();

class Shop {

private:

	struct Info
	{
		string name;
	} shop;

	static const int maxCount = 5;

	int Head;

	Section* stack;

public:

	Shop() {
		shop.name = "";
		Head = -1;
		stack = new Section[maxCount];
	}

	Shop(string _name) {
		shop.name = _name;
		Head = -1;
		stack = new Section[maxCount];
	}

	~Shop() {
		if (!IsEmpty()) {
    		delete[] stack;
    	}
    }


	bool IsEmpty() {
		return Head == -1;
	}

	bool IsFull() {
		return Head == maxCount - 1;
	}
	 bool IsNotEmpty() const {
        return (Head >= 0);
    }

	bool Push(Section section)
	{
		if (!(IsFull())) {
			stack[Head + 1] = section;
			Head++;
			return true;
		}
		else {
			return false;
		}
	}

	string Pop() {
		if (!(IsEmpty())) {
			string name = stack[Head].GetName();
			Head--;

			return name;
		}
		else {
			return "";
		}
	}

	int Search(string name) {
		if (IsEmpty())
			return -1;

		int temp = Head;
		for (int i = Head; i >= 0; i--)
		{
			if (stack[i].GetName() == name)
				return i;
		}

		return -1;
	}

	string FullSearch(string surname) {
		if (IsEmpty())
			return "";

		for (int i = Head; i >= 0; i--)
		{
			if (stack[i].Search(surname))
				return stack[i].GetName();
		}
		return "";
	}

	bool SearchInSubList(string name, string surname)
	{
		int i = Search(name);

		if (i == -1) 
			return false;

		if (!stack[i].Search(surname)) 
			return false;

		return true;
	}

	bool AddInSubList(string name, string surname, int salary, bool fromFile = false)
	{
		int i = Search(name);

		if (i == -1)
			return true;

		stack[i].Add(new Manager(surname, salary), fromFile);
		return false;
	}

	bool DeleteFromSubList(string name, string surname)
	{
		int i = Search(name);

		if (i == -1) 
			return false;

		if (stack[i].Delete(surname)) 
			return true;

		return false;
	}

	void Show() {
		cout << "Название магазина: " << shop.name << endl;
		
		if (IsEmpty())
			cout << "Отделов нет!" << endl;
		else
		{
			for (int i = Head; i >= 0; i--)
				stack[i].Show();
		}

		cout << endl;
	}

	void WriteInTXT(ofstream &out) {
		for (int i = 0; i <= Head; i++)
		{
			stack[i].WriteInTXT(out);
		}
	}

	void SetName(string _name) {
		shop.name = _name;
	}

	string GetName() {
		return shop.name;
	}
};