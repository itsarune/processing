void levelComplete() {
  textFont(marioWorld);
  textAlign(CENTER, CENTER);
  fill(255);
  text("Level Complete!", width/2-300, height/2-300, 600, 200);
  fill(#36E8A8);
  textFont(start);
  text("Further developments will follow", 0, height/2-150, 800, height/2-50);
  if ((flagCa%65) < 40) {
    fill(255);
    textFont(start);
    text("Press SPACE to go back", width/2, height - 200);
  }
  translate = 0;
  started = true;
  stage1 = true;
  if (key == ' ') {
    x = 0;
    calcX = 0;
    y = 760;
    calcY = 0;
    consX[0] = 0;
    consX[1] = 770;
    consY[1] = 760;
    change = false;
    targetY = 760;
    jumpTarget = 760;
    delay(300);
    onGround = true;
    fallOff = false;
    turned = false;
    started = false;
  }
}