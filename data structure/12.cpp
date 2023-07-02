//Программа №12 (Раздел 1, Тема 6, Номер 1) - ПОСТРОЕНИЕ И ОБРАБОТКА ДВОИЧНЫХ ДЕРЕВЬЕВ ПОИСКА

#include <stdio.h>
#include <locale.h>
#include <stdlib.h>
#include <iostream>
#include <string>

using namespace std;

int failure() {
	int a;
	while (!(std::cin >> a) || std::cin.peek() != '\n') {
		std::cin.clear();
		while (std::cin.get() != '\n');
		std::cout << "\n ОШИБКА ВВОДА. ПОВТОРИТЕ ВВОД: ";
	}
	return a;
}


struct Tree {
	int inf;
	Tree *Left;
	Tree *Right;
	int count;
};
Tree *tree = NULL;
int counter = 0;

Tree* search(Tree *tree, Tree *parent, int inf)
{
	if (tree == NULL)
	{
		printf("Дерево пустое\n");
		return NULL;
	}
	else
	{
		Tree  *current = tree;
		while (current != NULL)
		{
			if (current->inf == inf)
			{
				return current;
			}
			else if (current->inf > inf)
			{
				if (parent != NULL)
				{
					parent = current;
				}
				current = current->Left;
			}
			else if (current->inf < inf)
			{
				if (parent != NULL)
				{
					parent = current;
				}
				current = current->Right;
			}
		}
		return NULL;
	}
}

void Add(Tree *&tree, int inf)
{
	if (tree == NULL)
	{
		tree = new Tree;
		counter++;
		tree->inf = inf;
		tree->Right = NULL;
		tree->Left = NULL;
		tree->count = 1;
		return;
	}
	else
	{
		if (tree->inf < inf)
		{
			Add(tree->Right, inf);
		}
		else
		{
			if (tree->inf > inf)
			{
				Add(tree->Left, inf);
			}
			else
			{
				tree->count++;
			}
		}
	}
}

void AddCycle(int inf)
{
	if (tree == NULL)
	{
		tree = new Tree;
		tree->inf = inf;
		tree->Right = NULL;
		tree->Left = NULL;
		tree->count = 1;
		counter++;
		return;
	}
	else
	{
		Tree *parent = tree;
		Tree *current = tree;
		while (current != NULL)
		{
			parent = current;
			if (inf > current->inf)
			{
				current = current->Right;
			}
			else
			{
				if (inf < current->inf)
				{
					current = current->Left;
				}
				else
				{
					current->count++;
					current = NULL;
				}
			}
		}
		if (inf > parent->inf)
		{
			parent->Right = new Tree;
			parent->Right->inf = inf;
			parent->Right->count = 1;
			parent->Right->Left = NULL;
			parent->Right->Right = NULL;
			counter++;
		}
		else if (inf < parent->inf)
		{
			parent->Left = new Tree;
			parent->Left->inf = inf;
			parent->Left->count = 1;
			parent->Left->Left = NULL;
			parent->Left->Right = NULL;
			counter++;
		}
	}
}

void AddRecurs(Tree*& tree, int inf) {
	if (tree == NULL) {
		tree = new Tree;
		counter++;
		tree->inf = inf;
		tree->Right = NULL;
		tree->Left = NULL;
		tree->count = 1;
		return;
	}
	else {
		if (tree->inf < inf) {
			AddRecurs(tree->Right, inf);
		}
		else {
			if (tree->inf > inf) {
				AddRecurs(tree->Left, inf);
			}
			else {
				tree->count++;
			}
		}
	}
}

void Show(Tree* tree, int level)

{
	int letf =0, right = 0;
	if (tree != NULL)

	{
		level++;
		Show(tree->Right, level);
		for (int i = 1; i < level; i++)
		{
			printf("      ");
		}
		printf("%d", tree->inf);

		if (tree->Right != NULL) {
			right = (tree->Right->inf);
		}
		if (tree->Left != NULL) {
			letf = (tree->Left->inf);
		}

		printf("(%d,%d)\n",right, letf);
		Show(tree->Left, level);
		printf("\n");
	}
		
}

void Ascend(Tree *tree, int level)
{
	if (tree != NULL)
	{
		level++;
		Ascend(tree->Left, level);
		printf("%d(%d) ", tree->inf, tree->count);
		Ascend(tree->Right, level);
	}
}

void Change(Tree *&current, Tree *&temp)
{
	if (current->Right != NULL)
	{
		Change(current->Right, temp);
	}
	else
	{
		temp->inf = current->inf;
		temp = current;
		current = current->Left;
	}
}

void Delete(Tree *&tree, int inf)
{
	if (tree != NULL)
	{
		if (inf < tree->inf)
		{
			Delete(tree->Left, inf);
		}
		else
		{
			if (inf > tree->inf)
			{
				Delete(tree->Right, inf);
			}
			else
			{
				Tree *temp = tree;
				if (temp->Right == NULL)
				{
					tree = temp->Left;
				}
				else
				{
					if (temp->Left == NULL)
					{
						tree = temp->Right;
					}
					else
					{
						Change(tree->Left, temp);
					}
				}
				free(temp);
				counter--;
			}
		}
	}
}

void Destroy(Tree *&tree)
{
	if (tree != NULL)
	{
		Destroy(tree->Left);
		Destroy(tree->Right);
		free(tree);
		counter--;
		if (counter == 0)
		{
			tree = NULL;
		}
	}
}

int main()
{
	setlocale(LC_ALL, "rus");
	int select = 0;
	while (select != 9)
	{


		printf("1)Создать дерево\n2)Добавить вершину (нерекурсивно)\n3)Добавить вершину (рекурсивно)\n4)Поиск вершины\n5)Вывод (обратно-симметричный)\n6)Вывод в порядке возрастания\n7)Удалить вершину\n8)Уничтожить дерево\n9)Вызод\n");
		//std::cout << select << std::endl;
		select = failure();
		while ((select < 0) || (select > 10)) {
			printf(" ТАКОЙ КОМАНДЫ НЕ СУЩЕСТВУЕТ. ПОВТОРИТЕ ВВОД:\n ");
			select = failure();
		}
		if (select == 1)
		{
			int count = 0;
			printf("Введите кол-во вершин в дереве\n");
			std::cin >> count;
			for (int i = 0; i < count; i++)
			{
				int inf = rand() % 100 + 1;
				Add(tree, inf);
			}
			system("pause");
		}
		else if (select == 2)
		{
			int inf = 0; 
			printf("Введите информационную часть вершины для добавления\n");
			std::cin >> inf;
			AddCycle(inf);
			system("pause");
		}
		else if (select == 3)
		{
			int inf = 0;
			printf("Введите информационную часть вершины для добавления\n");
			std::cin >> inf;
			AddRecurs(tree, inf);
			system("pause");
		}
		else if (select == 4)
		{
			int inf = 0;
			printf("Введите информационную часть вершины для поиска\n");
			std::cin >> inf ;
			Tree *found = search(tree, NULL, inf);
			if (found == NULL)
			{
				printf("Элемент не найден.\n");
				continue;
			}
			cout << "Элемент найден" << endl;
			printf("%d(%d)", found->inf, found->count);
			system("pause");
		}
		else if (select == 5)
		{
			if (tree != NULL)
			{
				Show(tree, 0);
			}
			else
			{
				printf("Дерево пустое\n");
			}
			system("pause");
		}
		else if (select == 6)
		{
			if (tree != NULL)
			{
				Ascend(tree, 0);
			}
			else
			{
				printf("Дерево пустое\n");
			}
			system("pause");
		}
		else if (select == 7)
		{
			if (tree != NULL)
			{
				int inf = 0;
				printf("Введите информационную часть вершины для удаления\n");
				std::cin >> inf ;
				Delete(tree, inf);
			}
			else
			{
				printf("Ничего нет\n");
			}
			system("pause");
		}
		else if (select == 8)
		{
			Destroy(tree);
			printf("Дерево сломано\n");
			system("pause");
		}
		else if (select == 9)
		{
			break;
		}
		//system("cls");
	}
}