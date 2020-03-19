#include <SoftwareSerial.h>

const byte rxPin = 2;
const byte txPin = 3;

SoftwareSerial myserial (rxPin, txPin);

int sound_val = 0; // to check intensity of sound
int water_val = 0;
int flame_val = 0;
const int sensorMin = 0;     // sensor minimum for flame
const int sensorMax = 1024;  // sensor maximum for flame

const int x_pin = A0;
const int y_pin = A1;
const int sound = A2;
const int flame = A3;
const int water = A4;
const int photocell = A5;
const int SW_pin = 10;
const int laser = 13;
const int button = 12;
const int magnet = 11;

int hitSensor, hitButton, waterlevel;
boolean laserOn = false;

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
   pinMode (laser, OUTPUT); // define the digital output interface 13 feet
   pinMode (photocell, INPUT);
   pinMode (button, INPUT);
   pinMode (water, INPUT);
   pinMode (flame, INPUT);
   pinMode (sound, INPUT);
   pinMode(SW_pin, INPUT);
   digitalWrite(SW_pin, HIGH);
   myserial.begin(9600);
   Serial.begin(9600);
}
void loop () {
  
  /////// READ KEYPAD //////////////
  if(myserial.available() > 0){
    String letter = myserial.readString();
    Serial.println(letter);
  }


  ////////// READ BUTTON _ TURN ON LASER _ READ PHOTOCELL ????????????
  hitButton = digitalRead(button);
  //Serial.println(hitButton);
  if (hitButton == HIGH) {
    laserOn = true;
  }
  
  if (laserOn) {
    digitalWrite(laser, HIGH); // open the laser head
  }
  else {
    digitalWrite(laser, LOW); // turn off the laser head
  } 
   hitSensor = analogRead(photocell);
   if (hitSensor < 100) {
    laserOn = false;
   //Serial.println(hitSensor);
   }
   
   //////// READ JOYSTICK /////////
  if (x_pin > 800 || y_pin > 800 || x_pin < 300 || y_pin < 300) {
  Serial.println("X-axis: ");
  Serial.println(analogRead(x_pin));
  Serial.println("Y-axis: ");
  Serial.println(analogRead(y_pin));
  }
  if (SW_pin == 0){
  Serial.println("Switch is ON");
  //Serial.println(digitalRead(SW_pin));
  }

////// READ SOUND ////////////
  sound_val = analogRead(sound);
  if (sound_val > 100) {
  Serial.println("Sound: ");
  Serial.println(sound_val);
  }

////// READ FLAME /////////////
  // read the sensor on analog A0:
  flame_val = analogRead(flame);
  // map the sensor range (four options):
  // ex: 'long int map(long int, long int, long int, long int, long int)'
  int range = map(flame_val, sensorMin, sensorMax, 0, 3);
  if(range > 1) {
    Serial.println("Flame is close");
  }
  
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
  if (water_val > 30) {
  Serial.println(water_val);
  }

  //delay(10);
}
