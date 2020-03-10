// soul gates

import ddf.minim.*;
import processing.serial.*;
Serial arduino;
Minim minim1;
Minim minim2;
Minim minim3;
AudioPlayer track1;
AudioPlayer track2;
AudioPlayer track3;
//Serial myPort;

//Text box growing and shrinking 
//boolean grow = false;
//int xgrow = 0;
//boolean text = false;

//Charecter Movement Images
PImage up, down, left, right;

//backgrounds
PImage intro;
PImage bedroom;
PImage hallway;
PImage laseroom;
PImage wateroom;
PImage bossroom;
PImage bedroom2;
PImage ending;


//Text, Room, and Direction Checkers
int textdisplay = 1;
int scene = 0;
int direction = 0; //1=left, 2=up, 3=right, 4=down

//Speed of movement
int speed = 10;

//Character position
int x,y;

//text string to display
String currentText = "";

//Success checks
boolean water = true;
boolean laser = true;
boolean codeopen = false;
boolean boss = false;
boolean scream = false;

//Font Variables
PFont instructFont, evilFont, goodFont;

void setup() {
  size(1000,1000);
  x=width/2;
  y=height/2;
  instructFont = createFont("Calibri", 50);
  evilFont = createFont("Calibri", 25);
  goodFont = createFont("Calibri", 70);
  //printArray(Serial.list()); //list serial ports
  //String portName = Serial.list()[1]; // pc
  //myPort = new Serial(this, portName, 9600);
  
  //initialize images
  intro = loadImage("Bedroom_lightoff.png");
  bedroom = loadImage("Bedroom_lighton.png");
  hallway = loadImage("Main_Room.png");
  laseroom = loadImage("lazer room.png");
  wateroom = loadImage("Water_beach_room.png");
  bossroom = loadImage("Bossroom.png");
  bedroom2 = loadImage("Bedroom_lighton.png");
  intro.resize(width,height);
  bedroom.resize(width,height);
  hallway.resize(width,height);
  laseroom.resize(width,height);
  wateroom.resize(width,height);
  bossroom.resize(width,height);
  bedroom2.resize(width,height);
}

void draw() {
  fill(0,0,0);
  rect(0,0,width,height);
  //if ( myPort.available() > 0) {  // If data is available,
  //  val = myPort.read();         // read it and store it in val
  //}
    //scene sellector
  if (scene == 0) { 
    intro(); // describes scenario
  } else if (scene == 1) {
    //image(bedroom, 500, 500);
    bedroom(); //opens to girls bedroom
    //track2.play();
  } else if (scene == 2) {
    //image(hallway, 500, 500); 
    hall(); //hallway connecting rooms
  } else if (scene == 3) {
    //image(laseroom, 500, 500); 
    laser(); //laser room
  } else if (scene == 4) {
    //image(wateroom, 500, 500); 
    water(); //water room
  } else if (scene == 5) {
    code(); // crack the code scene
  } else if (scene == 6) {
    //image(bossroom, 500, 500); 
    boss(); // fight the boss demon
  } else if (scene == 7) {
    //image(bedroom2, 500, 500);
    bedend(); //enter bedroom to wake sister
  } else if (scene == 8) {
    //image(ending, 500, 500);
    ending(); // result of waking sister
  }
  println(textdisplay);
}

void keyPressed() {
  if (key == CODED) { // movement
    if (keyCode == LEFT) {
      direction = 1;
      if (x >= 10) {x -= speed;} //move left by 5 if not at wall
      else if (y <=600 && y>=400) {changescene();} // if in door position, check to change scene
    }
    if (keyCode == UP) {
      direction = 2;
      if (y >= 10) {y -= speed;} //move up by 5 if not at wall
      else if (x <=600 && x>=400) {changescene();} // if in door position, check to change scene
    }
    if (keyCode == RIGHT) {
      direction = 3;
      if (x <= width-10) {x += speed;} //move right by 5 if not at wall
      else if (y <=600 && y>=400) {changescene();} // if in door position, check to change scene
    }
    if (keyCode == DOWN) {
      direction = 4;
      if (y <= height-10) {y += speed;} // move down by 5 if not at wall
      else if (x <=600 && x>=400) {changescene();} // if in door position, check to change scene
    }
  }
  else {
    if (key == 'f'||key =='F') {} // success in flame room
    else if (key == 'w'||key =='W') {} //success in water room
    else if (key == 'l'||key =='L') {} //success in laser room
    else if (key == 's'||key == 'S') {} //success in scream
    else if (key == 'z'||key =='Z') {} //balloon red
    else if (key == 'x'||key =='X') {} //balloon blue
    else if (key == 'c'||key =='C') {} //balloon green
    else if (key == 'v'||key =='V') {} //balloon yellow
    else if (key == 'q'||key =='Q') {codeopen =true; scene=6;} // code cracked
    else if (key == 't'||key =='T') {textdisplay++;} // increment text
    else {} // keep numbers? can arduino check this and send success?
  }
}

void drawPerson() {
  ////// DRAW PERSON //////
  //if (direction == 1) {
  //  image(left, x, y);
  //} else if (direction == 2) {
  //  image(up, x, y);
  //} else if (direction == 3) {
  //  image(right, x, y);
  //} else if (direction == 4) {
  //  image(down, x, y);
  //}
  ///// END DRAW PERSON ////////
  rectMode(CENTER);
  fill(0,255,0);
  rect(x,y,100,100);
  rectMode(CORNER);
}

void changescene() {
  // in bedroom
  if (direction == 2 && scene == 1) { // walk out of bedroom into hall
    y = height;
    scene = 2;
  } 
  
  //in hall
  else if (direction == 1 && scene == 2) { // walk out of hall into water room
    x = width;
    scene = 4; 
  } 
  else if (direction == 3 && scene == 2) { // walk out of hall into laser room
    x = 0;
    scene = 3;
  } 
  else if (direction == 2 && scene == 2) { //try and open locked door
    if (water && laser && !codeopen) { //if succeeded in water and laser rooms, but not already defeated code, then open code scene
      y = height;
      scene = 5;
    } 
    else if (!codeopen) {}// else if not defeated code then say it's locked
    else { // else go into boss room
      y = height;
      scene = 6;
    } 
  }
  else if (direction == 4 && scene == 2) { // try to go into bedroom
    if (boss) { // if completed boss scene, go to ending bedroom scene
      y = 0;
      scene = 7;
    } 
    else { // else go back to original bedroom scene
      y = 0;
      scene = 1;
    } 
  }
  
  // in laser room
  else if (direction == 1 && scene == 3) { // walk out of laser room into hall
    x = width;
    scene = 2;
  } 
  
  // in water room
  else if (direction == 3 && scene == 4) { // walk out of water room into hall
    x = 0;
    scene = 2;
  } 
  
  //in boss room
  else if (direction == 4 && scene == 6) { // walk out of boss room into hall
    y = 0;
    scene = 2;
  } 
}
