public class Point{
    private int xcoord;
    private int ycoord;

    public Point(){}
    
    public Point(Point pointCopy){
        xcoord = pointCopy.xcoord;
        ycoord = pointCopy.ycoord;
    }

    public Point(int setXcoord, int setYcoord){
        if (setXcoord>=0){
            xcoord = setXcoord;
        }
        if (setYcoord>=0){
            ycoord = setYcoord;
        }
    }

    public int getXCoord(){
        return xcoord;
    }
    
    public int getYCoord(){
        return ycoord;
    }

    public void setXCoord(int setXcoord){
        if (setXcoord>=0){
            xcoord = setXcoord;
        }
    }
    public void setYCoord(int setYcoord){
        if (setYcoord>=0){
            ycoord = setYcoord;
        }
    }

    public void moveDown(int moveYdown){
        if (moveYdown>=0){
            ycoord+=moveYdown;
        }
    }
    public void moveUp(int moveYup){
        if (moveYup>=0){
            ycoord-=moveYup;
        }
    }
    public void moveLeft(int moveXleft){
        if (moveXleft>=0){
            xcoord-=moveXleft;
        }
    }
    public void moveRight(int moveXright){
        if (moveXright>=0){
            xcoord+=moveXright;
        }
    }
    
    public double distance(Point distancePoint){
        double componentX = (distancePoint.getXCoord() - xcoord);
        componentX = componentX*componentX;
        double componentY = (distancePoint.getYCoord() - ycoord);
        componentY = componentY*componentY;
        double distance = Math.sqrt(componentX + componentY);
        return distance;
    }

    public boolean equals(Point checkSamePoint){
        boolean check = false;
        if (xcoord==checkSamePoint.getXCoord() && ycoord == checkSamePoint.getYCoord()){
            check = true;
        }
        return check;
    }

}