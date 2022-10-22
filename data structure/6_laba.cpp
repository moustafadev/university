#include <iostream>

using namespace std;

struct Node{
    int data;
    Node *next;
};

bool isEmpty(Node **head){
    return (*head)->next == nullptr;
}

bool isStackEmpty(Node **head){
    return (*head) == nullptr;
}

void pushBack(Node **head, int data){
    Node *temp = new Node;
    temp->data = data;
    temp->next = nullptr;
    (*head)->next = temp;
}

bool pushAfter(Node **head, int data, int elementData){
    Node *current = (*head)->next;
    while ((current != nullptr)&&(current->data != elementData)){
        current = current->next;
    }
    if(current == nullptr){
        return false;
    } else{
        Node *temp = new Node;
        temp->data = data;
        temp->next = current->next;
        current->next = temp;
        return true;
    }
}
void show(Node **head){
    int i = 1;
    Node *current = (*head)->next;
    while (current != nullptr){
        cout<<i<<"--->"<<current->data<<endl;
        current = current->next;
        i++;
    }
}

bool pushBefore(Node **head, int data, int elementData){
    Node *current = (*head)->next;
    Node *prev = (*head);
    while ((current != nullptr)&&(current->data != elementData)){
        prev = current;
        current = current->next;
    }
    if(current == nullptr){
        return false;
    } else{
        Node *temp = new Node;
        temp->data = data;
        prev->next = temp;
        temp->next = current;
        return true;
    }
}

bool removeToStack(Node **head, int data, Node **stack){
    Node *current = (*head)->next;
    Node *prev = (*head);
    while ((current != nullptr)&&(current->data != data)){
        prev = current;
        current = current->next;
    }
    if(current == nullptr){
        return false;
    } else{
        prev->next = current->next;
        current->next = (*stack);
        (*stack) = current;
        return true;
    }
}



void showStack(Node **head){
    int i = 1;
    Node *current = (*head);
    while (current != nullptr){
        cout<<i<<"--->"<<current->data<<endl;
        current = current->next;
        i++;
    }
}

int main(){
    Node *head = new Node;
    head->next = nullptr;
    Node *stack = nullptr;
    int option = 0, data = 0, item = 0;
    bool check;
    while (option != 6){
        cout<<"\n\t1.Push after\n\t2.Push before\n\t3.Remove to the stack\n\t4.Show\n\t"
              "5.Show stack\n\t6.Exit\n\t"
              " Enter your choice: ";
        cin>>option;
        switch (option){
            case 1:
                cout<<"\n Enter the number: ";
                cin>>data;
                if(isEmpty(&head)){
                    pushBack(&head,data);
                } else{
                    cout<<"\n\n Enter the element after which you want to insert a new element: ";
                    cin>>item;
                    check = pushAfter(&head,data,item);
                    if(!check){
                        cout<<"\n\n There is no such an element!";
                    } else{
                        cout<<"\n\n Done!";
                    }
                }
                break;
            case 2:
                cout<<"\n Enter the number: ";
                cin>>data;
                if(isEmpty(&head)){
                    pushBack(&head,data);
                } else{
                    cout<<"\n\n Enter the element before which you want to insert a new element: ";
                    cin>>item;
                    check = pushBefore(&head,data,item);
                    if(!check){
                        cout<<"\n\n There is no such an element!";
                    } else{
                        cout<<"\n\nDone!";
                    }
                }
                break;
            case 3:
                cout<<"\n Enter the element you want to remove: ";
                cin>>data;
                if(!isEmpty(&head)){
                    check = removeToStack(&head,data,&stack);
                    if(!check){
                        cout<<"\n\n There is no such an element!";
                    } else{
                        cout<<"\n\n Done!";
                    }
                } else{
                    cout<<"\n\n The stack is empty!";
                }
                break;
            case 4:
                if(isEmpty(&head)){
                    cout<<"\n is empty!";
                }else{
                    show(&head);
                }
                break;
            case 5:
                if(isStackEmpty(&stack)){
                    cout<<"\n Stack is empty!";
                }else{
                    showStack(&stack);
                }
                break;
            case 6:
                break;
            default:
                cout<<"\n Wrong input!";
                break;
        }
    }
    return 0;
}

