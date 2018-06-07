//CPSC 331
//Safian Omar Qureshi
//ID 10086638
//Assignment 3 Part 2 

//The following class acts as a model in a MVC type configuration, being the logic behind traversing the maze.


import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Scanner;
import java.util.Set;

public class Graph<T> {

	private List<Pair<T, T>> edges;

	private Set<T> vertices;
	
	private int size;

	public Graph(int size) {
		this.size = size;
		edges = new ArrayList<>();
		vertices = new HashSet<>();
	}

	public void addVertex(T from, T to) {
		Pair<T, T> pair = new Pair<>(from, to);
		edges.add(pair);
		vertices.add(from);
		vertices.add(to);
	}

	private List<T> neighbours(T v) {	
		List<T> neighs = new ArrayList<>();
		for (Pair<T, T> p: edges) {
			if (p.x.equals(v)) {
				neighs.add(p.y);
			} 
		}
		return neighs;
	}
	
	// perform BFS
	public List<T> getShortestPath(T from, T to) {
		List<T> res = new ArrayList<>();
		Map<T, Boolean> visited = new HashMap<>();
		Map<T, T> prev = new HashMap<>(); // stores parent vertex as a value and child as a key
		for (T v: vertices) {
			visited.put(v, false); // until all vertices unvisited
		}
		visited.put(from, true); // visit source vertex
		Queue<T> q = new LinkedList<>();
		q.add(from);
		while (!q.isEmpty()) {
			T cur = q.poll();
			if (cur.equals(to)) {
				break; // if target vertex found
			}
			for (T n: neighbours(cur)) { // loop through the all neighbours
				if (!visited.get(n)) { // if is not visited yet
					q.add(n); // add to the queue
					visited.put(n, true); // visit
					prev.put(n, cur); // add parent (cur) to child (its neighbour)
				}
			}
		}
		for (T next = to; next != null; next = prev.get(next)) { // iterate through the parent-child vertices starting
			// from target
			res.add(next);
		}
		Collections.reverse(res); // optional, just to have source vertex at the first place
		return res;
	}

	public static void main(String...args) throws FileNotFoundException {
		Graph<Integer> g = null;
		try (Scanner sc = new Scanner(new File("maze.txt"))) { 
			while (sc.hasNextLine()) {
				String line  = sc.nextLine().trim();
				String items[] = line.split("\t");
				if (items.length > 1) {
					int from = Integer.parseInt(items[0]);
					int to = Integer.parseInt(items[1]);
					g.addVertex(from, to);
				} else {
					g = new Graph<>(Integer.parseInt(items[0]));
				}
			}
		}
		System.out.println(g.getShortestPath(1, 12));
	}

	public List<Pair<T, T>> getEdges() {
		return new ArrayList<>(edges); // make a copy to keep encapsulation
	}

	public int getSize() {
		return size;
	}
}
