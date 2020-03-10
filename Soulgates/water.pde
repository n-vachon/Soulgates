void water() {
  image(wateroom, 0,0);
  //fill(255,255,255);
  //rect(0,0,width, height);
  fill(255,255,255);
  textFont(instructFont);
    currentText = "Water";
    text(currentText, width/3, height/3, 300, 300);
  
  drawPerson();

}
