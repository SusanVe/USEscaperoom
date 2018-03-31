/* This code is created for the course Technologies for Connectivity at TU/e. 
   Group 7: Iris Bataille, Desirée Driessen, Pascalle Ickenroth & Charlaine Janssen
   March 2018
   
   This code shows the output of our module, this can be blue, red, green or yellow (Receiver)
*/

import nl.tue.id.oocsi.*;

String colour;
int position = 0;
String x;

void setup() {

  // Connect to OOCSI server
  OOCSI oocsi = new OOCSI(this, "ReceiverGroup7", "oocsi.id.tue.nl");

  // Subscribe to channel "Group7NFC"
  oocsi.subscribe("Group7NFC");
}

void Group7NFC(OOCSIEvent event) {
  x = event.getString("colour", "nothing has been sent");
  // Print data that has been sent
  println(x);
}