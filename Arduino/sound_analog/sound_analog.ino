int Led = 13 ;// define LED Interface
int buttonpin = 3; // define D0 Sensor Interface
int val = 0;// define numeric variables val
 
void setup ()
{
  Serial.begin(9600); 
}
 
void loop ()
{
  val = analogRead(A0);// digital interface will be assigned a value of pin 3 to read val
  Serial.println (val);
//  if (val == HIGH) // When the sound detection module detects a signal, LED flashes
//  {
//    Serial.println ("loud");
//  }
//  else
//  {
//    Serial.println ("quiet");
//  }
}
