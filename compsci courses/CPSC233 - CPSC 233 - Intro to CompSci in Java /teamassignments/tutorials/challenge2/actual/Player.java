public class Player{

    int id;
    int score;

    public int getId(){
        return id;
    }

    public void setId(int idInput){
        if (idInput>=1000 && idInput<=9999){
            id = idInput;
        }else{
            id=1111;
        }

    }

    public int getScore(){
        return score;
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

    public int getRating(Player[] playerObjs){
        int placing=1; 
        int length = playerObjs.length;
        for (int i = 0; i < length; i++){
            if (playerObjs[i].id == id){
                placing = placing;
            }
            else if (score<playerObjs[i].score){
                placing = placing+1;
            } 

        }
        return placing;

    }
    
}