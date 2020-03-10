void intro() {
  image(intro, 0,0);
  //fill(255,0,0);
  //rect(0,0,width, height);
  fill(255,255,255);
  textFont(instructFont);
  switch (textdisplay) {
    case 1:
      currentText = "Intro 1";
      break;
    case 2:
      currentText = "text 2";
      break;
    case 3: 
      currentText = "text 3";
      break;
    case 4:
      currentText = "text 4";
      break;
    case 5: 
      currentText = "";
      textdisplay = 6;
      scene = 1;
    default: 
      currentText = "";
      break;
  }
  text(currentText, width/3, height/3, 300, 300);

  
  //drawPerson();
  //if(x>600) {scene=1;}
}
