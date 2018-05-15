//code based on: 
//Danial Shiffman's processing tutorials https://www.youtube.com/watch?v=PjxbuSnj8Pk
//Sparkfun's tutorial https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing
//Tom Igoe's Serial call response http://www.arduino.cc/en/Tutorial/SerialCallResponse


//TO DO 
// 1 join month and date
// get ellipse in a row with a small set of data


// file stuff
String file= "2017_jan.csv"; // your file name here
String [] rawData;
String[] splitData;

//data stuff
String[] mon_id;
String[] date;
float[] noX;
float[] no2;
float[] nO;
float[] lonG;
float[] laT;

// doing the data vis STUFF
float xPos, yRange;



void setup() {
  textAlign(CENTER);
  size(600, 600);
  noStroke();
  background(0);
  shapeMode(CENTER);
  colorMode(HSB, height, height, height);  

  processData();
  printArray(date);
} // end of SETUP

void draw() {

  background(0);
  dataDraw();
} // end of DRAW

// P R O C E S S    D A T A 
//HEADERS: monitor_id; monitor_description; date;      time;                     nox; no; no2; lat;     long;  location; year; month; day; hour; minute; day_of_week
//DATA EXAMPLE: 3;     Brislington;        2017-05-04; 0001-01-01T16:13:45-00:01; 68; 33; 34;  51.4417; -2.56;  51.4417

void processData() {

  //bring in csv file through strings
  rawData = loadStrings(file);
  // printArray(rawData);


  mon_id = new String[rawData.length];
  date = new String[rawData.length];
  noX = new float[rawData.length];
  no2 = new float[rawData.length];
  nO = new float[rawData.length];
  lonG = new float[rawData.length];
  laT = new float[rawData.length];

  // now use a loop to make strings into ints
  for (int i = 0; i <rawData.length; i++) {
    //break into pieces using comma as delimiter
    String [] splitData = split(rawData[i], ";"); 
    // printArray(splitData);

    // label and sort the data
    mon_id[i] = splitData[1]; 
    date [i] = splitData[2];  
    noX [i] = float(splitData[4]); 
    no2 [i] = float(splitData[5]); 
    nO[i] = float(splitData[6]); 
    lonG [i] = float(splitData[7]); 
    laT [i] = float(splitData[8]); 


    // printArray(date);
  }
}// end of processData

// D R A W   S H A P E S 

void dataDraw() {
  // get all the data that has a date
  // make an average of Nox
  // ^^^ do this later for now use a simple range to test with

  for (int i = 0; i <rawData.length; i++) { 
    // to do - 
    //make date into an int so that you can use it on the x axis

    // fill colour + opacity
    float fillRange = map(mouseY, 0, height, 280, 444);
    float opacityRange = map (mouseX, 0, width, 28, 100);
    fill(fillRange, height, height, opacityRange);

    // scale
    float scaleRange = map(mouseY, 0, width, -80, 500);

    // data to size of shape
    float noX_shape = map(noX[i], min(noX), max(noX), 100, 200); 
    xPos = map(i, 0, noX.length, 0, width);

    // move abouty
    float moveRange = map (mouseX, 0, width, 0, 300);
    float moveIt  = random((height/2)- moveRange, (height/2)+moveRange);
    ellipse(xPos, moveIt, noX_shape+scaleRange, noX_shape+scaleRange);
    println("mouseX = " + mouseX);

    // add 1 more variable to shapes that can be played with

    //fill(255);
    //text(date[i], min(noX)+ noX[i], height/2-noX[i]);
    //text(noX[i], min(noX)+ noX[i], height/2-noX[i]);
  }






  //
} // end of dataDraw