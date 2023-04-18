#include <iostream>

using namespace std;

struct TreeNode{
    int data;
    TreeNode *left;
    TreeNode *right;
};

struct StackNode{
    StackNode *next;
    TreeNode *treeNode;
    int level;
};

int generate_int()
{
    return rand() % 100 + 1;
}

StackNode* getSp(){
        return sp;
}
 void addItem(TreeNode *treeNode, int level) {
        auto* pTemp = new StackNode();
        pTemp->level = level;
        pTemp -> treeNode = treeNode;
        pTemp -> next = this -> sp;
        this -> sp = pTemp;
        this -> size++;
    }
    int get_size(){
        return size;
}

void showAll() {
        StackNode *current = sp;
        cout << "\n----------------\nUp of stack\n\n";
        while (current != nullptr)
        {
            cout << current -> treeNode -> data << endl;
            current = current -> next;
        }
        cout << "\nDown of stack\n----------------\n";
    }
void removeTop() {
        StackNode* pTemp = sp;
        sp = sp -> next;
        delete pTemp;
        this -> size--;
    }

 void addStackNode(StackNode* new_Stacknode){
        new_Stacknode -> next = this -> sp;
        this -> sp = new_Stacknode;
        this -> size++;
    }
StackNode* getTopPtr(){
        StackNode* pTemp = sp;
        return pTemp;
    }
bool isEmpty(StackNode sp) {
        return sp == nullptr;
}
void add_TreeNodes(TreeNode **pCurrent, int n_vertices){
        int nl, nr;
        TreeNode *pTemp;
        if (n_vertices == 0)
        {
            *pCurrent = nullptr;
        }
        else
        {
            nl = n_vertices / 2;
            nr = n_vertices - nl - 1;
            pTemp = new TreeNode();
            pTemp->data = generate_int();
            add_TreeNodes(&(pTemp->left), nl);
            add_TreeNodes(&(pTemp->right), nr);
            *pCurrent = pTemp;
        }
}

void forward(TreeNode *pCurrent, int level)
    {
        if (pCurrent != NULL)
        {
            for (int i = 0; i < level*5; i++)
                cout << " ";
            level++;
            cout << pCurrent->data << endl;
            forward(pCurrent->left, level);
            forward(pCurrent->right, level);
        }
}

void symmetric(TreeNode *pRoot)
    {
        TreeNode *pCurrent = pRoot;
        int level = -1;
        bool stop = false;
        while (!stop)
        {
            while (pCurrent != nullptr)
            {
                stack->addItem(pCurrent, ++level);
                pCurrent = pCurrent->left;
            }

            if (stack->isEmpty())
                stop = true;
            else
            {
                for (int i = 0; i < stack->getTopPtr()->level*5 ; i++)
                    cout << " ";
                pCurrent = stack->getTopPtr()->treeNode;
                cout << pCurrent->data << endl;
                level = stack->getTopPtr()->level;
                pCurrent = pCurrent->right;
                stack->removeTop();
            }
        }
}

void backward_symmetric(TreeNode *pCurrent, int level)
    {
        if (pCurrent != nullptr)
        {
            backward_symmetric(pCurrent->right, level+1);
            for (int i = 0; i < level*5; i++)
                cout << " ";
            cout << pCurrent->data << endl;
            backward_symmetric(pCurrent->left, level+1);
        }
}
    


int main(){
    int n_vertices;
    int size = -1;
    StackNode* sp = nullptr;
    TreeNode *pRoot = new TreeNode();
    cout << "Enter the number of tree vertexes: ";
    cin >> n_vertices;
    cout << "\nDirect order" << endl;
    cout << "-----------------------\n";
    forward(pRoot, 0);
    cout << "-----------------------\n\n";

    cout << "\nSymmetrical order" << endl;
    cout << "-----------------------\n";
    symmetric();
    cout << "-----------------------\n\n";

    cout << "\nReverse symmetric order" << endl;
    cout << "-----------------------\n";
    backward_symmetric(pRoot,pRoot, 0);
    cout << "-----------------------\n\n";
    getchar();
    return 0;
}