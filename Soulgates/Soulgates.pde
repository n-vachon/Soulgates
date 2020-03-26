// soul gates

import ddf.minim.*;
import processing.serial.*;

// To connect to arduino
Serial arduino;

// For future audio inputs?
Minim minim1;
Minim minim2;
Minim minim3;
AudioPlayer track1;
AudioPlayer track2;
AudioPlayer track3;

//Charecter Movement Images
PImage up, down, left, right;

//backgrounds images
PImage intro;
PImage bedroom;
PImage hallway;
PImage laseroom;
PImage wateroom;
PImage bossroom;
PImage bedroom2;
PImage ending;


//Text, Room, and Direction Checkers
int textdisplay = 1; //which text to display
int scene = 0; // which scene to display
int direction = 0; //1=left, 2=up, 3=right, 4=down

//Speed of movement
int speed = 10;

//Character position
int x,y;

//text string to display
String currentText = "";

//Success checks
// when arduino sends a specific letter, these booleans will turn true
boolean flame = false;
boolean water = false;
boolean laser = false;
boolean attempt = false; // to check if code was attempted
boolean codeopen = false;
boolean boss = false;
boolean scream = false;

//Font Variables
// different fonts are used for different "voices" used through the text displayed
PFont instructFont, evilFont, goodFont;

//Aurduino input
//int incomingByte;

void setup() {
  size(1000,1000); 
  x=width/2; //starting position
  y=height*3/4;
  instructFont = createFont("Calibri", 50);
  evilFont = createFont("Calibri", 25); // to be changed later
  goodFont = createFont("Calibri", 70); // to be changed later
  
  //printArray(Serial.list()); //list serial ports
  //String portName = Serial.list()[1]; // pc
  //arduino = new Serial(this, portName, 9600);
  
  //initialize images
  intro = loadImage("Bedroom_lightoff.png");
  bedroom = loadImage("Bedroom_lighton.png");
  hallway = loadImage("hallway .png");
  laseroom = loadImage("lazer room.png");
  wateroom = loadImage("Water_beach_room.png");
  bossroom = loadImage("bossroom_new.png");
  bedroom2 = loadImage("Bedroom_lighton.png");
  // size then up appropriately
  intro.resize(width,height);
  bedroom.resize(width,height);
  hallway.resize(width,height);
  laseroom.resize(width,height);
  wateroom.resize(width,height);
  bossroom.resize(width,height);
  bedroom2.resize(width,height);
}

void draw() {
  //Fill entire screen with black to eliminate edges showing 
  fill(0,0,0);
  rect(0,0,width,height);
  
  //check fo arduino input
  //if ( arduino.available() > 0) {  // If data is available,
    //incomingByte = arduino.read();  // read it and store it in incomingByte
  //}
  
  //use arduino input to change things
  //checkArduino(incomingByte); // this function call replaces the keyPressed function

  //scene sellector
  if (scene == 0) { 
    intro(); // describes scenario
  } else if (scene == 1) {
    bedroom(); //opens to girls bedroom
    //track2.play();
  } else if (scene == 2) {
    hall(); //hallway connecting rooms
  } else if (scene == 3) {
    laser(); //laser room
  } else if (scene == 4) {
    water(); //water room
  } else if (scene == 5) {
    code(); // crack the code scene
  } else if (scene == 6) {
    boss(); // fight the boss demon
  } else if (scene == 7) {
    bedend(); //enter bedroom to wake sister
  } else if (scene == 8) {
    ending(); // result of waking sister
  }
  //println(textdisplay);
}

// This function checks the input recieved from arduino against the letter is represents then does this action
void checkArduino(int key) {
  switch (key) {
  case 'l': // move left
      direction = 1;
      if (scene == 1 && x > 130) {x -= speed;} // max left direction in bedroom (scene 1)
      else if (scene == 2 && x > 170) {x -= speed;} // max left direction in hall (scene 2)
      else if (scene == 3 && x > 290) {x -= speed;} // max left direction in laser room (scene 3)
      else if (scene == 4 && x > 410) {x -= speed;} // max left direction in water room (scene 4)
      else if (scene == 6 && x > 60) {x -= speed;} // max left direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 'u': // move up
      direction = 2;
      if (scene == 1 && y > 250) {y -= speed;} // max up direction in bedroom (scene 1)
      else if (scene == 2 && y > 235) {y -= speed;} // max up direction in hall (scene 2)
      else if ((scene == 3 || scene == 4) && y > 245) {y -= speed;} // max up direction in side rooms (scene 3 & 4)
      else if (scene == 6 && y > 180) {y -= speed;} // max up direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 'r': // move right
      direction = 3;
      if (scene == 1 && x < 880) {x += speed;} // max right direction in bedroom (scene 1)
      else if (scene == 2 && x < 830) {x += speed;} // max right direction in hall (scene 2)
      else if (scene == 3 && x < 680) {x += speed;} // max right direction in laser room (scene 3)
      else if (scene == 4 && x < 750) {x += speed;} // max right direction in water room (scene 4)
      else if (scene == 6 && x < 800) {x += speed;} // max right direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 'd': // move down
      direction = 4;
      if (scene == 1 && y < 790) {y += speed;} // max down direction in bedroom (scene 1)
      else if (scene == 2 && y < 870) {y += speed;} // max down direction in hall (scene 2)
      else if ((scene == 3 || scene == 4) && y < 800) {y += speed;} // max down direction in side rooms (scene 3 & 4)
      else if (scene == 6 && y < 870) {y += speed;} // max down direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 't':
      textdisplay++; // increase text number to go to next text block
      break;
  case 'F':
      flame = true; // success in flame room
      break;
  case 'W':
      water = true; //success in water room
      break;
  case 'L':
      laser = true; //success in laser room
      break;
  case 'C':
      codeopen = true; // code cracked
      scene = 6; // go to boss scene
      break;
  case 'c':
      attempt =true; //code was attempted and wrong
      break;
  case 'B':
      boss = true; // success in boss room
      break;
  case 'S':
      scream = true; //success in scream
  // rest of the cases are for future balloon simon says
  case 'G':
      // red balloon
      break;
  case 'H':
      // blue balloon
      break;
  case 'J':
      //green balloon
      break;
  case 'K':
      //yellow balloon
      break;
  }
}

// functions to test processing without arduino input - replace with keyboard input
void keyPressed() {
  if (key == CODED) { // movement
    if (keyCode == LEFT) {
      direction = 1;
      if (scene == 1 && x > 130) {x -= speed;} // max left direction in bedroom (scene 1)
      else if (scene == 2 && x > 170) {x -= speed;} // max left direction in hall (scene 2)
      else if (scene == 3 && x > 290) {x -= speed;} // max left direction in laser room (scene 3)
      else if (scene == 4 && x > 410) {x -= speed;} // max left direction in water room (scene 4)
      else if (scene == 6 && x > 60) {x -= speed;} // max left direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
    }
    if (keyCode == UP) {
      direction = 2;
      if (scene == 1 && y > 250) {y -= speed;} // max up direction in bedroom (scene 1)
      else if (scene == 2 && y > 235) {y -= speed;} // max up direction in hall (scene 2)
      else if ((scene == 3 || scene == 4) && y > 245) {y -= speed;} // max up direction in side rooms (scene 3 & 4)
      else if (scene == 6 && y > 180) {y -= speed;} // max up direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
    }
    if (keyCode == RIGHT) {
      direction = 3;
      if (scene == 1 && x < 880) {x += speed;} // max right direction in bedroom (scene 1)
      else if (scene == 2 && x < 830) {x += speed;} // max right direction in hall (scene 2)
      else if (scene == 3 && x < 680) {x += speed;} // max right direction in laser room (scene 3)
      else if (scene == 4 && x < 750) {x += speed;} // max right direction in water room (scene 4)
      else if (scene == 6 && x < 800) {x += speed;} // max right direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
    }
    if (keyCode == DOWN) {
      direction = 4;
      if (scene == 1 && y < 790) {y += speed;} // max down direction in bedroom (scene 1)
      else if (scene == 2 && y < 870) {y += speed;} // max down direction in hall (scene 2)
      else if ((scene == 3 || scene == 4) && y < 800) {y += speed;} // max down direction in side rooms (scene 3 & 4)
      else if (scene == 6 && y < 870) {y += speed;} // max down direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
    }
  }
  else {
    if (key == 'f'||key =='F') {flame = true;} // success in flame room
    else if (key == 'w'||key =='W') {water =true;} //success in water room
    else if (key == 'l'||key =='L') {laser = true;} //success in laser room
    else if (key == 's'||key == 'S') {scream = true;} //success in scream
    // next 4 are for future simon says balloons
    else if (key == 'g'||key =='G') {} //balloon red
    else if (key == 'h'||key =='H') {} //balloon blue
    else if (key == 'j'||key =='J') {} //balloon green
    else if (key == 'k'||key =='K') {} //balloon yellow
    else if (key == 'c'||key =='C') {codeopen =true; scene=6;} // code cracked
    else if (key == 't'||key =='T') {textdisplay++;} // increment text
    else if (key == 'b'||key =='B') {boss = true;} //success in boss room
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
  
  // stand in green square for person during testing
  rectMode(CENTER);
  fill(0,255,0);
  rect(x,y,100,100);
  rectMode(CORNER);
}

// this function checks if in a doorway based on the scene
void changescene() {
  // in bedroom
  if (scene == 1) { 
    if (direction == 2) { // UP
      if (y < 330 && x >= 220 && x <= 240) { // going through doorway
      // position in new doorframe
        y = 860;
        x = width/2;
        scene = 2; // go into hall
      }
    }
  }
  
  //in hall
  else if (scene == 2) {
    if (direction == 1) { // LEFT
      if (x < 180 && y <= 585 && y >= 565) { // going through doorway
      // position in new doorframe
        x = 760;
        y = 515;
        scene = 4; // WATER room
      }
    }
    else if (direction == 2) { // UP
      if (y < 245 && x <= 570 && x >= 400) { // going through doorway
        if (water && laser && !codeopen) { 
          //if succeeded in water and laser rooms, but not already defeated code, then open code scene
          y = height;
          scene = 5; // CODE scene
        } 
        else if (!codeopen) {
          //text("It's locked!", width/3, height/3, 300, 300);     
          // make a function for this
        }// else if not defeated code then say it's locked
        else { // else go into boss room
          y = height;
          scene = 6; // BOSS room
        } 
      }
    }
    else if (direction == 3) { // RIGHT
      if (x > 820 && y <= 585 && y >= 565) { // going through doorway
      // position in new doorframe
        x = 300;
        y = 515;
        scene = 3; // LASER room
      }
    }
    else if (direction == 4) { // DOWN
      if (y > 860 && x >=460 && x <= 500) { // going through doorway
        // position in new doorframe
        y = 340;
        x = 230;
        if (boss) { // if completed boss scene, go to ending bedroom scene 
          scene = 7; // ENDING scene in bedroom
        } 
        else { // else go back to original bedroom scene
          scene = 1; // BEGINNING bedroom scene
        }
      }
    }
  }
  
  else if (scene == 3) { // LASER ROOM
    if (direction == 1) { // LEFT
      if (x < 300 && y >= 505 && y <= 525) { // going through doorway
      // position in new doorframe
        x = 820;
        y = 575;
        scene = 2; // HALL
      }
    }
  }
  
  else if (scene == 4) { // WATER ROOM
    if (direction == 3) { // RIGHT
      if (x > 740 && y >= 505 && y <= 525) { // going through doorway
      // position in new doorframe
        x = 180;
        y = 575;
        scene = 2; // HALL
      }
    }
  }
  
  else if (scene == 6) { // BOSS
    if (direction == 4) { // DOWN 
      if (y > 860 && x <= 520 && x >= 480) { // going through doorway
      // position in new doorframe
        y = 245;
        scene = 2; // HALL
      }
    }
  }
}
