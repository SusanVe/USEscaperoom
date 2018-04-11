import nl.tue.id.oocsi.*;

boolean previousmodule = false;
PShape square;

void setup() {
  size(200, 200);
  background(0);
   
  // connect to OOCSI server running on the same machine (localhost)
  // with "receiverName" to be my channel others can send data to
  // (for more information how to run an OOCSI server refer to: https://iddi.github.io/oocsi/)
  OOCSI oocsi = new OOCSI(this, "LE_NFC_1", "oocsi.id.tue.nl");
  oocsi.subscribe("LE_NFC");
}



void LE_NFC(OOCSIEvent event) {
    previousmodule = event.getBoolean("completed",false);
    System.out.println("NFC scanner is on");
  }
  
void draw() {
  if(previousmodule){
    square = createShape(RECT, 0, 0, 50, 50);
    square.setFill(color(5, 5, 255));
    square.setStroke(true);
    System.out.println("test"); 
  }
}