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

//Text box growing and shrinking 
//boolean grow = false;
//int xgrow = 0;
//boolean text = false;

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
boolean flame = false;
boolean water = false;
boolean laser = false;
boolean attempt = false; // to check if code was attempted
boolean codeopen = false;
boolean boss = false;
boolean scream = false;

//Font Variables
PFont instructFont, evilFont, goodFont;

//Aurduino input
//int incomingByte;

void setup() {
  size(1000,1000);
  x=width/2;
  y=height*3/4;
  instructFont = createFont("Calibri", 50);
  evilFont = createFont("Calibri", 25);
  goodFont = createFont("Calibri", 70);
  
  //printArray(Serial.list()); //list serial ports
  //String portName = Serial.list()[1]; // pc
  //arduino = new Serial(this, portName, 9600);
  
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
  //Fill entire screen with black  
  fill(0,0,0);
  rect(0,0,width,height);
  
  //check fo arduino input
  //if ( arduino.available() > 0) {  // If data is available,
    //incomingByte = arduino.read();  // read it and store it in incomingByte
  //}
  
  //use arduino input to change things
  //checkArduino(incomingByte); // this function call replaces the keyPressed function
  println("xpos: "+x);
  println("ypos: "+y);
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

void checkArduino(int key) {
  switch (key) {
  case 'l':
      direction = 1;
      if (scene == 1 && x > 130) {x -= speed;} // max left direction in bedroom (scene 1)
      else if (scene == 2 && x > 170) {x -= speed;} // max left direction in hall (scene 2)
      else if (scene == 3 && x > 290) {x -= speed;} // max left direction in laser room (scene 3)
      else if (scene == 4 && x > 410) {x -= speed;} // max left direction in water room (scene 4)
      else if (scene == 6 && x > 60) {x -= speed;} // max left direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 'u':
      direction = 2;
      if (scene == 1 && y > 250) {y -= speed;} // max up direction in bedroom (scene 1)
      else if (scene == 2 && y > 235) {y -= speed;} // max up direction in hall (scene 2)
      else if ((scene == 3 || scene == 4) && y > 245) {y -= speed;} // max up direction in side rooms (scene 3 & 4)
      else if (scene == 6 && y > 180) {y -= speed;} // max up direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 'r':
      direction = 3;
      if (scene == 1 && x < 880) {x += speed;} // max right direction in bedroom (scene 1)
      else if (scene == 2 && x < 830) {x += speed;} // max right direction in hall (scene 2)
      else if (scene == 3 && x < 680) {x += speed;} // max right direction in laser room (scene 3)
      else if (scene == 4 && x < 750) {x += speed;} // max right direction in water room (scene 4)
      else if (scene == 6 && x < 800) {x += speed;} // max right direction in boss room (scene 6)
      changescene(); // check if in door position to change scene
      break;
  case 'd':
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
    else if (key == 'z'||key =='Z') {} //balloon red
    else if (key == 'x'||key =='X') {} //balloon blue
    else if (key == 'c'||key =='C') {} //balloon green
    else if (key == 'v'||key =='V') {} //balloon yellow
    else if (key == 'q'||key =='Q') {codeopen =true; scene=6;} // code cracked
    else if (key == 't'||key =='T') {textdisplay++;} // increment text
    else if (key == 'b'||key =='B') {boss = true;} //success in boss room
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
  if (scene == 1) {
    if (direction == 2) { // UP
      if (y < 330 && x >= 220 && x <= 240) {
        y = 860;
        x = width/2;
        scene = 2;
      }
    }
  }
  
  //in hall
  else if (scene == 2) {
    if (direction == 1) { // LEFT
      if (x < 180 && y <= 585 && y >= 565) {
        x = 760;
        y = 515;
        scene = 4; // WATER
      }
    }
    else if (direction == 2) { // UP
      if (y < 245 && x <= 570 && x >= 400) {
        if (water && laser && !codeopen) { 
          //if succeeded in water and laser rooms, but not already defeated code, then open code scene
          y = height;
          scene = 5; // CODE
        } 
        else if (!codeopen) {
          //text("It's locked!", width/3, height/3, 300, 300);     
          // make a function for this
        }// else if not defeated code then say it's locked
        else { // else go into boss room
          y = height;
          scene = 6; // BOSS
        } 
      }
    }
    else if (direction == 3) { // RIGHT
      if (x > 820 && y <= 585 && y >= 565) {
        x = 300;
        y = 515;
        scene = 3; // LASER
      }
    }
    else if (direction == 4) { // DOWN
      if (y > 860 && x >=460 && x <= 500) {
        y = 340;
        x = 230;
        if (boss) { // if completed boss scene, go to ending bedroom scene 
          scene = 7; // ENDING
        } 
        else { // else go back to original bedroom scene
          scene = 1; // BEGINNING
        }
      }
    }
  }
  
  else if (scene == 3) { // LASER ROOM
    if (direction == 1) { // LEFT
      if (x < 300 && y >= 505 && y <= 525) {
        x = 820;
        y = 575;
        scene = 2; // HALL
      }
    }
  }
  
  else if (scene == 4) { // WATER ROOM
    if (direction == 3) { // RIGHT
      if (x > 740 && y >= 505 && y <= 525) {
        x = 180;
        y = 575;
        scene = 2; // HALL
      }
    }
  }
  
  else if (scene == 6) { // BOSS
    if (direction == 4) { // DOWN 
      if (y > 860 && x <= 520 && x >= 480) { 
        y = 245;
        scene = 2; // HALL
      }
    }
  }
}
