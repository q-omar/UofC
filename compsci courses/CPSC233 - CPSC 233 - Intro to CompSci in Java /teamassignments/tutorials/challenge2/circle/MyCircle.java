public class MyCircle{
    int xCoord;
    int yCoord;
    int radius;

    public int getX(){
        return xCoord;
    }
    
    
    public int getY(){
        return yCoord;
    }
    
    
    public int getRadius(){
        return radius;
    }
    
    public void setX(int inputSetX){
        xCoord = inputSetX;

    }
    
    
    public void setY(int inputSetY){
        yCoord = inputSetY;
        
    }
    
    
    public void setRadius(int inputSetRadius){
        if (inputSetRadius>0){
            radius = inputSetRadius;
        } else{
            radius=0;
        }
    
    }
    
    public String checkQuadrant(){
        String location;
        
        if (xCoord>0 && yCoord>0){
            location= "Quadrant1";
            
        } else if (xCoord<0 && yCoord>0){
            location = "Quadrant2";
         
        } else if (xCoord<0 && yCoord<0){
            location = "Quadrant3";
           
        } else if (xCoord>0 && yCoord<0) {
            location = "Quadrant4";
        } else {
            location = "Origin";
        }
        return location;
    }

    public int biggestRadius(int circumference){
        if (circumference>0){
            int maxRadius = circumference/(2*3);
            int remainder = maxRadius % 1;
            maxRadius = maxRadius - remainder;
            return maxRadius;
        }else{
            int maxRadius=0;
            return maxRadius;
        }
    
    }
    
    
}