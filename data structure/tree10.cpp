//Лабораторная работа №10 (Раздел 1, Тема 5, Номер 2) -
// ИДЕАЛЬНО СБАЛАНСИРОВАННОЕ ДВОИЧНОЕ ДЕРЕВО С НЕРЕКУРСИВНЫМ ВАРИАНТОМ СИММЕТРИЧНОГО ОБХОДА (ВСПОМОГАТЕЛЬНЫЙ СТЕК)

//Структура данных "дерево"(идеально сбалансированное двоичное дерево, нерекурсивный симметричный обход
// (вспомогательный стек - для хранения последовательности
//пройденных вершин от корня до текущей вершины и уровня этих вершин в дереве))

#include <iostream>
#include <cstdlib>

using namespace std;

int N; 

int failure() {
    int a;
    while (!(cin >> a) || (cin.peek() != '\n'))
    {
        cin.clear();
        while (cin.get() != '\n');
        cout << "\nINPUT ERROR. REPEAT ENTER \n" << endl;
    }
    return a;
}


struct Tree {
    int value; 
    Tree* Left; 
    Tree* Right; 
} *pRoot; 

struct Stack {
    int level; 
    Tree* Point; 
    Stack* next; 
} *sp; 


void initStack(Tree* pRoot) {
    sp = new Stack;
    sp->Point = pRoot;
    sp->level = -1;
    sp->next = NULL;
}

// Проверка пустоты стека
bool isEmpty() {
    if (sp->level < 0) return 1;
    else return 0;
}

Tree* AddNodes(Tree* pCurrent, int aN) { 
    Tree* pTemp;
    int Nl, Nr;
    if (aN == 0) 
        return NULL; 
    else {
        Nl = aN / 2; 
        Nr = aN - Nl - 1;
        pTemp = new Tree; 
        pTemp->value = rand() % 100; 
        pTemp->Left = AddNodes(pTemp->Left, Nl); 
        pTemp->Right = AddNodes(pTemp->Right, Nr);
        pCurrent = pTemp;
        return pTemp; 
    }
}

void Forward(Tree* pCurrent, int level) { //ПОСТРОЧНЫЙ ВЫВОД В ПРЯМОМ НАПРАВЛЕНИИ
    if (pCurrent != NULL) {
        string str; 
        for (int i = 0; i < level; i++)
            str += "     ";
        cout << " " << str << pCurrent->value << "\n";
        Forward(pCurrent->Left, level + 1); 
        Forward(pCurrent->Right, level + 1); 
    }

}


void Nonrecursive() { //НЕРЕКУРСИВНЫЙ ВЫВОД В СИММЕТРИЧНОМ НАПРАВЛЕНИИ
    initStack(pRoot);
    Tree* pCurrentTree = pRoot;
    bool Stop = false;
    int level = 0;

    while (!Stop) {
        while (pCurrentTree != NULL) {
            Stack* temp = new Stack;
            temp->level = level;
            temp->next = sp;
            temp->Point = pCurrentTree;
            sp = temp;
            pCurrentTree = pCurrentTree->Left;
            level++;
        }
        if (isEmpty()) {
            Stop = true;
        }
        else {
            level = sp->level;
            pCurrentTree = sp->Point;
            Stack* tp = sp;
            sp = sp->next;
            delete tp;//удаление осо стека
            for (int i = 0; i < level; i++) {
                cout << "     ";
            }
            cout << pCurrentTree->value << endl;
            pCurrentTree = pCurrentTree->Right;
            level++;
        }
    }
}

void Symmetric(Tree* pCurrent, int level) { //ПОСТРОЧНЫЙ ВЫВОД В СИММЕТРИЧНОМ НАПРАВЛЕНИИ
    if (pCurrent != NULL) {
        Symmetric(pCurrent->Left, level + 1);
        string str; 
        for (int i = 0; i < level; i++)
            str += "     ";
        cout << " " << str << pCurrent->value << "\n";
        Symmetric(pCurrent->Right, level + 1);
    }
}

void BackSymmetric(Tree* pCurrent, int level) {//ПОСТРОЧНЫЙ ВЫВОД В ОБРАТНО-СИММЕТРИЧНОМ НАПРАВЛЕНИИ
    if (pCurrent != NULL) {
        BackSymmetric(pCurrent->Right, level + 1); 
        string str; 
        for (int i = 0; i < level; i++)
            str += "     ";
        cout << " " << str << pCurrent->value << "\n";
        BackSymmetric(pCurrent->Left, level + 1); 
    }
}


void delTree(Tree* pCurrent) {
    if (pCurrent != NULL) {
        delTree(pCurrent->Left); 
        delTree(pCurrent->Right); 
        delete pCurrent; 
    }
};

int main() {
    setlocale(LC_ALL, "rus");
    srand(static_cast<unsigned int>(time(0))); 
    while (true) {
        cout << " ___________________________________________________________" << endl; N = -1;
        while (N <= 0) { //ПОСТРОЕНИЕ ИСД С ЗАДАННЫМ ЧИСЛОМ ВЕРШИН
            cout << "Numer of vertexes: ";
            N = failure();
            if (N <= 0) cout << " A tree with a non-positive number " << N << " No peaks will be displayed. Repeat entry" << endl;
            else {
                pRoot = AddNodes(pRoot, N);
                cout << " A perfectly balanced tree with a number of periods'" << N << "' creature" << endl;
            }
        }
        cout << "\n Line output in direct order:" << endl;
        Forward(pRoot, 0);//ПОСТРОЧНЫЙ ВЫВОД В ПРЯМОМ НАПРАВЛЕНИИ
        cout << "\n Line output in symmetric system:" << endl;
        Symmetric(pRoot, 0);//ПОСТРОЧНЫЙ ВЫВОД В СИММЕТРИЧНОМ НАПРАВЛЕНИИ
        cout << "\n Non-recurring variant of the symmetrical bypass:" << endl;
        Nonrecursive();//НЕРЕКУРСИВНЫЙ ВЫВОД В СИММЕТРИЧНОМ НАПРАВЛЕНИИ
        cout << "\n Line output in reverse symmetric order:" << endl;
        BackSymmetric(pRoot, 0);//ПОСТРОЧНЫЙ ВЫВОД В ОБРАТНО-СИММЕТРИЧНОМ НАПРАВЛЕНИИ
        delTree(pRoot);
        cout << "Tree removed" << endl;
    }
    return 0;
}

