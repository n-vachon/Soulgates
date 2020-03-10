int laser = 13;
int photocell = 0;
int button = 2;
int water = A1;

int hitSensor, hitButton, waterlevel;
boolean laserOn = false;

void setup ()
{
   pinMode (laser, OUTPUT); // define the digital output interface 13 feet
   pinMode (photocell, INPUT);
   pinMode (button, INPUT);
   pinMode (water, INPUT);
   Serial.begin(9600);
}
void loop () {
  hitButton = digitalRead(button);
  Serial.println(hitButton);
  
  if (hitButton == HIGH) {
    laserOn = true;
  }

  if (laserOn) {
    digitalWrite (laser, HIGH); // open the laser head
  }
  else {
    digitalWrite (laser, LOW); // turn off the laser head
  } 

   hitSensor = analogRead(photocell);

   if (hitSensor < 800) {
    laserOn = false;
   }

   Serial.println(hitSensor);

   waterlevel = analogRead(water);
   Serial.println(waterlevel);
   delay(100);
}
