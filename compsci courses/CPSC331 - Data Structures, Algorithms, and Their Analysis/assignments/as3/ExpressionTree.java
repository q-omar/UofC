//CPSC 331
//Safian Omar Qureshi
//ID 10086638
//Assignment 3 Part 2

//The following class builds parses an expression and builds parse free to returns post/pre fix representations 
//website used for help: http://cogitolearning.co.uk/2013/05/writing-a-parser-in-java-the-expression-tree/



import java.text.ParseException;

public class ExpressionTree {

    private ExpTreeNode root = null;

    
    //constructor to build an empty parse tree.
     

    public ExpressionTree() {
    }

    /**
     * Build a parse tree from an expression.
     * @param line String containing the expression
     * @throws ParseException If an error occurs during parsing.
     * The location of the error is included in the thrown exception.
     */
    public void parse(String line) throws ParseException {
        ExpParser parser = new ExpParser();
        root = parser.parse(line);
    }

  
    //evaluate the expression tree and return the integer result. An empty tree returns 0.
    public int evaluate() {
        if (root == null) {
            return 0;
        }
        return root.evaluate();
    }

    
    //returns a postfix representation of the expression. Tokens are separated by
    //whitespace. An empty tree returns a zero length string.
    
    public String postfix() {
        if (root == null) {
            return "";
        }
        return root.postfix();
    }

   
    //returns a prefix representation of the expression. Tokens are separated by
    //whitespace. An empty tree returns a zero length string.
    
    public String prefix() {
        if (root == null) {
            return "";
        }
        return root.prefix();
    }


    
    //inner parser class

    private class ExpParser {

        private Lexer lexer;

        /**
         * parses the given line to the tree of nodes
         *
         * @param line to be parsed
         * @return root node
         * @throws ParseException if invalid line
         */
        ExpTreeNode parse(String line) throws ParseException {
            lexer = new Lexer(line);
            ExpTreeNode result = parseE();
            if (lexer.token == Lexer.RIGHT_PARENTHESIS) {
                throw new ParseException("Right parenthesis without left", lexer.counter - 1);
            }
            if (!lexer.line.trim().equals("")) {
                throw new ParseException("Invalid expression", lexer.counter);
            }
            return result;
        }

        
        //E --> T { ( "+" | "-" ) T}
        
        private ExpTreeNode parseE() throws ParseException {
            ExpTreeNode result = parseT();
            while (lexer.token == Lexer.PLUS || lexer.token == Lexer.MINUS) {
                int operation = lexer.token;
                lexer.getToken();
                if (operation == Lexer.PLUS) {
                    result = new ExpTreeNode("+", result, parseT());
                } else {
                    result = new ExpTreeNode("-", result, parseT());
                }
            }
            return result;
        }

        
        //T --> F { ( "*" | "/" ) F}
        
        private ExpTreeNode parseT() throws ParseException {
            ExpTreeNode result = parseF();
            while (lexer.token == Lexer.TIMES || lexer.token == Lexer.DIVIDE) {
                int operation = lexer.token;
                lexer.getToken();
                if (operation == Lexer.TIMES) {
                    result = new ExpTreeNode("*", result, parseF());
                } else {
                    result = new ExpTreeNode("/", result, parseF());
                }
            }
            return result;
        }

        
        //F --> num | "(" E ")"
        
        private ExpTreeNode parseF() throws ParseException {
            ExpTreeNode result;
            switch (lexer.token) {
                case Lexer.NUMBER:
                    result = new ExpTreeNode(String.valueOf(lexer.numberValue));
                    lexer.getToken();
                    break;
                case Lexer.LEFT_PARENTHESIS:
                    lexer.getToken();
                    result = parseE();
                    if (lexer.token != Lexer.RIGHT_PARENTHESIS) {
                        throw new ParseException("right parenthesis expected", lexer.counter);
                    }
                    lexer.getToken();
                    break;
                default:
                    throw new ParseException("invalid operand", lexer.counter);
            }
            return result;
        }

        // inner class
        private class Lexer {
            // codes
            private static final int PLUS = 1;
            private static final int MINUS = 2;
            private static final int TIMES = 3;
            private static final int DIVIDE = 4;
            private static final int LEFT_PARENTHESIS = 5;
            private static final int RIGHT_PARENTHESIS = 6;
            private static final int ERROR = 7;
            private static final int NUMBER = 8;

            private int token;
            private int numberValue;
            private String line;
            private int counter = 1;

            private Lexer(String line) {
                this.line = line;
                getToken();
            }

            
            //get first token from the line
            
            private void getToken() {
                if (line.length() == 0) {
                    token = ERROR;
                    return;
                }
                switch (line.charAt(0)) {
                    case '+':
                        token = PLUS;
                        updateLine();
                        break;
                    case '-':
                        token = MINUS;
                        updateLine();
                        break;
                    case '*':
                        token = TIMES;
                        updateLine();
                        break;
                    case '/':
                        token = DIVIDE;
                        updateLine();
                        break;
                    case '(':
                        token = LEFT_PARENTHESIS;
                        updateLine();
                        break;
                    case ')':
                        token = RIGHT_PARENTHESIS;
                        updateLine();
                        break;
                    default:
                        // it should be number
                        if (Character.isDigit(line.charAt(0))) {
                            token = NUMBER;
                            numberValue = Character.getNumericValue(line.charAt(0));
                            updateLine();
                            while (line.length() > 0 && Character.isDigit(line.charAt(0))) {
                                numberValue = numberValue * 10 + Character.getNumericValue(line.charAt(0));
                                updateLine();
                            }
                        } else {
                            token = ERROR;
                        }
                }
            }

            
            //update the line and increment the token counter
            
            private void updateLine() {
                line = line.substring(1).trim();
                counter++;
            }
        }
    }

}
