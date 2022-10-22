// ConsoleApplication1.cpp : This file contains the 'main' function. Program execution begins and ends there.
//










#include <iostream>
#include <iostream>
using namespace std;


struct Node
{
	int value;
	Node* next;
};

Node* sp = NULL, * sp_second = NULL;

void push(int _value) {
	Node* item = new Node;
	item->value = _value;
	item->next = sp;
	sp = item;
}


void move_to_second_stek() {
	Node* current = sp;
	sp = sp->next;
	current->next = sp_second;
	sp_second = current;
}

void add_from_second() {
	Node* current = sp_second;
	sp_second = sp_second->next;
	current->next = sp;
	sp = current;
}


bool isEmpty() {
	return sp == NULL;
}

void pop() {
	if (isEmpty())
		cout << "Stack empty";
	else
	{
		Node* temp = new Node;
		sp = sp->next;
		temp = temp->next = NULL;
		delete temp;
	}
}

void displyFirstStack(Node* head) {
	Node* current = head;
	while (current != nullptr) {
		cout << "\n" << current->value;
		current = current->next;
	}
}

void displySecondStack(Node* sp_second)
{
	Node* ctr = sp_second;
	while (ctr != NULL)
	{
		cout << ctr->value << " ";
		ctr = ctr->next;
	}
}

int main()
{
	int choose = 0, data, addChoose, count;
	while (choose != 5) {
		cout << " \n\nOptions: \n 1. Add an element.\n 2. Remove an element in memory\n 3. Show all the elements first Stack.\n 4. Show all the elements second Stack.\n 5. Exit\n Your choice: ";
		cin >> choose;
		switch (choose) {
		case 1:
			cout << "how to add the element \n 1.Add an element in console \n 2.Add an element on second Stack \n Your choice: ";
			cin >> addChoose;
			cout << "how many count: ";
			cin >> count;
			while (count != 0)
			{
				if (addChoose == 1) {

					push(rand());

				}
				else
				{
					add_from_second();
				}
				count--;

			}
			cout << "\nDone!";
			break;
		case 2:
			cout << "how to remove the element \n 1.remove an element in memory \n 2.remove and add to second Stack \n Your choice: ";

			cin >> addChoose;
			cout << "how many count: ";
			cin >> count;
			while (count != 0)
			{
				if (addChoose == 1) {
					pop();
				}
				else
				{
					move_to_second_stek();
				}
			}
			cout << "\nDone!";
			break;
		case 3:
			displyFirstStack(sp);
			break;
		case 4:
			displySecondStack(sp_second);
			break;
		default:
			cout << "\nWrong number!";
			break;
		}

	}

}

