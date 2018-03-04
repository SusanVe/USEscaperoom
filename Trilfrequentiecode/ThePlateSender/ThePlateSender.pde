
import nl.tue.id.oocsi.*;

OOCSI oocsi; 

void setup() {
  size(500, 500);
  noStroke();
  frameRate(10);
  // Open the port that the board is connected to and use the same speed (9600 bps)  
  OOCSI oocsi = new OOCSI(this, "theplateinput", "oocsi.id.tue.nl");
}

void sendMessage() {
  oocsi
  .channel("testchannelgroup11")
    .data("string", "HI")
      .send();
}