#include <iostream>

using namespace std;

struct Node{
    Node* neighbor;
    Node* next;
    Node() : neighbor(nullptr), next(nullptr) {}
    Node(int neigh) : neighbor(new Node(neigh)), next(nullptr) {}
};

int visited[10001] = {0};
Node graph[10001];
int tcost = 0;

void destroyGraph(Node* head)
{
    Node* ptr, *nextPtr;
    for(int i = 0; i <= 10000; ++i)
    {
        if(head[i].next != nullptr)
        {
            ptr = head[i].next;
            while(ptr != nullptr)
            {
                nextPtr = ptr->next;
                delete ptr;
                ptr = nextPtr;
            }
        }
    }
}

void connectg(Node* graph, int src, int dest)
{
    if(graph[src].neighbor == nullptr)
    {
        graph[src].neighbor = &graph[dest];
        return;
    }
    Node* ptr = &graph[src];
    while(ptr->next != nullptr)ptr = ptr->next;
    ptr->next = new Node(dest);
    ptr = ptr->next;
    ptr->neighbor = &graph[dest];
}

void dfs(Node* node)
{
    int nodeNum = node - &graph[0];
    visited[nodeNum] = 1;
    Node* nptr = node;
    while(nptr != nullptr)
    {
        nodeNum = nptr->neighbor - &graph[0];
        if(visited[nodeNum] == 0)
        {
            ++tcost;
            dfs(nptr->neighbor);
            ++tcost;
        }
        nptr = nptr->next;
    }
}

int main(int argc, char* argv[])
{
    visited[0] = 1;
    int numEdge, src, dest;
    cin >> numEdge;
    for(int i = 0; i < numEdge; ++i)
    {
        cin >> src >> dest;
        connectg(graph, src, dest);
    }
    dfs(&graph[1]);
    cout << tcost << endl;
    return 0;
}