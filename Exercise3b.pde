void setup() {
  //Set screen size
  size(320,600);
}

void draw() {
  //Set up circle
  fill(random(255), random(255), random(255));
  ellipse(random(320),random(600),15,15);
}