/* This code is created for the course Technologies for Connectivity at TU/e. 
   Group 7: Iris Bataille, Desirée Driessen, Pascalle Ickenroth & Charlaine Janssen
   March 2018
   
   This code shows the input of our module, this is always an 1 in this example (Sender).
   The main code of our module needs to receive an 1 from this code to give an output. 
   The 1 means that the previous module has been completed.
*/

import nl.tue.id.oocsi.*;

OOCSI oocsi;

void setup() {
  size(200, 200);
  background(120);
  frameRate(10);

  // Connect to OOCSI server running on "oocsi.id.tue.nl"
  oocsi = new OOCSI(this, "SenderGroup7", "oocsi.id.tue.nl");
}

void draw() {
  // Send to OOCSI ...
  oocsi
    // On channel "PreviousModule", this has to be the channel of the previous module
  .channel("PreviousModule")
    // Data labeled "completed"
    .data("completed", 1)
        .send();
}