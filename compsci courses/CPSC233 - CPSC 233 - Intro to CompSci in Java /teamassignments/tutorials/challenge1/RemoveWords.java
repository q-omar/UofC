import java.io.*;

public class RemoveWords{

    public static int removeFirstWord (String inputFile, String outputFile){
       
        try{        
            BufferedReader reader = new BufferedReader(new FileReader(inputFile));
            String line = reader.readLine();
            try{
             if (line==null){
                 reader.close();
                throw new EmptyFileException();
             }
            } catch (EmptyFileException e){
                System.out.print("Empty file");
                return 0;
            }

            String[] info = line.split(" ", 2);
            BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile));

            while (line != null) {
                try {
                    info = line.split(" ", 2);
                    info[0] = "";
                    try {
                        writer.write(info[1]+System.lineSeparator());
                    } catch (ArrayIndexOutOfBoundsException a){
                        writer.write(""+System.lineSeparator());
                    }
                } catch (NullPointerException npe){}
                line = reader.readLine();
                
            
            }
            reader.close();
            writer.close();
            
            } catch (IOException ioe) {
            System.out.print("file not found");
            return -1;
            }
        return 0;  
    
    }

    public static void usingDataOutputStream() throws IOException {
		DataOutputStream out = new DataOutputStream(new FileOutputStream("numbers.bin"));
		out.writeInt(10);
		for (int counter = 0; counter < 10; counter++){
			
			out.writeInt(counter);
		}
		out.close();
		
	}
            
        
    public static int sumNumbers(String fileIn) throws IOException{
        int sum=0;
        try{    
            DataInputStream in = new DataInputStream(new FileInputStream(fileIn));
            for (int counter = 0; counter < 12; counter++){
                // write counter to writer on it's own line.
                int num = in.readInt();
                sum = sum + num;
                System.out.println(num);
            }
            in.close();
        } catch (IOException ioe){
            System.out.println("error, 0 sum");
            return 0;
        }
        System.out.println("Sum: "+sum);
        return sum;
		
	}

    public static void main(String[] args) throws IOException {
        removeFirstWord("sometext.txt","output.txt");
        usingDataOutputStream();
        sumNumbers("numbers.bin");
    }
}