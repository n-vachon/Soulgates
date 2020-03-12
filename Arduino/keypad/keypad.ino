#include <Keypad.h>
String incode = "";
String rigthcode = "1234"; 
const byte ROWS = 4; //four rows
const byte COLS = 4; //four columns
char keys[ROWS][COLS] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
};

byte rowPins[ROWS] = {5, 4, 3, 2}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {9, 8, 7, 6}; //connect to the column pinouts of the keypad

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

void setup(){
   Serial.begin(9600);
}
  
void loop(){
  //// READ KEYPAD ///////
  char key = keypad.getKey();
  
  if (key){
    incode += key;
    //Serial.println("Key: ");
    //Serial.println(key);
    //Serial.println(incode);

  if(incode == "1234") {
    //if(Serial.available() > 0){
    //digitalWrite(1, "yes");
    //}
    Serial.println("yes");
    incode = "";
  }
  else if (incode.length() == 4){
//    if(Serial.available() > 0){
//    digitalWrite(1, "no");
//    }
    Serial.println(incode);
    incode = "";
  }
}
  delay(10);
}
