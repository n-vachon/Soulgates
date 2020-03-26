#include <SoftwareSerial.h>

// Used to connect second arduino with keypad to this one
const byte rxPin = 2;
const byte txPin = 3;
SoftwareSerial myserial (rxPin, txPin);

int sound_val = 0; // to check intensity of sound
int water_val = 0; // to checl hieght of water level
int flame_val = 0; // to check proximity of flame
const int sensorMin = 0;     // sensor minimum for flame
const int sensorMax = 1024;  // sensor maximum for flame

const int x_pin = A0; //joystick horizontal/x-axis
const int y_pin = A1; //joystick vertical/y-axis
const int sound = A2; // sound sensor
const int flame = A3; // flame sensor
const int water = A4; // water sensor
const int photocell = A5; // photocell input
const int SW_pin = 10; // joystick "click"
const int laser = 13; // laser emitor
const int button = 12; // button to activate laser
const int magnet = 11; // electromagnetic sensor

int hitSensor, hitButton; // hitButton check if button has been pressed, hitSensor checks if photocell has beeen hit
boolean laserOn = false; // bool to turn on and off laser

//////////////////////////////////////////////////////////////////
//// code won't compile if this function comes after void loop ////
//////////////////////////////////////////////////////////////////
void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0");   // send an initial string
    delay(300);
  }
}//////////// THIS CODE IS FROM AN IN CLASS EXAMPLE ///////////////


void setup ()
{
   pinMode (laser, OUTPUT);
   pinMode (photocell, INPUT);
   pinMode (button, INPUT);
   pinMode (water, INPUT);
   pinMode (flame, INPUT);
   pinMode (sound, INPUT);
   pinMode(SW_pin, INPUT);
   digitalWrite(SW_pin, HIGH); // needed or esle SW_pin input doesn't work?
   myserial.begin(9600); // start serial communication with second arduino
   Serial.begin(9600); // start serial communication with processing
}
void loop () {
  
  /////// READ KEYPAD //////////////
  if(myserial.available() > 0){
    String letter = myserial.readString(); // read input
    Serial.println(letter); // send to Processing
  }


  ////////// READ BUTTON _ TURN ON LASER _ READ PHOTOCELL //////////////////
  hitButton = digitalRead(button); // read input
  if (hitButton == HIGH) {
    laserOn = true; // turn on laser
  }
  
  if (laserOn) {
    digitalWrite(laser, HIGH); // turn on the laser head
  }
  else {
    digitalWrite(laser, LOW); // turn off the laser head
  } 
   hitSensor = analogRead(photocell); //read photocell
   if (hitSensor < 100) { //if hit
    laserOn = false; //turn off laser
    Serial.println("L"); // send success to processing
   }
   
   //////// READ JOYSTICK /////////
  if (x_pin > 800) {
    Serial.println("r"); // send right to processing
  }
  else if (x_pin < 300) {
    Serial.println("l"); // send left to processing
  }
  else if (y_pin > 800) {
    Serial.println("u"); // send up to processing
  }
  else if (y_pin < 300) {
    Serial.println("d"); // send down to processing
  }
  if (SW_pin == 0){ // if joystick is clicked
  Serial.println("t"); // send t for text to processing
  }

////// READ SOUND ////////////
  sound_val = analogRead(sound); // read sound sensor
  if (sound_val > 100) { // if sound is loud
  Serial.print("S"); // send success to processing
  }

////// READ FLAME /////////////
  // read the sensor 
  flame_val = analogRead(flame);
  // map the sensor range (four options):
  // ex: 'long int map(long int, long int, long int, long int, long int)'
  int range = map(flame_val, sensorMin, sensorMax, 0, 3);
  if(range > 1) { // if flame is semi-close
    Serial.print("F"); // send success to processing
  }

//Source: https://create.arduino.cc/projecthub/SURYATEJA/arduino-modules-flame-sensor-6322fb
// For mapping and range values
//  // range value:
//  switch (range) {
//  case 0:    // A fire closer than 1.5 feet away.
//    Serial.println("** Close Fire **");
//    break;
//  case 1:    // A fire between 1-3 feet away.
//    Serial.println("** Distant Fire **");
//    break;
//  case 2:    // No fire detected.
//    Serial.println("No Fire");
//    break;
//  }

  ////////////// WATER //////////////
  water_val = analogRead(water);
  if (water_val > 30) { // if water is at 30 mm
  Serial.println("W"); // send success to processing
  }

  //delay(10);
}
