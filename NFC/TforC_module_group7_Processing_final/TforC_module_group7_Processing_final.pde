/* This code is created for the course Technologies for Connectivity at TU/e. 
   Group 7: Iris Bataille, Desirée Driessen, Pascalle Ickenroth & Charlaine Janssen
   March 2018
   
   This code is the main Processing code of our module.
   It receives an 1 from another processing code (TforC_module_group7_Sender), if the previous module has been completed.
   Besides it can receive 4 different NFC tag codes from the Arduino code.
   The NFC tag codes are translated to a colour name and are sent to another Processing code (TforC_module_group7_Receiver).
   This code only sends the colour name (to TforC_module_group7_Receiver) if it received an 1 before (from TforC_module_group7_Sender).
*/

import nl.tue.id.oocsi.*;                                     // Connect with OOCSI
OOCSI oocsi;
int previousmodule;                                           // Data received from OOCSI

import processing.serial.*;                                   // Establish Serial connection
Serial myPort;                                                // Create object from Serial class
String val;                                                   // Data received from the serial port
String sendoocsi;

void setup() { 
  oocsi = new OOCSI(this, "ModuleGroup7", "oocsi.id.tue.nl"); // Connecting with OOCSI
  oocsi.subscribe("PreviousModule");                          // Subscribe to input channel
  String portName = Serial.list()[0];                         // Connecting with Arduino, find available port
  myPort = new Serial(this, portName, 9600);                  // Connecting with Arduino
}

void PreviousModule(OOCSIEvent event) {                       // Receive if the previous module is completed
  previousmodule = event.getInt("completed", 0);
}

void draw() {

  if (myPort.available() > 0 && previousmodule > 0) {         // If data is available,
    val = myPort.readStringUntil('\n');                       // Read it and store it in val
    println(val);                                             // Print it out in the console
  if (val == null) return;

    println(val.length());    
    println(val.trim().length());    
    if (val.trim().equals("0x36 0x19 0x50 0xAC")) {           // If this nfc chip has been read
      sendoocsi = "blue";                                     // Send the text 'blue' to oocsi
    } else if (val.trim().equals("0x00 0xF2 0xBA 0x29")) {    // If this nfc chip has been read
      sendoocsi = "yellow";                                   // Send the text 'yellow' to oocsi
    } else if (val.trim().equals("0x56 0xCC 0x4A 0xAC")) {    // If this nfc chip has been read
      sendoocsi = "red";                                      // Send the text 'red' to oocsi
    } else if (val.trim().equals("0xED 0xD2 0x92 0x59")) {    // If this nfc chip has been read
      sendoocsi = "green";                                    // Send the text 'green' to oocsi
    }

    oocsi                                                     // Send to OOCSI ...
      // On channel "Group7NFC"...
      .channel("Group7NFC")
      // Data labeled "colour"...
      .data("colour", sendoocsi)
      // Send
      .send();
    }
  }