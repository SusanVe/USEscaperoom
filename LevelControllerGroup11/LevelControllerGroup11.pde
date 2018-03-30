import nl.tue.id.oocsi.*;
import nl.tue.id.oocsi.client.services.*;

// ******************************************************
// This example requires a running OOCSI server!
//
// How to do that? Check: Examples > Tools > LocalServer
//
// More information how to run an OOCSI server
// can be found here: https://iddi.github.io/oocsi/)
// ******************************************************

int step = 0;

OOCSI oocsi;

void setup() {
  size(200, 200);
  noStroke();

  // connect to OOCSI server running on the same machine (localhost)
  // with "receiverName" to be my channel others can send data to
  // (for more information how to run an OOCSI server refer to: https://iddi.github.io/oocsi/)
  oocsi = new OOCSI(this, "LE_level_controller_group11_1", "localhost");

  // subscribe to all relevant channels
  oocsi.subscribe("LE_nfc_tags");
  oocsi.subscribe("LE_plate");
  oocsi.subscribe("LE_painting");
  oocsi.subscribe("LE_safe");
  oocsi.subscribe("LE_beating_heart");

  // start by resetting
  levelReset();
}


void LE_nfc_tags(OOCSIEvent event) {
  // tags get scanned ncf module code should send the code and the string below
  if (event.has("ncf scanned")) {
    String code = event.getString("code entered"); 
    step = 1;
  }
}


void LE_painting(OOCSIEvent event) {
  // if nfc tags are scannend in right order, painting and plate should turn on
  if (step == 1) {
    oocsi.channel("LE_plate").data("vibrate", true).send();
    oocsi.channel("LE_painting").data("light up", true).send();
  }
  // if right code is pressed/enter, painting module code should send string below
  if(event.has("painting code entered")){
    step = 2;
  }
}

void LE_safe(OOCSIEvent event) {
  // if right code is pressed/enter, safe should turn on
  if ( step == 2){
    oocsi.channel("LE_safe").data("activate laser", true).send();
  }
  // if safe is opened, safe module code should send string below
  if (event.has("safe open")) {
    step = 3;
  }
}

void LE_beating_heart(OOCSIEvent event) {

}

void levelReset() {
 step = 0;
}