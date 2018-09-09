/* @program: mario2 //<>//
    This program recreates a mario level, complete with controls. Jump with up arrow key while
  simultaneously pressing right/left key. Jump twice while pressing up arrow in the air.
  @author: Arun B
  @Mr Ghorvei
  @John Fraser SS
*/

Mario mario1;

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
      text("Use the arrow keys to move and jump! Press the up arrow simultaneously with the left/right keys to jump. Jump again while jumping to jump twice!", 50, 50, 550, 600);
      level1(); //create the background
      mario1.move(); //movement function
    } else { //else stage is completed
      levelComplete(); //run level complete screen
    } //end if/else
  } else { //if game has not started
    startScreen(); //run start screen
  }
}

class Mario { //mario character functions
  PImage[] marioSprite = new PImage[11]; //sprite array
  int sprite = 0; //sprite counter
  PImage origiMario = loadImage("mario.png"); //load image

  Mario() { //constructor classs
    //load moving mario sprites
    for (int loc = 200; loc < 300; loc += 30) { //
      marioSprite[(loc-290)/(-30)] = origiMario.get(loc, 50, 30, 35);
    }
    //load standing still mario sprites
    for (int loc = 84; loc <= 204; loc += 30) { 
      marioSprite[(loc+36)/30] = origiMario.get(loc, 50, 30, 35);
    }
    //load jumping mario sprites
    for (int loc = 20; loc <= 350; loc += 330) {
      marioSprite[(loc+2950)/330] = origiMario.get(loc, 50, 30, 35);
    }
  }

  void move() { //movement mechanics
    if (onGround) { //if it is on the ground
      fall = false; //it is not falling
      if (!change) targetY = 760; //if it is not the platform
      if (keys[0] && keys[1]) { //if both keys are pressed
        show(x, targetY, "STAY-RIGHT"); //still image
      } else if (keys[0] && !keys[1] && !keys[2] && !keys[3]) { //to move right
        show(x, targetY, "RIGHT");
        x += 1;
        cond = true; //moving right = true
        direction = true;
      } else if (!keys[0] && keys[1] && !keys[2] && !keys[3]) { //if it is moving left
        show(x, targetY, "LEFT");
        x -= 1;
        cond = false; //moving right is false
        direction = false;
      } else if (keys[2] && !keys[3] && (keys[1] || keys[0])) { //if up keys and either right/left are pressed
        count = x;
        onGround = false;
        beDrawn = false;
        canSetY = 0;
        target = s;
        if (keys[0] && !keys[1]) { //if right arrow key with up arrow key
          r = x;
          s = x+100;
          x++;
          cond = true;
          y = targetY-(m*(x-r)*(x-s));
          show(x, y, "RIGHT-UP");
          count++;
        }
        if (keys[1] && !keys[0]) { //if left arrow with up arrow key
          r = x;
          s = x-100;
          x--;
          cond = false;
          y = targetY-(m*(x-r)*(x-s));
          show(x, y, "LEFT-UP");
          count--;
        }
        calcX = x;
      } else if (cond) { //no keys are pressed and last faced right
        show(x, targetY, "STAY-RIGHT");
      } else if (!cond) { //no keys are pressed and last faced-left
        show(x, targetY, "STAY-LEFT");
      }
      calcX = x;
    } else { //the sprite is not on the ground (i.e. jumping)
      if (fall) { //falling when it encounters a boundary on its head
        y += 5; //falling down
        if (y > jumpTarget) { //if y reaches the ground
          targetY = jumpTarget;
          onGround = true;
        }
        marioCondition = cond ? "RIGHT-UP" : "LEFT-UP"; //depending on last faced direction, show respective jump position
        show(x, y, marioCondition);
      } else if (cond) { //facing left and jumping
        if (y < jumpTarget) {
          calcX++;
          if (keys[2] == false && canSetY == 0) { //if the jump button is released
            beDrawn = true;
            canSetY++;
          }
          if (beDrawn && keys[2] && canSetY == 1) { //if jump is pressed again, for double jump
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
        } else { //if it reached the target, reset variable
          targetY = jumpTarget; //set y to jump target
          onGround = true; //set the character on the ground
          show(x, targetY, "STAY-RIGHT"); //show a standing still sprite
        }
      } else { //else it's jumping to the left
        if (y < jumpTarget) {
          if (keys[2] == false && canSetY == 0) { //detect if jump is released
            beDrawn = true;
            canSetY++;
          }
          if (beDrawn && keys[2] && canSetY == 1) { //detect if jump is pressed again, set the jump again
            targetY = y;
            canSetY++;
            target = calcX + (calcX-s) + 100;
            r = calcX;
            s = r-100;
          }
          calcX--;
          calcY = targetY-(m*(calcX-r)*(calcX-s)); //calculate the y using a parabolic formula
          if (calcY < consY[0]) fall = true;
          y = constrain(calcY, consY[0], consY[1]); 
          show(x, y, "LEFT-UP");
          count --;
          println(y, canSetY, targetY, consY[0], consY[1]);
        } else { //else its reached the target height
          targetY = jumpTarget; //change the display variable to the target
          onGround = true; //set it on the ground
          show(x, targetY, "STAY-LEFT"); //display the show mario standing still image
        }
      }
    }
    x = constrain(calcX, consX[0], consX[1]); //constrain x to boundary
  }

  void show(int x, float y, String condition) { //show the sprite
    if (flagCa % 10 == 0) sprite = (sprite+1) % 4; //when the counter reaches 10, change the sprite image
    if (condition == "RIGHT") { //if it is the RIGHT condition 
      image(marioSprite[sprite], x, y);
    }
    if (condition == "STAY-RIGHT") { //if it is STANDING SILL RIGHT condition
      image(marioSprite[3], x, y);
    }
    if (condition == "LEFT") { //if it is the LEFT condition
      image(marioSprite[sprite+4], x, y);
    }
    if (condition == "STAY-LEFT") { //if it is STANDING STILL LEFT condition
      image(marioSprite[7], x, y);
    }
    if (condition == "RIGHT-UP") { //if it's the JUMP RIGHT condition
      image(marioSprite[10], x, y);
    }
    if (condition == "LEFT-UP") { //if it's the JUMP LEFT condition
      image(marioSprite[9], x, y);
    }
  }
}

void keyPressed() { //key pressed variables
  if (keyCode == RIGHT) { //if pressed, set certain boolean array to true
    keys[0] = true;
  }
  if (keyCode == LEFT) { //if pressed, set certain boolean array to true
    keys[1] = true;
  }
  if (keyCode == UP) { //if pressed, set certain boolean array to true
    keys[2] = true;
  }
  if (keyCode == DOWN) { //if pressed, set certain boolean array to true
    keys[3] = true;
  }
}

void keyReleased() { 
  if (keyCode == RIGHT) { //if pressed, set certain boolean array to false
    keys[0] = false;
  }
  if (keyCode == LEFT) { //if pressed, set certain boolean array to false
    keys[1] = false;
  }
  if (keyCode == UP) { //if pressed, set certain boolean array to false
    keys[2] = false;
  }
  if (keyCode == DOWN) { //if pressed, set certain boolean array to false
    keys[3] = false;
  }
}

void level1() { //start level one
  float stagex, stagey;
  while (flag[3] == null) { //if the flag array is null, then set it
    flag[i/16] = loadImage("flags.png").get(i, 17, 11, 16);
    flag[i/16].resize(25, 0); //resize each image
    i += 16;
  }
  if (x > 1150) { //if it reaches the flag
    stage1 = true; //reset the game
    translate = 800;
  }
  if (!stage1) { //if game is incomplete
    stagex = 600;
    stagey = 600;
    fill(#14D89C);
    noStroke();
    if (flagCa%15 == 0) f = (f+1) % 3; //flag refresh rate
    image(flag[f], 1175, 560); //show the flag sprite
    rect(stagex, stagey, 600, 10);
    if ((x > stagex-15) && ((y < (stagey)) && (y > (stagey-40))) && !turned) {  //if it reaches the platform
      targetY = stagey-40; //set the ground value to the platform
      change = true;
      jumpTarget = stagey-40; //set the jump target value to platform
      fallOff = true;
      onGround = true; //set that it reaches the ground
      if (x == 770 && cond) { //if it is on the platform and is on the boundary
        translate = -800; //translate screen to the right
        turned = true;
        consX[0] = 800; //set new constraint value
        consX[1] = 1175; //set new constraint value
      }
    } else if (turned) { // if it's past the boundary
      jumpTarget = stagey-40; //set jump target to platform
      if (!cond && (x == 800)) { //if the player goes back
        turned = false;
        translate = 0;
        consX[0] = 0; //reset constrain values back to normal
        consX[1] = width-30; //reset constrain values back to normal
        calcX = x;
      }
    } else if (y < stagey && x == consX[1] && cond) { //if player is jumping while crossing the boundary
      translate = -800; //move background to the left
      turned = true;
      consX[0] = 800; //new constrain values
      consX[1] = 1175; //new constrain values
    } else if (fallOff && onGround) { //if the players falls off the platform
    //set values to jump player down to ground
      jumpTarget = 760;
      targetY = 760;
      cond = false;
      onGround = false;
      count = x;
      beDrawn = false; //don't allow for double jump
      r = x+50; //intercept values
      s = x-50; //intercept values
      calcX = x;
      fallOff = false;
      falling = true;
    } else if ((x > (stagex-30)) && (y > (stagey+15))) { //if player is under the platform
      consY[0] = (stagey+15); //set y constrain to be under the platform
      jumpTarget = 760;
      change = false;
    } else if (((x > stagex-30) && (x < stagex-10)) && ((y < (stagey)) && (y > (stagey-40))) && !falling) { //if the character is on level with the platform while jumping but not above
      fall = true;
      jumpTarget = 760;
    } else if (falling && y == 760) { //if it reaches the ground after falling
      falling = false; //set falling to false
    } else {
      jumpTarget = 760; //else set target to 760
      consY[0] = 0; //release y constrains
    }
  }
}

void startScreen() { //start screen page
  stage1 = false; //reset stage
  textFont(marioWorld); //title text
  fill(#E83636);
  textAlign(CENTER, BOTTOM);
  text("Sub-Par Mario", width/2, height/2-100);
  textFont(world);
  fill(#36E8A8);
  textAlign(CENTER, TOP);
  text("World", width/2, height/2-100);
  startCount++; //flashing variable
  if (startCount == 65) startCount = 0;
  if (startCount < 40) { //flash for every 40 program cycles
    fill(255);
    textFont(start);
    text("Press SPACE to begin", width/2, height - 200);
  }
}