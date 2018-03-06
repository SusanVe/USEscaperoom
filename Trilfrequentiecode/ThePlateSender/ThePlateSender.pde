
import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.services.*;

OOCSI oocsi; 

void setup() {
  size(200, 200);
  noStroke();
  frameRate(10);
  // Open the port that the board is connected to and use the same speed (9600 bps)  
  oocsi = new OOCSI(this, "theplateAPI", "oocsi.id.tue.nl");
  noLoop();
}

void draw() {
  String string = "your string";
  int result;
  println("");
  println("Sending to the plate: " + string);
  
  OOCSICall call = oocsi.call("handleOOCSIEvent", 1000).data("stringCode", string);
  call.sendAndWait();
  if (call.hasResponse()) {
    result = call.getFirstResponse().getInt("result", 0);
    println("Your message has been received succesfully and will be outputted" + result);
  }
}