#pragma once
#include <string>
using namespace std;

class Manager {
private:

	struct Info {
		string surname;
		int salary;
	} manager;

	Manager* next;

public:

	Manager() {
		manager.surname = "";
		manager.salary = -1;
		next = nullptr;
	}

	Manager(string _surname, int _salary) {
		manager.surname = _surname;
		manager.salary = _salary;
		next = nullptr;
	}

	void SetSurname(string _surname) {
		manager.surname = _surname;
	}

	void SetSalary(int _salary) {
		manager.salary = _salary;
	}

	string GetSurname() {
		return manager.surname;
	}

	int GetSalary() {
		return manager.salary;
	}

	void SetNext(Manager* _next) {
		next = _next;
	}

	Manager* GetNext() {
		return next;
	}
};