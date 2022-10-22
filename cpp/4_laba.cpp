#include <iostream>
#define SIZE 10
using namespace std;

bool isEmpty(int &currentSize){
    return currentSize == 0;
}

bool isFull(int &currentSize){
    return currentSize == SIZE;
}

void add(int *arr, int &currentSize, int data){
    int i,j;
    if(isFull(currentSize)){
        cout<<"\nStack is full!";
    }
    else{
        if(isEmpty(currentSize)){
            arr[currentSize] = data;
        } else{
            for(i = 0; i < currentSize; i++){
                if(data < arr[i]){
                    break;
                }
            }
            for(j = currentSize + 1; j > i; j--){
                arr[j] = arr[j - 1];
            }
            arr[i] = data;
        }
        currentSize++;
    }
}

int findByValue(const int *arr, int &currentSize, int data){
    for (int i = 0; i < currentSize; i++) {
        if(arr[i] == data){
            return i;
        }
    }
    return -1;
}

void remove(int *arr, int &currentSize, int data){
    if(isEmpty(currentSize)){
        cout<<"\nStack is empty!";
    } else{
        int indexOfElementToRemove = findByValue(arr,currentSize,data);
        if(indexOfElementToRemove == -1){
            cout<<"\nElement not found!";
        } else{
            for(int i = indexOfElementToRemove; i < currentSize - 1; i++){
                arr[i] = arr[i + 1];
            }
            currentSize--;
        }
    }
}

void show(int *arr, int &currentSize){
    for (int i = 0; i < currentSize; i++) {
        cout<<"\n arr["<<i<<"] = "<<arr[i];
    }
}

int main(){
    int arr[SIZE];
    
    int currentSize = 0;
    int option = 0, element;
    while(option != 5){
        cout<<"\n\n\t1.Add an element\n\t2.Remove an element\n\t3.Find index of the element\n\t4.Show all the elements"
              "\n\tEnter your choice: ";
        cin>>option;
        switch (option){
            case 1:
                cout<<"\n Enter the element you want to add: ";
                cin>>element;
                add(arr,currentSize,element);
                break;
            case 2:
                cout<<"\n Enter the element you want to remove: ";
                cin>>element;
                remove(arr,currentSize,element);
                break;
            case 3:
                cout<<"\n Enter the element whose index you want to get: ";
                cin>>element;
                cout<<"\n Index = "<<findByValue(arr,currentSize,element);
                break;
            case 4:
                show(arr,currentSize);
                break;
            default:
                break;
        }
    }
    return 0;
}
