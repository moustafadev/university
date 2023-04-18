//Лабораторная работа №11 (Раздел 1, Тема 5, Номер 3) - ОБРАБОТКА ПРОИЗВОЛЬНЫХ ДВОИЧНЫХ ДЕРЕВЬЕВ

#include <iostream>
#include <cstdlib>

using namespace std;

bool founded = false; 

int failure() {
    int a;
    while (!(cin >> a) || (cin.peek() != '\n'))
    {
        cin.clear();
        while (cin.get() != '\n');
        cout << "\n ОШИБКА ВВОДА. ПОВТОРИТЕ ВВОД: ";
    }
    return a;
}


struct Tree {
    int value; 
    Tree *Left; 
    Tree *Right; 
} *pRoot, *pParent; 


void Forward(Tree *current, int level) {
    if (current != NULL) {
        string str; 
        for (int i = 0; i < level; i++)
            str+= "     ";
        cout << " " << str << current->value << "\n" ;
        Forward (current -> Left, level + 1); 
        Forward (current -> Right, level + 1); 
    }
}


void Symmetric (Tree *pCurrent, int level) {
    if (pCurrent != NULL) {
        Symmetric (pCurrent -> Left, level + 1); 
        string str; 
        for (int i = 0; i < level; i++)
            str+= "     ";
        cout << " " << str << pCurrent->value << "\n" ;
        Symmetric (pCurrent -> Right, level + 1); 
    }
}


void BackSymmetric (Tree *pCurrent, int level) {
    if (pCurrent != NULL) {
        BackSymmetric (pCurrent -> Right, level + 1); 
        string str; 
        for (int i = 0; i < level; i++)
            str+= "     ";
        cout << " " << str << pCurrent->value << "\n" ;
        BackSymmetric (pCurrent -> Left, level + 1); 
    }
}


void Find(Tree *current, int _value) {
    if (!founded)
        if (current != NULL) {
            if (current -> value == _value) {
                founded = true;
                pParent = current;
            }
            else {
                Find (current -> Left, _value); 
                Find (current -> Right, _value);
            }
        }
}

void FindDialog() {
    int _value;
    cout <<"\n ВВЕДИТЕ ЗНАЧЕНИЕ ВЕРШИНЫ, КОТОРУЮ ХОТИТЕ НАЙТИ: "; _value = failure();
    founded = false;
    Find(pRoot, _value);
    if (founded){
        cout <<" ЭЛЕМЕНТ '" << _value << "' НАЙДЕН\n";
        founded = false;
    }
    else
        cout <<" ЭЛЕМЕНТ '" << _value << "' НЕ НАЙДЕН\n";
}

void show(){
    cout <<"\n СОСТОЯНИЕ ДЕРЕВА:";
    if (pRoot != NULL) {
        cout <<"\n\n ПОСТРОЧНЫЙ ВЫВОД В ПРЯМОМ ПОРЯДКЕ:\n\n";
        Forward(pRoot, 0);
        cout <<"\n ПОСТРОЧНЫЙ ВЫВОД В СИММЕТРИЧНОМ ПОРЯДКЕ:\n\n";
        Symmetric(pRoot, 0);
        cout <<"\n ПОСТРОЧНЫЙ ВЫВОД В ОБРАТНО-СИММЕТРИЧНОМ ПОРЯДКЕ:\n\n";
        BackSymmetric(pRoot, 0);
    }
    else {
        cout <<" ДЕРЕВО ПУСТОЕ\n\n";
    }
}

Tree *AddTree(Tree *pTemp, int _value) {
    pTemp = new Tree;
    pTemp -> Left = pTemp -> Right = NULL;
    pTemp -> value = _value;
    return pTemp;
}


void AddNode() {
    int _value, n;
    if (pRoot != NULL) {
        cout <<"\n ВВЕДИТЕ ЗНАЧЕНИЕ ВЕРШИНЫ-РОДИТЕЛЯ ДЛЯ НОВОГО ЭЛЕМЕНТА: "; _value = failure();
        founded = false;
        Find(pRoot, _value); 
        if (founded) {
            founded = false;
            if (pParent -> Left == NULL || pParent -> Right == NULL) { 
                cout <<"\n ВВЕДИТЕ ЗНАЧЕНИЕ, КОТОРОЕ ХОТИТЕ ПРИСВОИТЬ ВЕРШИНЕ: "; _value = failure();
            }
            if (pParent -> Left == NULL && pParent -> Right == NULL) {
                cout <<"\n ВЕРШИНА НЕ ИМЕЕТ НИ ОДНОГО ПОТОМКА. КАКУЮ ВЕРШИНУ (1 - ЛЕВЫЙ ПОТОМОК; 2 - ПРАВЫЙ ПОТОМОК) ДОБАВИТЬ?\n ВАШ ВЫБОР: ";
                n = failure();
                while ((n != 1) && (n != 2)) {
                    cout <<" ТАКОЙ КОМАНДЫ НЕ СУЩЕСТВУЕТ. ПОВТОРИТЕ ВВОД: "; n = failure();
                }
                if (n == 1) {
                    pParent -> Left = AddTree(pParent->Left, _value);
                    cout <<" ВЕРШИНА УСПЕШНО ДОБАВЛЕНА КАК ЛЕВЫЙ ПОТОМОК РОДИТЕЛЬСКОЙ ВЕРШИНЫ \n";
                }
                if (n == 2) {
                    pParent -> Right = AddTree(pParent->Right, _value);
                    cout <<" ВЕРШИНА УСПЕШНО ДОБАВЛЕНА КАК ПРАВЫЙ ПОТОМОК РОДИТЕЛЬСКОЙ ВЕРШИНЫ \n";
                }
            }
            else if (pParent -> Left == NULL) {
                pParent -> Left = AddTree(pParent->Left, _value);
                cout <<" ВЕРШИНА УСПЕШНО ДОБАВЛЕНА КАК ЛЕВЫЙ ПОТОМОК РОДИТЕЛЬСКОЙ ВЕРШИНЫ \n";
            }
            else if (pParent -> Right == NULL) {
                pParent -> Right = AddTree(pParent->Right, _value);
                cout <<" ВЕРШИНА УСПЕШНО ДОБАВЛЕНА КАК ПРАВЫЙ ПОТОМОК РОДИТЕЛЬСКОЙ ВЕРШИНЫ \n";
            }
            else { cout <<" ДОБАВЛЕНИЕ НЕВОЗМОЖНО: ВЕРШИНА-РОДИТЕЛЬ УЖЕ ИМЕЕТ ДВУХ ПОТОМКОВ  \n"; return;}
            show();
        }
        else cout <<" ВЕРШИНА-РОДИТЕЛЬ '"<< _value<<"' НЕ НАЙДЕНА \n";
    }
    else { //если дерево пустое, то создать корень дерева
        pRoot = new Tree;
        cout <<"\n ВВЕДИТЕ ЗНАЧЕНИЕ ВЕРШИНЫ-КОРНЯ, КОТОРУЮ ХОТИТЕ ДОБАВИТЬ: "; _value = failure();
        pRoot -> Left = pRoot -> Right = NULL;
        pRoot -> value = _value;
        cout <<" КОРЕНЬ ДЕРЕВА '"<< pRoot -> value<<"' УСПЕШНО СОЗДАН \n";
    }
}

void delTree(Tree *pCurrent) {
    if (pCurrent != NULL) {
        delTree(pCurrent -> Left); 
        delTree(pCurrent -> Right); 
        delete pCurrent;
        cout << " ПОДДЕРЕВО СО ЗНАЧЕНИЕМ КОРНЕВОЙ ВЕРШИНЫ '" << pCurrent -> value << "' УДАЛЕНО\n";
    }
};

int main() {
    pRoot = NULL;
    int n = -1;
    while (true) {
        n = -1;
        cout << " ___________________________________________________________\n\n";
        cout <<" ВЫБЕРИТЕ ДЕЙСТВИЕ ИЗ СПИСКА\n";
        cout <<" 1 - ПОИСК ВЕРШИНЫ С ЗАДАННЫМ ЗНАЧЕНИЕМ ИНФОРМАЦИОННОЙ ЧАСТИ\n";
        cout <<" 2 - ДОБАВЛЕНИЕ ЛЕВОГО ИЛИ ПРАВОГО ПОТОМКА ДЛЯ ЗАДАННОЙ ВЕРШИНЫ\n";
        cout <<" 3 - ПОСТРОЧНЫЙ ВЫВОД ДЕРЕВА С ПОМОЩЬЮ ОСНОВНЫХ ПРАВИЛ ОБХОДА\n";
        cout <<" 4 - УНИЧТОЖЕНИЕ ВСЕГО ДЕРЕВА\n";
        cout <<" 5 - ВЫХОД ИЗ ПРОГРАММЫ\n";
        cout <<" ВАШ ВЫБОР: "; n = failure();
        while ((n <= 0) || (n > 5)) {
            cout <<" ТАКОЙ КОМАНДЫ НЕ СУЩЕСТВУЕТ. ПОВТОРИТЕ ВВОД: ";
            n = failure();
        }
        if (n == 1)
            FindDialog();
        else if (n == 2)
            AddNode();
        else if (n == 3)
            show();
        else if (n == 4) {
            cout << "\n УНИЧТОЖЕНИЕ ВСЕГО ДЕРЕВА (ОЧИСТКА ПАМЯТИ)...\n";
            delTree(pRoot);
            pRoot = NULL;
        }
        else if (n==5)
            break;
    }
    cout << "\n ОЧИСТКА ПАМЯТИ...\n";
    delTree(pRoot); 
    cout << "\n ВЫХОД ИЗ ПРОГРАММЫ...\n\n ";
    return 0;
}


