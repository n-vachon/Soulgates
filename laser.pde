void laser() {
  image(laseroom, 0,0);
  //fill(255,0,0);
  //rect(0,0,width, height);
  fill(0,0,0);
  textFont(instructFont);
    currentText = "Laser";
    text(currentText, width/3, height/3, 300, 300);
  
  drawPerson();

}
