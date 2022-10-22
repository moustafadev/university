
#include <iostream>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <ctime>
#include <locale.h>

using namespace std;




int kbhit(void)
{
  struct termios oldt, newt;
  int ch;
  int oldf;
 
  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
  fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);
 
  ch = getchar();
 
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);
 
  if(ch != EOF)
  {
    ungetc(ch, stdin);
    return 1;
  }
 
  return 0;
}


using namespace std;

struct queue_element 
{
	char data; 
	queue_element* next = nullptr; 
	queue_element* prev = nullptr; 
};


struct queue 
{
	queue_element* first = nullptr; 
	queue_element* last = nullptr; 
};


bool queue_is_empty(queue* q) 
{
	return q->first == nullptr || q->last == nullptr;
}


void push(queue* q, char inf)
{
	queue_element* temp = new queue_element; 
	temp->data = inf;

	if (queue_is_empty(q)) { 
		q->first = temp;
		q->last = temp;
	}
	else {
		temp->prev = q->last;
		q->last->next = temp;
		q->last = temp;
	}

}


void pop(queue* q)
{
	
	if (!queue_is_empty(q)) { 
		queue_element* to_delete = q->first;

		if (q->first == q->last)
		{
			q->first = nullptr;
			q->last = nullptr;
		}
		else 
		{
			q->first = q->first->next;
			q->first->prev = nullptr;
			
		}

		delete to_delete;
	}
}


void show(queue* q) 
{
	cout << "Статус: ";
	if (queue_is_empty(q)) {
		cout << "Очередь пуста!" << endl;
		return;
	}

	queue_element* temp = q->first;

	while (temp) 
	{
		cout << temp->data << " ";
		temp = temp->next;
	}
	cout << endl;
}


char get_random_char()
{
	return rand() % 26 + 65;
}


int main()
{
	setlocale(LC_ALL, "Rus");
	queue q;

	srand(time(nullptr));
	cout << "Генератор случайных чисел обновлен!" << endl;

	char p = 'a'; 

	while (p != 'q') {
		int r = rand() % 101;

		if (r % 2 == 0) {
			const int count = rand() % 3 + 1;
			cout << "Добавлено " << count <<   endl;
			for (int i = 0; i < count; i++)
				push(&q, get_random_char());
		}
		else {
			const int count = rand() % 3 + 1;
			cout << "Удалено " << count <<  endl;
			for (int i = 0; i < count; i++)
				pop(&q);
		}
		show(&q);

        if (kbhit()) {
            if (getchar() == 'q') {
                p = 'q';
            } else{
                continue;
            }
        }
        usleep(100000);
	}

	return 0;
}
