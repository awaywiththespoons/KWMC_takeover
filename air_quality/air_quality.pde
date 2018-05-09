//code based on: 
//Danial Shiffman's processing tutorials https://www.youtube.com/watch?v=PjxbuSnj8Pk
//Sparkfun's tutorial https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing
//Tom Igoe's Serial call response http://www.arduino.cc/en/Tutorial/SerialCallResponse

// file stuff
String file= "simple_data.csv"; // your file name here
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

// arduino stuff
import processing.serial.*; // import the serial library
Serial arduinoPort; //creating and object for the usb port
int[] serialInputArray = new int[14];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

// buttons etc.
int button1, button2, button3, button4, button5;
float pot1, pot2, pot3, pot4;
int joy1, joy2, joy3, joy4;
//usb port number
int portNum = 3;


void setup() {
  textAlign(CENTER);
  size(600, 600);
  noStroke();
  background(0);

  // list possibilty for serial ports
  printArray(Serial.list());
  // I can use the fisrt port to going to call it the ardunio port
  arduinoPort = new Serial(this, Serial.list()[portNum], 9600);

  processData();
} // end of SETUP

void draw() {

  background(0);
  // joystick 4 x digital input

  // buttons 5 x digital input  
  if (button1 == 0);
  info(); 
  if (button2 == 0);
  howTo(); 
  if (button3 == 0);
  dataModeRAW(); 
  if (button4 == 0);
  dataModeTIME(); 
  if (button4 == 0);
  dataModePLACE();

  // pots 4 x analog inputs
  colorMode(HSB, 255); 
  fill(pot4, 255, 255);
  ellipse(width/2+(pot3/4), height/2+(pot3/4), pot1, pot1);
  // add sin
  // add pot 4!
} // end of DRAW

// P R O C E S S    D A T A 
//HEADERS: monitor_id; monitor_description; date;      time;                     nox; no; no2; lat;     long;  location; year; month; day; hour; minute; day_of_week
//DATA EXAMPLE: 3;     Brislington;        2017-05-04; 0001-01-01T16:13:45-00:01; 68; 33; 34;  51.4417; -2.56;  51.4417

void processData() {

  //bring in csv file through strings
  rawData = loadStrings(file);
  printArray(rawData);
  mon_id = new String[rawData.length];
  date = new String[rawData.length];
  noX = new float[rawData.length];
  no2 = new float[rawData.length];
  nO = new float[rawData.length];
  lonG = new float[rawData.length];
  laT = new float[rawData.length];

  // now use a loop to make strings into ints
  for (int i = 0; i <rawData.length; i++) {
    String [] splitData = split(rawData[i], ";"); //break into pieces using comma as delimiter
    printArray(splitData);

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


// S E R I A L    E V E N T   
void serialEvent (Serial arduinoPort) {

  // read a byte from the serial port:
  int inByte = arduinoPort.read();

  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller.
  if (firstContact == false) {
    if (inByte == 'A') {
      arduinoPort.clear();   // clear the serial port buffer
      firstContact = true;  // you've had first contact from the microcontroller
      arduinoPort.write('A');  // ask for more
    }
  }

  // Otherwise, add the incoming byte to the array:
  else {
    // Add the latest byte from the serial port to array:
    serialInputArray[serialCount] = inByte;
    // printArray(serialInputArray);
    serialCount++;
    //  println(serialCount);

    // If we have 4 bytes:
    if (serialCount > 4 ) {
      pot1 = serialInputArray[0];
      pot2 = serialInputArray[1];
      pot3 = serialInputArray[2];
      pot4 = serialInputArray[3];

      button1 = serialInputArray[4];
      button2 = serialInputArray[5];
      button3 = serialInputArray[6];
      button4 = serialInputArray[7];
      button5 = serialInputArray[8];
      // print the values (for debugging purposes only):

      print("pot 1 = " + pot1 + " ");
      print("pot 2 = " + pot2 + " ");
      print("pot 3 = " + pot3 + " ");
      println("pot 4 = " + pot4 + " ");
      
      print("button 1 = " + button1 + " ");
      print("button 2 = " + button2 + " ");
      print("button 3 = " + button3 + " ");
      print("button 4 = " + button4 + " ");
      println("button 5 = " + button5 + " ");
 
      
      // Send a capital A to request new sensor readings:
      arduinoPort.write('A');

      // Reset serialCount:
      serialCount = 0;
    }
  }
}//end of serial event

// D A T A   M O D E ZZZZZZZ  
void dataModeRAW() {

  //get a random data point
  int randz = int(random (1, rawData.length));
  fill(255);
  textSize(14);
  text(mon_id[randz], width/2, 20);   // monitor ID
  text(date[randz], width/2, 40);   //Date
  text(noX[randz], width/2, 60);   //NOX
  text(no2[randz], width/2, 80);   //NO2
  text(nO[randz], width/2, 100);   //NO
  text(lonG[randz], width/2, 120);   //Long
  text(laT[randz], width/2, 140);   //Lat
} // end of dataMode

void  dataModeTIME() {
  fill(255);
  textSize(30); 
  text("TIME", width/2, 500);   //Lat
}

void  dataModePLACE() {
  fill(255);
  textSize(30); 
  text("PLACE", width/2, 500);   //Lat
}

void info() {
  fill(255);
  textSize(30); 
  text("INFO", width/2, 500);   //Lat
}

void howTo() {
  fill(255);
  textSize(30); 
  text("HOW TO", width/2, 500);   //Lat
}