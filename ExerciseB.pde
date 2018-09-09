void setup() {
    size(800,800);
}

void draw() {
   background(255);
   
   float x = radians(180);
   float y = radians(345);
   
   //Yellow Line
   strokeWeight(30);
   fill(255,0);
   stroke(215, 250, 53);
   arc(345,570, 520, 520, x,y);
   strokeWeight(1);
   fill(215, 250, 53);
   ellipse(345,570,10,10);
   
   //Red Line
   fill(255,0);
   strokeWeight(30);
   stroke(250,53,53);
   arc(345,495, 540, 510, PI, TWO_PI);
   strokeWeight(1);
   fill(250,53,53);
   ellipse(345,495,10,10); 
 
  //Green Line
   fill(255,0);
   strokeWeight(15);
   stroke(53,250,123);
   x = radians(165);
   arc(345,500, 550, 540, x, TWO_PI);
   strokeWeight(0);
   fill(53,250,123);
   ellipse(345,490,10,10);
    
  //Purple Line
   fill(255,0);
   strokeWeight(5);
   stroke(192,53,250);
   x = radians(165);
   arc(345,490, 550, 530, x, TWO_PI);
   strokeWeight(0);
   fill(192,53,250);
   ellipse(345,510,10,10); 
}