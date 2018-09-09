//Larger circes
float y = 590; //y sets up variable for y value of circle
float x = 160; //x sets up variable for x value of circle
float sLarge = 115; //s sets up variable for size of the larger circle

//Smaller circles
float sizeSmall = 10; //sets smallCircle size
float smallx = 0; //sets small x location
float smally = 0; //sets small circle y location

void setup() {
  //Set screen size
  size(320,600);
}

void draw(){
  //Circles drawn upwards
  ellipse(x, y, sLarge, sLarge);
  //Circle drawn diagonally
  ellipse(smallx, smally, sizeSmall, sizeSmall);
  //Adjust variables to make the next copy
  y = y - 10;
  x = x + 0.5;
  sLarge = sLarge - 1.75;
  sizeSmall = sizeSmall + 0.15;
  smallx = smallx + 0.9;
  smally = smally + 1.25;
}