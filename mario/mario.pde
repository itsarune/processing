Mario mario1; //<>//

int x, r, s, count, canSetY, target, calcX, startCount, f; //declare ints
int flagCa = 0; //declare counter
int i = 0;
int[] consX = {0, 770}; //constrain values
float[] consY = {  0.0, 760.0  }; //constrain values
float y, calcY, translate; //float values
float targetY = 760;
float jumpTarget = 760;
float m = -2f/25; //slope for jumps
String dir = "RIGHT";
boolean direction, falling, turned;
boolean cond = true;
boolean onGround = true;
boolean[] keys = new boolean[4];
boolean beDrawn, started, change, fallOff, fall, stage1; //true/false variables
String marioCondition;

PImage[] flag = new PImage[4]; //flag sprite

PFont marioWorld, world, start, marioWorld2; //fonts

void setup() {
  size(800, 800); //canvas size
  mario1 = new Mario(); //main character objects
  
  //fonts used in program
  marioWorld = createFont("SuperMario256.ttf", 85);
  world = createFont("SuperMario256.ttf", 200);
  start = createFont("Pixelation.ttf", 40);
}

void draw() { //main body
  flagCa++; //increase counter
  println(started, consY[0], x, y);
  translate(translate, 0); // translate for background scrolling
  background(0); //black background
  if (key == ' ') started = true; //space to start game
  if (started) { //if the game has started
    if (!stage1) { //if the level is incomplete
    //help guide & start level & movement functions
      textAlign(LEFT, LEFT);
      fill(255);
      textFont(start);
      text("Use the arrow keys to move and jump!", 50, 50, 550, 600);
      level1();
      mario1.move();
    } else {
      levelComplete();
    }
  } else {
    startScreen();
  }
}

class Mario {
  PImage[] marioSprite = new PImage[11];
  int sprite = 0;
  PImage origiMario = loadImage("mario.png");

  Mario() {
    for (int loc = 200; loc < 300; loc += 30) { 
      marioSprite[(loc-290)/(-30)] = origiMario.get(loc, 50, 30, 35);
    }
    for (int loc = 84; loc <= 204; loc += 30) { 
      marioSprite[(loc+36)/30] = origiMario.get(loc, 50, 30, 35);
    }
    //jumping mario
    for (int loc = 20; loc <= 350; loc += 330) {
      marioSprite[(loc+2950)/330] = origiMario.get(loc, 50, 30, 35);
    }
  }

  void move() {
    if (onGround) {
      fall = false;
      if (!change) targetY = 760;
      if (keys[0] && keys[1]) {
        show(x, targetY, "STAY-RIGHT");
      } else if (keys[0] && !keys[1] && !keys[2] && !keys[3]) {
        show(x, targetY, "RIGHT");
        x += 1;
        cond = true;
        direction = true;
      } else if (!keys[0] && keys[1] && !keys[2] && !keys[3]) {
        show(x, targetY, "LEFT");
        x -= 1;
        cond = false;
        direction = false;
      } else if (keys[2] && !keys[3] && (keys[1] || keys[0])) {
        count = x;
        onGround = false;
        beDrawn = false;
        canSetY = 0;
        target = s;
        if (keys[0] && !keys[1]) {
          r = x;
          s = x+100;
          x++;
          cond = true;
          y = targetY-(m*(x-r)*(x-s));
          show(x, y, "RIGHT-UP");
          count++;
        }
        if (keys[1] && !keys[0]) {
          r = x;
          s = x-100;
          x--;
          cond = false;
          y = targetY-(m*(x-r)*(x-s));
          show(x, y, "LEFT-UP");
          count--;
        }
        calcX = x;
      } else if (cond) {
        show(x, targetY, "STAY-RIGHT");
      } else if (!cond) {
        show(x, targetY, "STAY-LEFT");
      }
      calcX = x;
    } else {
      if (fall) {
        y += 5;
        if (y > jumpTarget) {
          targetY = jumpTarget;
          onGround = true;
        }
        marioCondition = cond ? "RIGHT-UP" : "LEFT-UP";
        show(x, y, marioCondition);
      } else if (cond) {
        if (y < jumpTarget) {
          calcX++;
          if (keys[2] == false && canSetY == 0) {
            beDrawn = true;
            canSetY++;
          }
          if (beDrawn && keys[2] && canSetY == 1) {
            targetY = y;
            canSetY++;
            target = s + (s-calcX) + 100;
            r = calcX;
            s = r+100;
          }
          calcY = targetY-(m*(calcX-r)*(calcX-s));
          if (calcY < consY[0]) fall = true;
          y = constrain(calcY, consY[0], consY[1]);
          show(x, y, "RIGHT-UP");
          count++;
        } else {
          targetY = jumpTarget;
          onGround = true;
          show(x, targetY, "STAY-RIGHT");
        }
      } else {
        if (y < jumpTarget) {
          if (keys[2] == false && canSetY == 0) {
            beDrawn = true;
            canSetY++;
          }
          if (beDrawn && keys[2] && canSetY == 1) {
            targetY = y;
            canSetY++;
            target = calcX + (calcX-s) + 100;
            r = calcX;
            s = r-100;
          }
          calcX--;
          calcY = targetY-(m*(calcX-r)*(calcX-s));
          if (calcY < consY[0]) fall = true;
          y = constrain(calcY, consY[0], consY[1]);
          show(x, y, "LEFT-UP");
          count --;
          println(y, canSetY, targetY, consY[0], consY[1]);
        } else {
          targetY = jumpTarget;
          onGround = true;
          show(x, targetY, "STAY-LEFT");
        }
      }
    }
    x = constrain(calcX, consX[0], consX[1]);
  }

  void show(int x, float y, String condition) {
    if (flagCa % 10 == 0) sprite = (sprite+1) % 4;
    if (condition == "RIGHT") {
      image(marioSprite[sprite], x, y);
      //delay(100);
    }
    if (condition == "STAY-RIGHT") {
      image(marioSprite[3], x, y);
    }
    if (condition == "LEFT") {
      image(marioSprite[sprite+4], x, y);
      //delay(100);
    }
    if (condition == "STAY-LEFT") {
      image(marioSprite[7], x, y);
    }
    if (condition == "RIGHT-UP") {
      image(marioSprite[10], x, y);
    }
    if (condition == "LEFT-UP") {
      image(marioSprite[9], x, y);
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    keys[0] = true;
  }
  if (keyCode == LEFT) {
    keys[1] = true;
  }
  if (keyCode == UP) {
    keys[2] = true;
  }
  if (keyCode == DOWN) {
    keys[3] = true;
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    keys[0] = false;
  }
  if (keyCode == LEFT) {
    keys[1] = false;
  }
  if (keyCode == UP) {
    keys[2] = false;
  }
  if (keyCode == DOWN) {
    keys[3] = false;
  }
}

void level1() {
  float stagex, stagey;
  while (flag[3] == null) {
    flag[i/16] = loadImage("flags.png").get(i, 17, 11, 16);
    flag[i/16].resize(25, 0);
    i += 16;
  }
  if (x > 1150) {
    stage1 = true;
    translate = 800;
  }
  if (!stage1) {
    stagex = 600;
    stagey = 600;
    fill(#14D89C);
    noStroke();
    if (flagCa%15 == 0) f = (f+1) % 3;
    image(flag[f], 1175, 560);
    rect(stagex, stagey, 600, 10);
    if ((x > stagex-15) && ((y < (stagey)) && (y > (stagey-40))) && !turned) {
      targetY = stagey-40;
      change = true;
      jumpTarget = stagey-40;
      fallOff = true;
      onGround = true;
      if (x == 770 && cond) {
        translate = -800;
        turned = true;
        consX[0] = 800;
        consX[1] = 1175;
      }
    } else if (turned) {
      jumpTarget = stagey-40;
      if (!cond && (x == 800)) {
        turned = false;
        translate = 0;
        consX[0] = 0;
        consX[1] = width-30;
        calcX = x;
      }
    } else if (y < stagey && x == consX[1] && cond) {
      translate = -800;
      turned = true;
      consX[0] = 800;
      consX[1] = 1175;
    } else if (fallOff && onGround) {
      jumpTarget = 760;
      targetY = 760;
      cond = false;
      onGround = false;
      count = x;
      beDrawn = false;
      r = x+50;
      s = x-50;
      calcX = x;
      fallOff = false;
      falling = true;
    } else if ((x > (stagex-30)) && (y > (stagey+15))) {
      consY[0] = (stagey+15);
      jumpTarget = 760;
      change = false;
    } else if (((x > stagex-30) && (x < stagex-10)) && ((y < (stagey)) && (y > (stagey-40))) && !falling) {
      fall = true;
      jumpTarget = 760;
    } else if (falling && y == 760) {
      falling = false;
    } else {
      jumpTarget = 760;
      consY[0] = 0;
    }
  }
}

void startScreen() {
  stage1 = false;
  textFont(marioWorld);
  fill(#E83636);
  textAlign(CENTER, BOTTOM);
  text("Sub-Par Mario", width/2, height/2-100);
  textFont(world);
  fill(#36E8A8);
  textAlign(CENTER, TOP);
  text("World", width/2, height/2-100);
  startCount++;
  if (startCount == 65) startCount = 0;
  if (startCount < 40) {
    fill(255);
    textFont(start);
    text("Press SPACE to begin", width/2, height - 200);
  }
}