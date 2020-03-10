// Arduino pin numbers
const int SW_pin = 2; // digital pin connected to switch output
const int X_pin = 0; // analog pin connected to X output
const int Y_pin = 1; // analog pin connected to Y output
 
void setup() {
  //pinMode(SW_pin, INPUT);
  //digitalWrite(SW_pin, HIGH);
  //Serial.begin(115200);
  Serial.begin(9600);  
}
 
void loop() {
  Serial.println("Switch:  ");
  Serial.println(digitalRead(2));
  Serial.println("X-axis: ");
  Serial.println(analogRead(A1));
  Serial.println("Y-axis: ");
  Serial.println(analogRead(A0));
  Serial.print("\n\n");
  delay(500);
}
