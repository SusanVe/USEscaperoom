
import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.services.*;

OOCSI oocsi; 

void setup() {
  size(500, 500);
  noStroke();
  frameRate(10);
  // Open the port that the board is connected to and use the same speed (9600 bps)  
  oocsi = new OOCSI(this, "theplateAPI", "oocsi.id.tue.nl");
  noLoop();
}

void draw() {
  fill(180, 120, 120);
  rect(width/2., height/2., 5 * value, 5 * value);
  println("calling thePlate service with " + string);
  
    oocsi
    .channel("theplate")
      .data("stringCode", string)
        .send();  
}