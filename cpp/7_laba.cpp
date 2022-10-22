#include <iostream>

using namespace std;

struct Node{
    int data;
    Node *next;
    Node *prev;
};
bool isEmpty(Node **head);
Node* findDirectionRight(Node **head, int elementData);
Node* findDirectionLeft(Node **head, int elementData);
bool pushBefore(Node **head, int data, int elementData);
bool pushAfter(Node **head, int data, int elementData);
void pushBack(Node **head, int data);
void showRight(Node **head);
void showLeft(Node **head);
bool remove(Node **head, int data);

bool isEmpty(Node **head){
    return (*head)->next == (*head);
}

Node* findDirectionRight(Node **head, int elementData){
    Node *current = (*head)->next;
    while ((current != (*head))&&(current->data != elementData)){
        current = current->next;
    }
    return current;
}

Node* findDirectionLeft(Node **head, int elementData){
    Node *current = (*head)->prev;
    while ((current != (*head))&&(current->data != elementData)){
        current = current->prev;
    }
    return current;
}

bool pushBefore(Node **head, int data, int elementData){
    Node *temp = new Node;
    temp->data = data;
    Node *current = findDirectionLeft(head,elementData);
    if(current == (*head)){
        return false;
    } else{
        Node *prev = current->prev;
        current->prev = temp;
        temp->next = current;
        temp->prev = prev;
        prev->next = temp;
        return true;
    }
}

bool pushAfter(Node **head, int data, int elementData){
    Node *temp = new Node;
    temp->data = data;
    Node *current = findDirectionRight(head,elementData);
    if(current == (*head)){
        return false;
    } else{
        Node *next = current->next;
        current->next = temp;
        temp->prev = current;
        temp->next = next;
        next->prev = temp;
        return true;
    }
}

bool remove(Node **head, int data){
    Node *current = findDirectionRight(head,data);
    if(current->next == (*head)){
        return false;
    } else{
        current->prev->next = current->next;
        current->next->prev = current->prev;
        delete(current);
        return true;
    }
}

void pushBack(Node **head, int data){
    Node *temp = new Node;
    temp->data = data;
    temp->next = (*head);
    temp->prev = (*head);
    (*head)->next = temp;
    (*head)->prev = temp;
}

void showRight(Node **head){
    int i = 0;
    Node *current = (*head)->next;
    while(current != (*head)){
        cout<<i<<"--->"<<current->data<<endl;
        current = current->next;
        i++;
    }
}

void showLeft(Node **head){
    int i = 0;
    Node *current = (*head)->prev;
    while(current != (*head)){
        cout<<i<<"--->"<<current->data<<endl;
        current = current->prev;
        i++;
    }
}

int main(){
    Node *head = new Node;
    head->next = head;
    head->prev = head;
    int option = 0, item, data, el;
    bool check;
    while(option != 6){
        cout<<"\n\t1.Push after\n\t2.Push before\n\t3.Remove\n\t4.Show Right \n\t5.Show Left\n\t"
              "6.Exit\n\t"
              " Enter your choice: ";
        cin>>option;
        switch (option){
            case 1:
                cout<<"\n Enter the number: ";
                cin>>data;
                if(isEmpty(&head)){
                    pushBack(&head,data);
                } else{
                    cout<<"\nEnter the element after which you want to insert a new element: ";
                    cin>>item;
                    check = pushAfter(&head,data,item);
                    if(!check){
                        cout<<"\n\nThere is no such an element!";
                    } else{
                        cout<<"\n\nDone!";
                    }
                }
                break;
            case 2:
                cout<<"\n Enter the number: ";
                cin>>data;
                if(isEmpty(&head)){
                    pushBack(&head,data);
                } else{
                    cout<<"\nEnter the element before which you want to insert a new element: ";
                    cin>>item;
                    check = pushBefore(&head,data,item);
                    if(!check){
                        cout<<"\n\nThere is no such an element!";
                    } else{
                        cout<<"\n\nDone!";
                    }
                }
                break;
            case 3:
                cout<<"\n Enter the element you want to remove: ";
                cin>>el;
                if(!isEmpty(&head)){
                    check = remove(&head,el);
                    if(!check){
                        cout<<"\n\nThere is no such an element!";
                    } else{
                        cout<<"\n\nDone!";
                    }
                } else{
                    cout<<"\n\nThe stack is empty!";
                }
                break;
            case 4:
                showRight(&head);
                break;
            case 5:
                showLeft(&head);
                break;
            case 6:
                break;
            default:
                cout<<"\nWrong input!";
                break;
        }
    }
    return 0;
}

