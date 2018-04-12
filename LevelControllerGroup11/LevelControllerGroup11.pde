import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.services.*;
import java.util.*;
import java.io.*;

// ******************
// This example requires a running OOCSI server!
//
// How to do that? Check: Examples > Tools > LocalServer
//
// More information how to run an OOCSI server
// can be found here: https://iddi.github.io/oocsi/)
// ******************

OOCSI oocsi;

int step = 0;
// string that the plate will output through vibrations 
String message = "your goal beat risk";


//needed for checking the colors outputted by nfc
boolean fullColor = false; 
//right order in which to scan the tags
ArrayList<String> correctColors = new ArrayList<String>() {{
    add("blue");
    add("red");
    add("yellow");
    add("green");
}};
ArrayList<String> colors = new ArrayList<String>(1); 
int counter = 0; 


void setup() {
  size(200, 200);
  noStroke();

  // connect to OOCSI server running on the same machine (localhost)
  // with "receiverName" to be my channel others can send data to
  // (for more information how to run an OOCSI server refer to: https://iddi.github.io/oocsi/)
  oocsi = new OOCSI(this, "LE_level_controller_group11_1", "oocsi.id.tue.nl");

  // subscribe to all relevant channels
  oocsi.subscribe("Group7NFC");
  oocsi.subscribe("heartbeatmodule1000"); 
  oocsi.subscribe("Vaultgroup8");
  oocsi.subscribe("theplate");

  // start by resetting
  levelReset();
  thePlate();
}

//method that can be clicked to skip through steps
void draw() {
  background(0);
  text("Level controller:", 15, 20);
  text("Step: " + step, 15, 40);

  if (step == 2) {
    text("Click here to reset", 15, 60);
  }
}

void mousePressed() {
  // you can use the mouse to step through all steps for debugging
  step = (++step) % 3;
  if (step == 0) {
    levelReset();
  }
}

void heartBeat() {
  if(step == 0){
    //sends 1 to heartbeat to turn on the first interval
    oocsi.channel("heartbeatmodule1000").data("interval", 1).send();   
  }
}

void Group7NFC(OOCSIEvent event) {
  //send 1 to the NFC module to start the scanner
  oocsi.channel("GroupNFC").data("completed", 1).send();
  
  //place every color received by nfc (that has not been scanned yet) in an arraylist
  String color1 ="";
  if(!fullColor){
       if(event.has("colour")){
         color1 = event.getString("colour");
         if(!colors.contains(color1)){
           colors.add(color1); 
         }
       }
    }
  
   if(colors.size() == 4){
     fullColor = true; 
     //check if the scanned combination is correct
     if(colors.equals(correctColors)){
         //go to next module, plate and decrease heartbeat
         step = 1; 
         counter--;
         checkBeat(); 
         colors.clear();
     }
     else {
         colors.clear(); 
         fullColor = false;  
         if (counter < 4){
           counter++; 
         }
         //everytime the nfc tags get scanned in the wrong order, increase heartbeat
         checkBeat(); 
     }
   }
    
  
}

//increases heartbeat with every wrong move, flatlines after level is completed
 public void checkBeat(){
         if(counter == 1){          
            oocsi.channel("heartbeatmodule1000").data("interval",2).send();
         }
         else if(counter == 2) {
            oocsi.channel("heartbeatmodule1000").data("interval",3).send();
         }
         else if(counter == 3) {
            oocsi.channel("heartbeatmodule1000").data("interval",4).send();
         }
         else if(step == 2) {
            oocsi.channel("heartbeatmodule1000").data("interval",5).send();
            levelReset();
         }
   }


void thePlate() {
  // if nfc tags are scannend in right order plate will start outputting
  //colorbox will turn on
  if (step == 1) {
    //string that will be outputted by the plate 
    String string = "your goal beat risk";
    int result;
    println("");
    println("Sending to the plate: " + string);
    delay(3000);
    OOCSICall call = oocsi.call("thePlateHandler", 1000).data("stringCode", string);
    
    call.sendAndWait();
    if (call.hasResponse()) {
      result = call.getFirstResponse().getInt("result", 0);
      println("Your message has been received succesfully and will be outputted " + result);
    }
  }
}


//resets the level
void levelReset() {
 step = 0;
 counter = 0; 
}