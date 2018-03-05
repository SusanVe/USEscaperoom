// Check if the mouse is over a rectangle and write the status to the serial port

import processing.serial.*;
import nl.tue.id.oocsi.*;

Serial port;                       // Create object from Serial class
String message;

void setup() {
  size(500, 500);
  noStroke();
  frameRate(10);
  // Open the port that the board is connected to and use the same speed (9600 bps)
  port = new Serial(this, 9600);   
  OOCSI oocsi = new OOCSI(this, "theplate", "oocsi.id.tue.nl");
  oocsi.subscribe("testchannelgroup11");
}

void receiveString(OOCSIEvent event) {
  message = event.getString("string", "");
  char[] charArray = message.toCharArray(); 
  for (int i = 0; i < charArray.length; i++){ 
  port.write(charArray[i]);
}

/*
void draw() {
  background(255);
  if (mouseOverRect1() == true)  {  // If mouse is over square,
    fill(204);                     // change color and
    port.write('H');               // send an H to indicate mouse is over square
  } else if (mouseOverRect2() == true)  {  // If mouse is over square,
    fill(204);                     // change color and
    port.write('I');               // send an H to indicate mouse is over square
  } else if (mouseOverRect3() == true)  {  // If mouse is over square,
    fill(204);                     // change color and
    port.write('J');               // send an H to indicate mouse is over square
  } else {                         // If mouse is not over square,
    fill(0);                       // change color and
    port.write('L');               // send an L otherwise
  }
  rect(50, 50, 100, 100);  // Draw a square
  rect(200, 50, 100, 100); // Draw another square
  rect(350, 50, 100, 100); // Draw another square
}


boolean mouseOverRect1() {        // Test if mouse is over square
  return ((mouseX >= 50) && (mouseX <= 150) && (mouseY >= 50) && (mouseY <= 150));
}

boolean mouseOverRect2() {        // Test if mouse is over square
  return ((mouseX >= 200) && (mouseX <= 300) && (mouseY >= 50) && (mouseY <= 150));
}

boolean mouseOverRect3() {        // Test if mouse is over square
  return ((mouseX >= 350) && (mouseX <= 450) && (mouseY >= 50) && (mouseY <= 150));
}
*/