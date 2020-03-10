void hall() {
  image(hallway, 0,0);
  //fill(0,0,255);
  //rect(0,0,width, height);
  fill(0,0,0);
  textFont(instructFont);
  text("Hall", width/3, height/3, 300, 300);
  switch (textdisplay) {
    case 10:
      currentText = "Intro 10";
      break;
    case 11:
      currentText = "text 11";
      break;
    case 12: 
      currentText = "text 12";
      break;
    case 13:
      currentText = "text 13";
      break;
    default: 
      currentText = "";
      textdisplay = 14;
      break;
  }
  text(currentText, width/3, height/2, 300, 300);
    drawPerson();
}
