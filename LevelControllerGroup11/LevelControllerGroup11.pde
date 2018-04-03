import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.services.*;
import java.util.*;
import java.io.*;

// ******************************************************
// This example requires a running OOCSI server!
//
// How to do that? Check: Examples > Tools > LocalServer
//
// More information how to run an OOCSI server
// can be found here: https://iddi.github.io/oocsi/)
// ******************************************************

int step = 0;
//TODO mag dit weg?
//hij huilt als ik deze weg wil halen
String[] order = new String[4];
order[0] = "blue";
order[1] = "red";
order[2] = "yellow";
order[3] = "green";

String message = "apple pear cherry";


//poging twee tot checkmethod
boolean fullColor = false; 
ArrayList<String> correctColors = new ArrayList<String>(); 
ArrayList<String> colors = new ArrayList<String>(); 
correctColors.add("blue");
correctColors.add("red");
correctColors.add("yellow");
correctColors.add("green"); 
int counter = 0; 

OOCSI oocsi;

void setup() {
  size(200, 200);
  noStroke();

  // connect to OOCSI server running on the same machine (localhost)
  // with "receiverName" to be my channel others can send data to
  // (for more information how to run an OOCSI server refer to: https://iddi.github.io/oocsi/)
  oocsi = new OOCSI(this, "LE_level_controller_group11_1", "localhost");

  // subscribe to all relevant channels
  oocsi.subscribe("Group7NFC");
  oocsi.subscribe("LE_colorbox");
  oocsi.subscribe("LE_safe");
  oocsi.subscribe("schoenmaat"); //heartbeat channel 

  // start by resetting
  levelReset();
}

void heartBeat(OOCSIEvent event) {
  //op het begin hart langzaam laten kloppen, alles doorgegeven want variabelen hadden (dacht ik) geen initiële waarden 
  if(step == 0){
    oocsi.channel("schoenmaat").data("intervalA",1).send();
    oocsi.channel("schoenmaat").data("intervalB",0).send();
    oocsi.channel("schoenmaat").data("intervalC",0).send();
    oocsi.channel("schoenmaat").data("intervalD",0).send();
    oocsi.channel("schoenmaat").data("flatline",0).send();
  }
}

void NFC(OOCSIEvent event) {
  //send 1 to the NFC module to start the scanner
  oocsi.channel("PreviousModule").data("completed", 1);
  // receive color of scanned tag, check the order
  //TODO fix this check thing with strings, because this only works for 1 iteration.
  /*if (event.has("colour")) {
    String colour = event.getString("colour"); 
    String[] scanOrder = new String[4];
    for (int i = 0; i < scanOrder.length; i++) {
      scanOrder[i] = colour;
      if(order == scanOrder) {
      step = 1;
      } else {
        //TODO increase heartbeat once we receive their code
        //TODO send to right heartbeatchannel
    }
  } */
  
  /* 
  - boolean is false
  - array maken en daar alle colors instoppen (als deze er nog niet in zitten)
  - als array lang genoeg is
  - boolean true
  - hierna checken of juiste combi
  - foute combi, heartbeat sneller
  - juiste combi, plate aan 
  */
  
    if(!fullColor){
       if(event.has("colour")){
         String color = event.getString("colour");
         if(!colors.contains(color)){
           colors.add(color); 
         }
       }
    }
  
   if(colors.length() == 4){
     fullColor = true; 
     if(colors.equals(correctColors){
         //go to next module, plate and decrease heartbeat
         step = 1; 
         counter--;
         checkBeat(); 
     }
     else {
         colors.clear(); 
         fullColor = false;  
         counter++; 
         //everytime the nfc tags get scanned in the wrong order, increase heartbeat
         checkBeat(); 
     }
   }
  
}

//TODO check even of dit werkt? Anders alle if'jes in de if else statement hierboven zetten
 public void checkBeat(){
         if(counter == 1){
            oocsi.channel("schoenmaat").data("intervalA",0).send();
            oocsi.channel("schoenmaat").data("intervalB",1).send();
         }
         else if(counter == 2) {
            oocsi.channel("schoenmaat").data("intervalB",0).send();
            oocsi.channel("schoenmaat").data("intervalC",1).send();
         }
         else if(counter == 3) {
            oocsi.channel("schoenmaat").data("intervalC",0).send();
            oocsi.channel("schoenmaat").data("intervalD",1).send();
         }
         else if(counter == 4) {
            oocsi.channel("schoenmaat").data("intervalD",0).send();
            oocsi.channel("schoenmaat").data("flatline",1).send();
            //TODO stop the level, game over levelReset() ??
         }
   }


void thePlate(OOCSIEvent event) {
  // if nfc tags are scannend in right order plate will start outputting
  //colorbox will turn on
  if (step == 1) {
    oocsi.channel("thePlateHandler").data("string", message).send();
    oocsi.channel("LE_ColorBox").data("Turn on", true).send();
    //send colorbox the right code if necessary
  }
  // if right code is pressed/enter, colorbox will return a value
  //TODO subscribe to channel that outputs right code
  if(event.has("right code")){
    step = 2;
  }
}

void LE_safe(OOCSIEvent event) {
  // if right code is pressed/enter, safe should turn on
  // plate should turn off
  // TODO send to receiverchannel
  if (step == 2){
    oocsi.channel("LE_safe").data("safeLaser", 1).send();
    oocsi.channel("thePlateAPI").data("stringCode", "").send();
  }
  // if safe is opened, safe module code should send string below
  // TODO subscribe to channel that outputs completeSafe
  if (event.has("completeSafe")) {
    if(completeSafe > 0) {
      step = 3;
      //flatline after opening safe
      oocsi.channel("schoenmaat").data("intervalA",0).send();
      oocsi.channel("schoenmaat").data("intervalB",0).send();
      oocsi.channel("schoenmaat").data("intervalC",0).send();
      oocsi.channel("schoenmaat").data("intervalD",0).send();
      oocsi.channel("schoenmaat").data("flatline",1).send();
    }
  }
}

void levelReset() {
 step = 0;
}