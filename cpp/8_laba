#include <iostream>

using namespace std;

struct SubNode{
    int data;
    SubNode *next;
};

struct MainNode{
    MainNode *Next;
    SubNode *Data;
    int id;
};

bool isMainEmpty(MainNode** Head){
    return (*Head)->Next == nullptr;
}

bool isSubEmpty(SubNode** head){
    return (*head)->next == nullptr;
}

void pushMainBack(MainNode** Head, int new_id){
    MainNode *temp = new MainNode;
    temp->Data = new SubNode;
    (temp->Data)->next = nullptr;
    temp->id = new_id;
    (*Head)->Next = temp;
    temp->Next = nullptr;
}

bool pushMainAfter(int id, MainNode** Head ,int new_id){
    MainNode* current = (*Head)->Next;
    while ((current != nullptr)&&(current->id != id)){
        current = current->Next;
    }
    if(current == nullptr){
        return false;
    } else{
        MainNode *temp = new MainNode;
        temp->id = new_id;
        temp->Data = new SubNode;
        (temp->Data)->next = nullptr;
        temp->Next = current->Next;
        current->Next = temp;
        return true;
    }
}

bool pushMainBefore(int id, MainNode** Head, int new_id){
    MainNode* current = (*Head)->Next;
    MainNode* prev = (*Head);
    while ((current != nullptr)&&(current->id != id)){
        prev = current;
        current = current->Next;
    }
    if(current == nullptr){
        return false;
    } else{
        MainNode *temp = new MainNode;
        temp->id = new_id;
        temp->Data = new SubNode;
        (temp->Data)->next = nullptr;
        prev->Next = temp;
        temp->Next = current;
        return true;
    }
}

void totalSubRemove(SubNode **nodeToRemove){
    SubNode* current = (*nodeToRemove)->next;
    SubNode* prev = (*nodeToRemove);
    while (current != nullptr){
        prev = current;
        current = current->next;
        delete(prev);
    }
    delete(*nodeToRemove);
}

bool removeMain(MainNode** Head, int id){
    MainNode* current = (*Head)->Next;
    MainNode* prev = (*Head);
    while ((current != nullptr)&&(current->id != id)){
        prev = current;
        current = current->Next;
    }
    if(current == nullptr){
        return false;
    } else{
        prev->Next = current->Next;
        totalSubRemove(&(current->Data));
        delete(current);
        return true;
    }
}

SubNode* findMain(int id, MainNode** Head){
    MainNode* current = (*Head)->Next;
    while ((current != nullptr)&&(current->id != id)){
        current = current->Next;
    }
    return current->Data;
}

bool idCheck(MainNode** Head, int id){
    MainNode* current = (*Head)->Next;
    while (current != nullptr){
        if(current->id == id){
            break;
        }
        current = current->Next;
    }
    return current != nullptr;
}

void pushSubBack(SubNode** head, int data){
    SubNode* temp = new SubNode;
    temp->data = data;
    (*head)->next = temp;
    temp->next = nullptr;
}

bool pushSubAfter(SubNode** head, int data, int push_after){
    SubNode* current = (*head)->next;
    while ((current != nullptr)&&(current->data != push_after)){
        current = current->next;
    }
    if(current == nullptr){
        return false;
    } else{
        SubNode* temp = new SubNode;
        temp->data = data;
        temp->next = current->next;
        current->next = temp;
        return true;
    }
}

bool pushSubBefore(SubNode** head, int data, int push_before){
    SubNode* current = (*head)->next;
    SubNode* prev = (*head);
    while ((current != nullptr)&&(current->data != push_before)){
        prev = current;
        current = current->next;
    }
    if(current == nullptr){
        return false;
    } else{
        SubNode* temp = new SubNode;
        temp->data = data;
        prev->next = temp;
        temp->next = current;
        return true;
    }
}

bool removeSub(SubNode** head, int data){
    SubNode* current = (*head)->next;
    SubNode* prev = (*head);
    while ((current != nullptr)&&(current->data != data)){
        prev = current;
        current = current->next;
    }
    if(current == nullptr){
        return false;
    } else{
        prev->next = current->next;
        delete(current);
        return true;
    }
}

void show(MainNode **Head){
    MainNode *current = (*Head)->Next;
    SubNode* curr;
    while (current != nullptr){
        cout<<"\n MAIN_LIST id: "<<current->id<<endl;
        curr = (current->Data);
        if (isSubEmpty(&curr)){
            cout<<"\t\tis empty";
        } else{
            curr = curr->next;
            while (curr != nullptr){
                cout<<"\t\t "<<curr->data<<endl;
                curr = curr->next;
            }
        }
        current = current->Next;
    }
}

void singleShow(MainNode **Head, int id){
    MainNode *current = (*Head)->Next;
    while ((current != nullptr)&&(current->id != id)){
        current = current->Next;
    }
    if(current == nullptr){
        cout<<"\n Wrong id!";
    } else{
        cout<<"\n MAIN_LIST id: "<<current->id;
        SubNode* head = current->Data;
        if(isSubEmpty(&head)){
            cout<<"\n Sublist is empty!";
        } else{
            head = head->next;
            while (head != nullptr){
                cout<<"- "<<head->data;
                head = head->next;
            }
        }
    }
}

int main(){
    MainNode *Head = new MainNode;
    Head->Next = nullptr;
    int option =  0, data = 0, new_id = 0, id = 0, element = 0;
    bool check;
    while (option != 9){
        cout<<"\n\n 1. Push after a new MAIN_LIST node\n 2. Push before a new MAIN_LIST node\n 3. Remove a MAIN_LIST node\n "
              "4. Push after a new number\n 5. Push before a new number\n 6. Remove an element\n 7. Show the list of list\n "
              "8. Single show\n 9.Exit \n Enter your choice: ";
        cin>>option;
        switch (option){
            case 1:
                cout<<"\n\n Enter the new MAIN_LIST id: ";
                cin>>new_id;
                if(isMainEmpty(&Head)){
                    pushMainBack(&Head,new_id);
                } else{
                    cout<<"\n\n Enter id of the MAIN_LIST node after which, you want to add a new node: ";
                    cin>>id;
                    check = pushMainAfter(id,&Head,new_id);
                    if(!check){
                        cout<<"\n\n There is no a node with this id!";
                    } else{
                        cout<<"\n\n Done!";
                    }
                }
                break;
            case 2:
                cout<<"\n\n Enter the new MAIN_LIST id: ";
                cin>>new_id;
                if(isMainEmpty(&Head)){
                    pushMainBack(&Head,new_id);
                } else{
                    cout<<"\n\n Enter id of the MAIN_LIST node before which, you want to add a new node: ";
                    cin>>id;
                    check = pushMainBefore(id,&Head,new_id);
                    if(!check){
                        cout<<"\n\n There is no a node with this id!";
                    } else{
                        cout<<"\n\n Done!";
                    }
                }
                break;
            case 3:
                cout<<"\n\n Enter id of the MAIN_LIST you want to remove: ";
                cin>>id;
                if(isMainEmpty(&Head)){
                    cout<<"\n The MAIN_LIST is empty!";
                } else{
                    check = removeMain(&Head, id);
                    if(!check){
                        cout<<"\n\n There is no a node with this id!";
                    } else{
                        cout<<"\n\n Done!";
                    }
                }
                break;
            case 4:
                cout<<"\n\n Enter id of the MAIN_LIST to whose sublist, you want to add a new number: ";
                cin>>id;
                if(isMainEmpty(&Head)){
                    cout<<"\n MAIN_LIST is empty, add a new MAIN_LIST node to add a number";
                } else{
                    check = idCheck(&Head, id);
                    if(!check){
                        cout<<"\n\n There is no a node with this id!";
                    } else{
                        SubNode* current = findMain(id,&Head);
                        cout<<"\n Enter a new number: ";
                        cin>>data;
                        if(isSubEmpty(&current)){
                            pushSubBack(&current, data);
                        } else{
                            cout<<"\n Enter the value of the element after which you wanna insert a number: ";
                            cin>>element;
                            pushSubAfter(&current, data, element);
                        }
                    }
                }
                break;
            case 5:
                cout<<"\n\n Enter id of the MAIN_LIST to whose sublist, you want to add a new number: ";
                cin>>id;
                if(isMainEmpty(&Head)){
                    cout<<"\n MAIN_LIST is empty, add a new MAIN_LIST node to add a number";
                } else{
                    check = idCheck(&Head, id);
                    if(!check){
                        cout<<"\n\n There is no a node with this id!";
                    } else{
                        SubNode* current = findMain(id,&Head);
                        cout<<"\n Enter a new number: ";
                        cin>>data;
                        if(isSubEmpty(&current)){
                            pushSubBack(&current, data);
                        } else{
                            cout<<"\n Enter the value of the element before which you wanna insert a number: ";
                            cin>>element;
                            pushSubBefore(&current, data, element);
                        }
                    }
                }
                break;
            case 6:
                cout<<"\n\n Enter id of the MAIN_LIST from whose sublist, you want to remove a number: ";
                cin>>id;
                if(isMainEmpty(&Head)){
                    cout<<"\n MAIN_LIST is empty, add a new MAIN_LIST node";
                } else{
                    check = idCheck(&Head, id);
                    if(!check){
                        cout<<"\n\n There is no a node with this id!";
                    } else{
                        SubNode* current = findMain(id,&Head);
                        cout<<"\n Enter a number you want to remove: ";
                        cin>>data;
                        if(isSubEmpty(&current)){
                            cout<<"\n Sublist is empty!";
                        } else{
                            removeSub(&current, data);
                        }
                    }
                }
                break;
            case 7:
                if(isMainEmpty(&Head)){
                    cout<<"\n MAIN_LIST is empty!";
                } else{
                    show(&Head);
                }
                break;
            case 8:
                if(isMainEmpty(&Head)){
                    cout<<"\n MAIN_LIST is empty!";
                } else{
                    cout<<"\n Enter the id of the MAIN_LIST node you want to display";
                    cin>>id;
                    singleShow(&Head, id);
                }
                break;
            case 9:
                break;
            default:
                cout<<"\n Wrong input!";
                break;
        }
    }
    return 0;
}
