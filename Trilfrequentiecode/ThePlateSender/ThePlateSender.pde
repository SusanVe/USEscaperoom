
import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.services.*;

OOCSI oocsi; 

void setup() {
  size(500, 500);
  noStroke();
  frameRate(10);
  // Open the port that the board is connected to and use the same speed (9600 bps)  
  oocsi = new OOCSI(this, "theplateinput", "oocsi.id.tue.nl");
  noLoop();
}

void draw() {
    oocsi
    .channel("theplate")
      .data("stringCode", "HI")
        .send();  
}