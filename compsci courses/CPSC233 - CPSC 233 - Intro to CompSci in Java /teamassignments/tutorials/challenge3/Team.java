import java.util.ArrayList;

public class Team{
    private String name;
    private ArrayList<Player> playerList = new ArrayList<Player>();

    public Team(String aName){
        name = aName; 
        playerList = new ArrayList<Player>(playerList);
        
    }

    public String getName(){
        return name;
    }

    public ArrayList<Player> getPlayerList(){
        playerList = new ArrayList<Player>(playerList);
        return playerList;
    }

    public void addPlayer(Player aPlayer){
        playerList = new ArrayList<Player>(playerList);
        playerList.add(aPlayer);
    }

    public Player getPlayerWithHighestScore(){
        int length = playerList.size();
        Player maxPlayer = new Player(0,0);
        int maxScore=0;
        for (int i = 0; i < length; i++){
            if (playerList.get(i).getScore()>maxScore){
                maxScore = playerList.get(i).getScore();;
                maxPlayer = playerList.get(i);
            }
        }
        
        return maxPlayer;
    }
    
}
