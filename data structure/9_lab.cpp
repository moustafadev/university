#include <iostream>

using namespace std;
//сбалансированное дерево
//разновидность двоичного дерева,
// для каждой вершины которого число вершин в левом и правом поддеревьях отличаются не более чем на единицу

struct Node{
    int data;
    Node *right;
    Node *left;
};

int generate_int()
{
    return rand() % 100 + 1;
}


void addNodes(Node **current, int N){
    int nl, nr;
    Node* temp;
    if(N == 0){
        *current = nullptr;
    }else{
        nl = N/2;
        nr = N - nl - 1;
        temp = new Node;
        temp->data = generate_int();
        addNodes(&(temp->right), nr);
        addNodes(&(temp->left), nl);
        *current = temp;
    }
}
//Отображение дерева в прямом направлении
void forwardShow(Node *current, int level){
    if(current != nullptr){
        for(int i = 0; i < level*5; i++){
            cout<<" ";
        }
        level+=1;
        cout<<current->data<<endl;
        forwardShow(current->left, level);
        forwardShow(current->right, level);
    }
}
//Отображение дерева симметрично
void symmetricShow(Node *current, int level){
    if(current != nullptr){
        symmetricShow(current->left, level+1);
        for(int i = 0; i < level*5; i++){
            cout<<" ";
        }
        cout<<current->data<<endl;
        symmetricShow(current->right, level+1);
    }
}
//Отображение дерева симметрично назад
void backSymmetricShow(Node *current, int level){
    if(current != nullptr){
        backSymmetricShow(current->right, level+1);
        for(int i = 0; i < level*5; i++){
            cout<<" ";
        }
        cout<<current->data<<endl;
        backSymmetricShow(current->left, level+1);
    }
}

int main(){
    Node* root = nullptr;
    int N, option = 0;
    while (option != 1){
        cout<<" Enter the number of vertices of the PB Tree: ";
        cin>>N;
        addNodes(&root, N);
        cout<<" \nShowing the Tree in a forward way: \n";
        forwardShow(root,0);
        cout<<" \nShowing the Tree in a symmetric way: \n";
        symmetricShow(root,0);
        cout<<" \nShowing the Tree in a back-symmetric way: \n";
        backSymmetricShow(root, 0);
        cout<<" Enter 1 if you wanna leave: ";
        cin>>option;
    }
    return 0;
}

