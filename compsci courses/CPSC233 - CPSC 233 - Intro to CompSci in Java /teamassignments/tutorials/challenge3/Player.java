import java.util.ArrayList;

public class Player{
    private int id;
    private int score;

    public Player(int anID, int aScore){
        id = anID;
        if (anID>9999 | anID<=0){
            id = 1111;
        }
        score = aScore;
    }
    

    public Player(Player playerCopy){
        
        id = playerCopy.getId();
        score = playerCopy.getScore();
    }

    public int getId(){
        return id;
    }
    
    public int getScore(){
        if (score<0){
            score = 0;
        }
        return score;
    }

    public void setId(int idInput){
        id = idInput;
        if (id>9999 | id<=0){
            id = 1111;
        }
        
    }

    public void updateScore(int addScore){
        if (addScore>0){
            score = score + addScore;
        }
    }

    public String getLevel(){
        String playerLevel;
        if (score>=0 && score<=10){
            playerLevel = "beginner";
        }else if (score>=11 && score<=100){
            playerLevel = "intermediate";
        } else{
            playerLevel = "expert";
        }
        
        return playerLevel;
    }

    
}