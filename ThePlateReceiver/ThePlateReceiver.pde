// Check if the mouse is over a rectangle and write the status to the serial port

import processing.serial.*;
import nl.tue.id.oocsi.*;

Serial port;                       // Create object from Serial class
String message;
String portName;

void setup() {
  // Open the port that the board is connected to and use the same speed (9600 bps)
  OOCSI oocsi = new OOCSI(this, "theplate", "oocsi.id.tue.nl");
  oocsi.register("thePlateHandler");
  delay(2000);
}

void thePlateHandler(OOCSIEvent event, OOCSIData response) {
  if (event.has("string")){
    response.data("result", 1);
  }
  portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);
  message = event.getString("stringCode", "");
  println("");
  char[] charArray = message.toCharArray();
  for (int i = 0; i < charArray.length; i++){
    print(charArray[i]);
    delay(2000);
    port.write(charArray[i]);
  }
  port.stop();
}
