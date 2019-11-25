/**********************************************
 * Last Name:   Qureshi
 * First Name:  Safian
 * Student ID:  10086638
 * Course:      CPSC 457
 * Tutorial:    T02
 * Assignment:  3
 * Question:    Q6
 *
 * File name: deadlock.cpp
 *********************************************/

#include <iostream>
#include <fstream>
#include <sstream> 
#include <list> 
#include <limits.h> 
#include <algorithm>
#include <vector>

//NOTICE: I tried to create mock inputs for myself for safety reasons I used bigger
//numbers than necessary. It should be okay like this, but if you want it to go faster, 
//remove a zero from each of these constants to speed up (but not necessary I believe)
#define MILLION 10000000
#define HUNDRED 1000000
#define TEN 100000

std::vector <int> deadlockedPs; //array and index for deadlocked processes
int deadlockedI=0;		 

/**
 * Resource used: https://www.geeksforgeeks.org/detect-cycle-in-a-graph/, lines 15 - 122
 * I relied heavily on understanding the above code and implementing for my case by modifying greater functionality
 **/
class Graph 
	{ 
		int V;    // No. of vertices 
		std::list<int> *adj;    // Pointer to an array containing adjacency lists 
	
		bool isCyclicUtil(int v, bool visited[], bool *rs);  // used by isCyclic() 
	public: 
		Graph(int V);   // Constructor 
		void addVertex(int x); //to add vertex to graph
		void addEdge(int v, int w);   // to add an edge to graph
		int getVertex(); 
		bool isCyclic();    // returns true if there is a cycle in this graph 
        void clear();
	}; 

	
	Graph::Graph(int V) 
	{ 
		this->V = V; 
		adj = new std::list<int>[MILLION];
	} 

  
	void Graph::addEdge(int v, int w) 
	{	 
		adj[v].push_back(w); // Add w to v’s list. 
	} 

	
	void Graph::addVertex(int x) 
	{	 
		this->V=x; //used for renaming resources by adding a certain big constant
				   
	} 


	int Graph::getVertex() 
	{	 
		return this->V;
	} 


	void Graph::clear()//used for clearing deadlock array for new graph
    {
        deadlockedPs.clear();
        int i = 0;
        while(i<TEN)
        {
            deadlockedPs.push_back(HUNDRED);
            i++;
        }
    }


// This function is a variation of DFSUtil() in https://www.geeksforgeeks.org/archives/18212 
    bool Graph::isCyclicUtil(int v, bool visited[], bool *recStack) 
    { 
        if(visited[v] == false) 
        { 
            // Mark the current node as visited and part of recursion stack 
            visited[v] = true; 
            recStack[v] = true; 
    
            // Recur for all the vertices adjacent to this vertex 
            std::list<int>::iterator i; 
            for(i = adj[v].begin(); i != adj[v].end(); ++i) 
            { 
                if ( !visited[*i] && isCyclicUtil(*i, visited, recStack) ) {
                    deadlockedPs[deadlockedI]=*i;
                    deadlockedI++;
                    return true; 
                }
                else if (recStack[*i]) {
                    deadlockedPs[deadlockedI]=*i;
                    deadlockedI++;
                    return true; 
                }
            } 
    
        } 
        recStack[v] = false;  // remove the vertex from recursion stack 
        return false; 
    } 
    

    // Returns true if the graph contains a cycle, else false. 
    // This function is a variation of DFS() in https://www.geeksforgeeks.org/archives/18212 
    bool Graph::isCyclic() 
    { 
        // Mark all the vertices as not visited and not part of recursion 
        // stack 
        bool *visited = new bool[V]; 
        bool *recStack = new bool[V]; 
        for(int i = 0; i < V; i++) 
        { 
            visited[i] = false; 
            recStack[i] = false; 
        } 
    
        // Call the recursive helper function to detect cycle in different 
        // DFS trees 
        for(int i = 0; i < V; i++) 
            if (isCyclicUtil(i, visited, recStack)) 
                return true; 
    
        return false; 
    } 


Graph convertAddEdge(std::string line, Graph g)
{
    std::istringstream linestream;
    linestream.str(line);
    int v1, v2;
    std::string sign;
    linestream >> v1 >> sign >> v2; 
    v2 = v2 + HUNDRED;

    if (v2 > g.getVertex()){
        g.addVertex(v2);
    }

    if(sign == "->")
    {
        g.addEdge(v1, v2);
    }
    
    else if(sign == "<-")
    {
        g.addEdge(v2, v1);
    }
    return g;
}


void computeDisplay(Graph g)
{
    if(g.isCyclic()) {
						
        printf("Deadlocked processes: "); 
        std::sort(std::begin(deadlockedPs), std::end(deadlockedPs)); 
        int i = 0;
        while(i < TEN)
        {
            if(deadlockedPs[i]<HUNDRED)
            {
                printf("%d ", deadlockedPs[i]);
            }
            i++;
        }
        printf("\n");		
       
    }
    else{
        printf("Deadlocked processes: none \n");
        
    }
}


/** by Dr. Pavol
 * Structure:
 * MAIN loop:
    set graph to empty
    INNER loop:
        read line from stdin
        if line starts with ‘#’, or EOF reached:
            compute, sort and display deadlocked processes from graph
			break 
		else:
            convert line to an edge
            add edge to graph
    if EOF was encountered:
		break
**/
int main(int argc, char * const argv[]){
	
	std::fstream file;  
	char* fileName; 
	if (argc < 2)
    {
        printf("Invalid number of arguments, use: ./deadlock <input.txt>\n");
        return 0;
    }
    else
    {
        fileName = argv[1];
    }
    file.open(fileName);
	
    //MAIN loop
	while(1)
    {
		Graph g(0);	//initialize empty graph, clear previous deadlock array if any
        g.clear();
		
        //INNER loop
        while(1)
        {
			std::string line;
			std::getline(file, line);//read in line, check if end or # founds						
				if(line.find("#") == 0 || file.eof() )
                {
					computeDisplay(g);
                    break;
					 
				}
				else
                { //otherwise add edge
					g = convertAddEdge(line, g);
				}	
		}
        if (file.eof())
        {
            file.close();
            break;
        }
    }
	return 0;
}