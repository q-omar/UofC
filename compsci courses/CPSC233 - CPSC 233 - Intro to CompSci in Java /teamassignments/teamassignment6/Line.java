public class Line{
    private Point start;
    private Point end;

    public Line(Point start, Point end){
        this.start = new Point(start);
        this.end = new Point(end);
    }

    public Line(Line lineToCopy){
        this.start = lineToCopy.start;
        this.end = lineToCopy.end;
    }

    public Point getStart(){
        return new Point(start);
    }

    public Point getEnd(){
        return new Point(end);
    }

    public void setStart(Point startPoint){
        start = new Point(startPoint);
    }

    public void setEnd(Point endPoint){
        end = new Point(endPoint);
    }
    public double length(){
        start = new Point(start);
        end = new Point(end);
        double componentx = start.getXCoord() - end.getXCoord();
        componentx = componentx*componentx;
        double componenty = start.getYCoord() - end.getYCoord();
        componenty = componenty*componenty;
        double length = Math.sqrt(componentx+componenty);
        return length;
    }
}