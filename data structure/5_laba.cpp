#include <iostream>
#define SIZE 10
using namespace std;

struct Node{
    int data;
    int next = -1;
};

int currentSize = 0;

bool isEmpty(){
    return currentSize == 0;
}

bool isFull(){
    return currentSize == SIZE;
}

int findEmptyCell(Node *arr){
    for(int i = 0; i < SIZE + 1; i++){
        if(arr[i + 1].next == -1){
            return (i + 1);
        }
    }
}

bool addBefore(Node *arr, int data, int element){
    int current, emptyCell, prevToCurrent = 0;
    if(isFull()){
        cout<<"\nStack is full!";
    }else{
        emptyCell = findEmptyCell(arr);
        arr[emptyCell].data = data;
        current = arr[0].next;
        while(current != 0){
            if(arr[current].data == element){
                arr[prevToCurrent].next = emptyCell;
                arr[emptyCell].next = current;
                currentSize++;
                return true;
            }
            prevToCurrent = current;
            current = arr[current].next;
        }
    }
    return false;
}

bool addAfter(Node *arr, int data, int element){
    int current, next, emptyCell;
    if(isFull()){
        cout<<"\nStack is full!";
    } else{
        current = arr[0].next;
        emptyCell = findEmptyCell(arr);
        arr[emptyCell].data = data;
        while (current != 0){
            if(arr[current].data == element){
                next = arr[current].next;
                arr[current].next = emptyCell;
                arr[emptyCell].next = next;
                currentSize++;
                return true;
            }
            current = arr[current].next;
        }
        return false;
    }
}

bool remove(Node *arr, int data){
    int prev = 0, next, current;
    if(isEmpty()){
        cout<<"\nStack is empty!";
    }else{
        current = arr[0].next;
        while(current != 0){
            if(arr[current].data == data){
                next = arr[current].next;
                arr[prev].next = next;
                arr[current].next = -1;
                currentSize--;
                return true;
            }
            prev = current;
            current = arr[current].next;
        }
        return false;
    }
}

void show(Node *arr){
    int current = arr[0].next;
    while(current != 0){
        cout<<"\n arr["<<current<<"] = "<<arr[current].data;
        current = arr[current].next;
    }
}

void addToTheEnd(Node *arr, int data){
    int emptyCell = findEmptyCell(arr);
    if(isEmpty()){
        arr[0].next = emptyCell;
        arr[emptyCell].data = data;
        arr[emptyCell].next = 0;
    } else{
        int current = arr[0].next;
        while (arr[current].next != 0){
            current = arr[current].next;
        }
        arr[emptyCell].data = data;
        arr[current].next = emptyCell;
        arr[emptyCell].next = 0;
    }
    currentSize++;
}

int main(){
    struct Node arr[SIZE + 1];
    arr[0].next = 0;
    int option = 0, element, sub_option, idOfElement;
    while(option != 4){
        cout<<"\n\n\t1.Add an element\n\t2.Remove an element\n\t3.Show all the elements\n\t4.Exit"
              "\n\tEnter your choice: ";
        cin>>option;
        switch (option){
            case 1:
                cout<<"\n\t Sub-option: \n\t 1.Add to the end of the stack\n\t 2.Add before the given element\n\t 3.Add after the given element\n\tEnter your choice: ";
                cin>>sub_option;
                switch (sub_option){
                    case 1:
                        cout<<"\n\t Enter the number you want to add: ";
                        cin>>element;
                        addToTheEnd(arr,element);
                        break;
                    case 2:
                        cout<<"\n\t Enter the value of the element before which you want to add a new element: ";
                        cin>>idOfElement;
                        cout<<"\n\t Enter the number you want to add: ";
                        cin>>element;
                        addBefore(arr,element,idOfElement);
                        break;
                    case 3:
                        cout<<"\n\t Enter the value of the element after which you want to add a new element: ";
                        cin>>idOfElement;
                        cout<<"\n\t Enter the number you want to add: ";
                        cin>>element;
                        addAfter(arr,element,idOfElement);
                        break;
                    default:
                        break;
                }
                break;
            case 2:
                cout<<"\n Enter the element you want to remove: ";
                cin>>element;
                remove(arr,element);
                break;
            case 3:
                show(arr);
                break;
            case 4:
                break;
            default:
                cout<<"\nWrong number!";
                break;
        }
    }
    return 0;
}

