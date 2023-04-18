#include <iostream>
#include <ctime>

using namespace std;


//для каждой вершины ключи в левом поддереве меньше, а в правом поддереве больше ключа этой вершины 

struct  Node{
    int data;
    int count;
    Node* left;
    Node* right;
};

Node* root = nullptr;

int InputNumber() {
    int num = 0;
    cin >> num;
    while (!cin.good()) {
        cout << "Enter the number!" << endl;
        cin.clear();
        cin.ignore(256, '\n');
        std::cin >> num;
    }
    return num;
}

void Add(Node** pCurrent, int data) {
    if (*pCurrent == nullptr) {
        *pCurrent = new Node();
        (*pCurrent)->data = data;
        (*pCurrent)->left = nullptr;
        (*pCurrent)->right = nullptr;
        (*pCurrent)->count = 1;
    }
    else {
        if (data < (*pCurrent)->data)
            Add(&(*pCurrent)->left, data);
        else if (data > (*pCurrent)->data)
            Add(&(*pCurrent)->right, data);
        else
            (*pCurrent)->count++;
    }
}

void ShowBack(Node* pCurrent, int level) {
    if (pCurrent != nullptr) {
        ShowBack(pCurrent->right, level + 1);
        for (int i = 0; i < level; i++) {
            cout << "\t";
        }
        cout << pCurrent->data << "(" << pCurrent->count << ")"<< endl;
        ShowBack(pCurrent->left, level + 1);
    }
}


void ShowInLine(Node* pCurrent) {
    if (pCurrent != nullptr) {
        ShowInLine(pCurrent->left);
        cout << pCurrent->data << "\t";
        ShowInLine(pCurrent->right);
    }
}

void Changer(Node** p, Node** pTemp) {
    if ((*p)->right != nullptr)
        Changer(&(*p)->right, pTemp);
    else {
        (*pTemp)->data = (*p)->data;
        *pTemp = *p;
        *p = (*p)->left;
    }
}

void DeleteItem(Node** pCurrent,int data) {
    Node* pTemp = nullptr;
    if (*pCurrent == nullptr)
        cout << "There is no such a vertex!" << endl;
    else {
        if (data > (*pCurrent)->data)
            DeleteItem(&(*pCurrent)->right, data);
        else if (data < (*pCurrent)->data)
            DeleteItem(&(*pCurrent)->left, data);
        else {
            pTemp = *pCurrent;
            if (pTemp->right == nullptr)
                *pCurrent = pTemp->left;
            else {
                if (pTemp->left == nullptr)
                    *pCurrent = pTemp->right;
                else {
                    Changer(&pTemp->left, &pTemp);
                }
            }
            delete pTemp;
        }
    }
}


void SearchItem(Node* root, int data) {
    Node* pCurrent = root;
    bool isFound = false;
    while (!isFound && pCurrent != nullptr) {
        if (data < pCurrent->data)
            pCurrent = pCurrent->left;
        else if (data > pCurrent->data)
            pCurrent = pCurrent->right;
        else {
            isFound = true;
        }
    }
    if (isFound)
        cout << "Element "<< pCurrent->data << "(" << pCurrent->count << ") " <<" found!" << endl;
    else
        cout << "›ÎÂÏÂÌÚ ÌÂ Ì‡È‰ÂÌ!" << endl;
}

void AddNonRecurs(Node** root, int data) {
    Node* pCurrent = nullptr;
    Node* pParent = nullptr;
    if (*root == nullptr) {
        *root = new Node();
        (*root)->data = data;
        (*root)->left = nullptr;
        (*root)->right = nullptr;
        (*root)->count = 1;
    }
    else {
        pCurrent = *root;
        while (pCurrent != nullptr){
            pParent = pCurrent;
            if (data < pCurrent->data)
                pCurrent = pCurrent->left;
            else if (data > pCurrent->data)
                pCurrent = pCurrent->right;
            else {
                pCurrent->count++;
                pCurrent = nullptr;
            }
        }
        pCurrent = new Node();
        pCurrent->data = data;
        pCurrent->left = nullptr;
        pCurrent->right = nullptr;
        pCurrent->count = 1;
        if (data < pParent->data) {
            pParent->left = pCurrent;
        }
        else if (data > pParent->data) {
            pParent->right = pCurrent;
        }
    }
}

void Clear(Node* pCurrent) {
    if (pCurrent != nullptr) {
        Clear(pCurrent->left);
        Clear(pCurrent->right);
        delete pCurrent;
    }
}

int main()
{
    setlocale(LC_ALL, "ru");
    srand(time(nullptr));
    bool condition = true;
    int answer = 0;
    int num = 0;
    while (condition) {
        std::cout << "\nOptions: \n" <<
                  "1 - Create a new tree\n" <<
                  "2 - Add an element recursively\n" <<
                  "3 - Add an element iteratively\n" <<
                  "4 - Show back-symmetrically\n" <<
                  "5 - Search for the element\n" <<
                  "6 - Remove a vertex\n" <<
                  "7 - Line-by-line output\n" <<
                  "8 - Quit"
                  "Select: " << endl;
        answer = InputNumber();
        switch (answer)
        {
            case 1:
                if (root != nullptr)
                    Clear(root);
                cout << "Enter the number of vertices:" << endl;
                num = InputNumber();
                for (int i = 0; i < num; i++)
                    Add(&root, rand() % 100);
                ShowBack(root, 0);
                break;
            case 2:
                cout << "Enter the number:" << endl;
                num = InputNumber();
                Add(&root, num);
                ShowBack(root, 0);
                break;
            case 3:
                cout << "Enter the number:" << endl;
                num = InputNumber();
                AddNonRecurs(&root, num);
                ShowBack(root, 0);
                break;
            case 4:
                ShowBack(root, 0);
                break;
            case 5:
                cout << "Enter the number:" << endl;
                num = InputNumber();
                SearchItem(root, num);
                break;
            case 6:
                cout << "Enter the number:" << endl;
                num = InputNumber();
                DeleteItem(&root, num);
                ShowBack(root, 0);
                break;
            case 7:
                ShowInLine(root);
                break;
            case 8:
                condition = false;
            default:
                break;
        }
    }
}