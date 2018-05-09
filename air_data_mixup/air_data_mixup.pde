//code based on: 
//Danial Shiffman's processing tutorials https://www.youtube.com/watch?v=PjxbuSnj8Pk
//Sparkfun's tutorial https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing
//Tom Igoe's Serial call response http://www.arduino.cc/en/Tutorial/SerialCallResponse


//TO DO 
// 1 join month and date
// get ellipse in a row with a small set of data


// file stuff
String file= "simple_data1.csv"; // your file name here
String [] rawData;
String[] splitData;

//data stuff
String[] mon_id;
int[] dateYear;
float[] dateMonth_Day;
float[] noX;
float[] no2;
float[] nO;
float[] lonG;
float[] laT;

// doing the data vis STUFF
float[] xPos, newWidth, newHeight;
int yPos = height/2;


void setup() {
  textAlign(CENTER);
  size(600, 600);
  noStroke();
  background(0);

  processData();
} // end of SETUP

void draw() {

  background(0);
} // end of DRAW

// P R O C E S S    D A T A 
//HEADERS: monitor_id; monitor_description; date;      time;                     nox; no; no2; lat;     long;  location; year; month; day; hour; minute; day_of_week
//DATA EXAMPLE: 3;     Brislington;        2017-05-04; 0001-01-01T16:13:45-00:01; 68; 33; 34;  51.4417; -2.56;  51.4417

void processData() {

  //bring in csv file through strings
  rawData = loadStrings(file);
  printArray(rawData);
// need to do this properly so that you have a month . day 
// then eventually make it more to scale through makeing it fit into a range i.e., 
// converting 12 month into range of 100 and each dat in month into range in that. or somthing 

  String [] dataMonth_Day_String = join(rawData[11], rawData[12]);

    mon_id = new String[rawData.length];
  dateYear = new int[rawData.length];
  dateMonth_Day = new float[rawData.length];
  noX = new float[rawData.length];
  no2 = new float[rawData.length];
  nO = new float[rawData.length];
  lonG = new float[rawData.length];
  laT = new float[rawData.length];


  // in string format join dateMonth and dateYear so that they are 01.04 for 4th Jan


  // now use a loop to make strings into ints
  for (int i = 0; i <rawData.length; i++) {
    String [] splitData = split(rawData[i], ";"); //break into pieces using comma as delimiter
    printArray(splitData);

    // label and sort the data
    mon_id[i] = splitData[1]; 
    dateYear [i] = int(splitData[2]);  
    dateMonth [i] = int(splitData[11]);
    dateDay [i] = int(splitData[12]);
    noX [i] = float(splitData[4]); 
    no2 [i] = float(splitData[5]); 
    nO[i] = float(splitData[6]); 
    lonG [i] = float(splitData[7]); 
    laT [i] = float(splitData[8]); 


    // printArray(date);
  }
}// end of processData

// D R A W    A    L O A D    O F   S H A P E S 

//    mon_id[i] = splitData[1]; 
//    dateYear [i] = int(splitData[2]);  
//    dateMonth [i] = int(splitData[11]);
//    dateDay [i] = int(splitData[12]);
//    noX [i] = float(splitData[4]); 
//    no2 [i] = float(splitData[5]); 
//    nO[i] = float(splitData[6]); 
//    lonG [i] = float(splitData[7]); 
//    laT [i] = float(splitData[8]); 
//
//void dataDraw() {
//  xPos[] = dataY[];
//  newWidth[] =  noX[];
//  newHeight[] = noX[];
//
//  //  date format = month.day
//
//  for (int i = 0; i <data.length; i++) {
//    ellipse(xPos[i], yPos, newWidth[i], newheight[i])
//    }
//  } // end of dataDraw

