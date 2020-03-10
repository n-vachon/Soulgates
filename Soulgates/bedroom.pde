void bedroom() {
  image(bedroom, 0, 0);
  //fill(0,255,0);
  //rect(0,0,width, height);
  fill(255,255,255);
  textFont(instructFont);
  text("Bedroom", width/3, height/3, 300, 300);
  switch (textdisplay) {
    case 6:
      currentText = "Intro 6";
      break;
    case 7:
      currentText = "text 7";
      break;
    case 8: 
      currentText = "text 8";
      break;
    case 9:
      currentText = "text 9";
      break;
    default: 
      textdisplay = 10;
      currentText = "";
      break;
  }
  text(currentText, width/3, height/2, 300, 300);
    drawPerson();
}
