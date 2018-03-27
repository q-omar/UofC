
//CPSC 331
//Safian Omar Qureshi
//ID 10086638
//Assignment 3 Part 2 

//The following class represents a node in a binary expression tree.
//website used for help: http://cogitolearning.co.uk/2013/05/writing-a-parser-in-java-the-expression-tree/

public class ExpTreeNode {
    String element;

    ExpTreeNode left, right;

    ExpTreeNode(String e) {
        this(e, null, null);
    }

    ExpTreeNode(String e, ExpTreeNode l, ExpTreeNode r) {
        element = new String(e);
        left = l;
        right = r;
    }

    
     //Returns a postfix representation of the node. Tokens are separated by
     //whitespace. An empty node returns a zero length string.
     
    public String postfix() {
        String leftPostfix = "";
        String rightPostfix = "";
        if (left != null) {
            leftPostfix = left.postfix();
        }
        if (right != null) {
            rightPostfix = right.postfix();
        }
        if (!leftPostfix.equals("")) {
            leftPostfix += " ";
        }
        if (!rightPostfix.equals("")) {
            rightPostfix += " ";
        }
        return leftPostfix + rightPostfix + element;
    }

    
     //Returns a prefix representation of the node. Tokens are separated by
     //whitespace. An empty node returns a zero length string.
     
    public String prefix() {
        String leftPrefix = "";
        String rightPrefix = "";
        if (left != null) {
            leftPrefix = left.prefix();
        }
        if (right != null) {
            rightPrefix = right.prefix();
        }
        if (!leftPrefix.equals("")) {
            leftPrefix = " " + leftPrefix;
        }
        if (!rightPrefix.equals("")) {
            rightPrefix = " " + rightPrefix;
        }
        return element + leftPrefix + rightPrefix;
    }


     //Evaluate the node and return the integer result. An
     //empty node returns 0.
    public int evaluate() {
        // leaf
        if (left == null && right == null) {
            return Integer.parseInt(element);
        }
        int leftValue = left != null ? left.evaluate() : 0;
        int rightValue = right != null ? right.evaluate() : 0;
        switch (element) {
            case "+":
                return leftValue + rightValue;
            case "-":
                return leftValue - rightValue;
            case "*":
                return leftValue * rightValue;
            case "/":
                return leftValue / rightValue;
        }
        return 0;
    }
}
