/* //<>//
@program: Exercise6
 Draws all the circles first and then draw a shape that constantly adjusts to reveal
 the background.
@author: Arun B
@Course: ICS2
@John Fraser Secondary School
 */

void setup() { //start setup
  size(320, 600); //canvas size
  background(255); //white bkgd
} //end setup

void draw() { //start draw

  strokeWeight(10); //set circle stroke weight

  //draws row of complete pink circles down and across
  stroke(254, 1, 254); //pink colour
  for (int i = 10; i <= 320; i += 10) { //draw pink circles across the first row
    point(i, 10); //draws the circles
  } //end for statement
  for (int i = 20; i <= 600; i += 10) { //draw pink circles across the first column
    point(10, i); //draws the pink circles
  } //end for statement

  for (int i = 10; i < 600; i += 10) { //draws the rest of the multicoloured circles
    int x = 10; //reset x back to 0 for the new row
    while (x < 320) { //draw pink circles across the row
      stroke(254, (x*i)%255, 254); //set the colour based on the x and y values
      x += 10; //increase x by 10 for the next circle to be draw 10 px after
      point(x, i+10); //draw the circle and offset y by 10 to create the patter
    } //end while statement
  } //end for statement

  /*this shape adjusts based on mouseX and mouseY positions and reveals the background
  as needed*/
  fill(255); //set fill to white again
  noStroke(); //set to no stroke colour
  beginShape(); //create a polygon
  vertex(320, 0); //set a vertex of the shape
  vertex(320, 600); //set a vertex of the shape
  vertex(0, 600); //set a vertex of the shape
  vertex(0, mouseY); //set a moving vertex of the shape
  vertex(mouseX, mouseY); //set a moving vertex of the shape
  vertex(mouseX, 0); //set a moving vertex of the shape
  endShape(); //finish the shape
} //end draw()