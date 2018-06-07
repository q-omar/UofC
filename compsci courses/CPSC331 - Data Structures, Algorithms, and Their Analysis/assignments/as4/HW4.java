//CPSC 331
//Safian Omar Qureshi
//ID 10086638
//Assignment 3 Part 2 

//The following class acts as a controller class in the MVC scheme, being an intermediate between the model logic and view

import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import javax.swing.JFrame;

public class HW4 {

	public static void main(String[] args) {

		if (args.length < 2) {
			System.out.println("Usage: <maze-file> <query-file>");
			return;
		}
		Graph<Integer> g = null;
		try (Scanner sc = new Scanner(new File(args[0]))) {

			while (sc.hasNextLine()) {
				String line  = sc.nextLine().trim().replaceAll("\\s+", " ");
				if (line.length() == 0) {
					continue;
				}
				String items[] = line.split(" ");
				if (items.length > 1) {
					int from = Integer.parseInt(items[0]);
					int to = Integer.parseInt(items[1]);
					g.addVertex(from, to);
				} else {
					g = new Graph<>(Integer.parseInt(items[0]));
				}
			}
			List<Pair<Integer, Integer>> queries = new ArrayList<>();
			try (Scanner sc2 = new Scanner(new File(args[1]))) { // read query
				while (sc2.hasNextLine()) {
					String line  = sc2.nextLine().trim().replaceAll("\\s+", " ");
					if (line.length() == 0) {
						continue;
					}
					String items[] = line.split(" ");
					
					int source = Integer.parseInt(items[0]);
					int target = Integer.parseInt(items[1]);
					queries.add(new Pair<>(source, target)); // collect queries as from-to values encapsulated
					// in Pair object.
				}
			}
			runVisualizer(g, queries);
		} catch (Exception e) {
			System.out.println("Exception occurred: " + e);
			e.printStackTrace();
		}

	}

	//displaying output onto visualizer class
	public static void runVisualizer(Graph<Integer> g, List<Pair<Integer, Integer>> queries) {
		JFrame f = new JFrame("MazeVisualizer");
		f.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {System.exit(0);}
		});
		MazeVisualizer applet = new MazeVisualizer(g.getSize());

		for (Pair<Integer, Integer> p: g.getEdges()) {
			applet.addEdge(p.x, p.y);
		}

		for (Pair<Integer, Integer> p: queries) {
			List<Integer> path = g.getShortestPath(p.x, p.y);
			if (path.size() < 2 ) {
				System.out.println(p.x + " NO PATH " + p.y);
			} else {
				applet.addPath(g.getShortestPath(p.x, p.y));
				System.out.println(path.toString().replaceAll("[\\[\\],]", ""));
			}
		}

		f.getContentPane().add("Center", applet);
		applet.init();
		f.pack();
		f.setBackground(Color.WHITE);
		f.setSize(new Dimension(512,512));
		f.setVisible(true);
	}

}
