int Led = 13 ; // define LED Interface
int buttonpin = 3; // define the Reed sensor interfaces
int val ; // define numeric variables val
void setup ()
{
  Serial.begin(9600);
}
void loop () {
//SunFounder{
  val = analogRead (A0) ; // digital interface will be assigned a value of 3 to read val
  Serial.println(val);
//  if (val == HIGH) // When the Reed sensor detects a signal, LED flashes
//  {
//    digitalWrite (Led, HIGH);
//  }
//  else
//  {
//    digitalWrite (Led, LOW);
//  }
}
