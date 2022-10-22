#include <iostream>
#define SIZE 10
using namespace std;

bool fullArry(int size){
    return size == SIZE;
}

bool emptyArry(int size){
    return size==0;
}

void insertArry(int *arr,int index,int &size,int element){
    int i;
    if(fullArry(size)){
        cout<<"arry is full\n";
    }else{
        if(emptyArry(size)){
            arr[size]=element;
        }else{
           for(i=size+1;i>index;i--){
            arr[i]=arr[i-1];
        }
        arr[index]=element;
        }
         size++;  
    }
}

int findElement(int *arr,int element,int size){
    if (emptyArry(size))
    {
       cout<<"arry is empty\n";
    }else{
        for (size_t i = 0; i < size; i++)
        {
            if(arr[i]== element)
                return i;
        }
        
    }
    return -1;
    
}

void deleteArry(int *arr ,int &size,int element){
    int i;
    if(emptyArry(size)){
         cout<<"arry is empty\n";
    }else{
        int indexElement = findElement(arr,element,size);
        for(i=indexElement;i<size;i++){
            arr[i]=arr[i+1];
        }
        size--;
    }
}






int main(){
    int arr[SIZE];
    int size = 0;
   
    insertArry(arr,0,size,1);
    insertArry(arr,1,size,2);
    insertArry(arr,2,size,3);
    insertArry(arr,3,size,4);
    insertArry(arr,4,size,5);
    deleteArry(arr,size,5);

    
    for(int i=0;i<size;i++)
        cout<<arr[i]<<"\n";
    return 0;
}
