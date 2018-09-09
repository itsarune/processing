/*
@program: Ex7
 This program draws cicles along the first half that slowly becomes lighter and in 
 the second half creates multiple pink circles that slowly become pinker.
@author: Arun B
@course: ICS2
@John Fraser SS
*/

void setup() { //start setup()
  size(320, 600); //canvas size
}

void draw() { //start draw()
  
  background(255); //set a white background
  
  stroke(0); //set to black stroke
  //loop until all the columns of circles are created
  for(int i = 10; i <= 320; i += 20) {
    int colour = 0; //set colour to black
    for(int y = 10; y <= 315; y += 20) { //loop until the row of columns are created
      fill(colour); //set the grey shade
      ellipse(i,y,20,20); //create the ellipses
      colour += 16; //change to a lighter greyscale shade
    } //end "for" statement for the rows of circles
  } //end "for" statement for the columns of circles
  
  //create the pink circle drawings
  noStroke(); //remove a stroke
  for(int i = 215; i > 0 ; i -= 1) { //loop until the pink circles are created
    //create a pink colour starting at a light shade to a darker shade
    fill(255, i, 255);
    //create the circles growing slowly smaller to create the effect
    ellipse(160, 450, i, i);
  } //end this loop after all the circles are created
    
} //end draw()