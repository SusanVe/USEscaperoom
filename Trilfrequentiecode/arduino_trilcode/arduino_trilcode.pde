char val;                          // Data received from the serial port 
int pin1 = 3;  
int pin2 = 4;
int pin3 = 5;
int pin4 = 6;
int pin5 = 7;
int pin6 = 8;
int pin7 = 9;
int pin8 = 10;
int pin9 = 11;
int pin0 = 12;
int powerVib = 153;                // Power set to 60%
int waitTime = 300;                // Set duration of the vibration

void setup() { 
  pinMode(pin3, OUTPUT);         // Set pin as OUTPUT 
  Serial.begin(9600);              // Start serial communication at 9600 bps 
} 
 
void loop() { 
  if (Serial.available()) {        // If data is available to read, 
    val = Serial.read();           // read it and store it in val 
  } 
  if (val == 'G') {                // If G was received
    oneVib();
    val = 0;
  } else if (val == 'H') {         // If H was received
    twoVib();
    val = 0;
  } else if (val == 'I') {         // If I was received
    threeVib();
    val = 0;  
  }
}


void oneVib() {
    analogWrite(pin3, powerVib);    // vibrate once
    delay(waitTime);
    analogWrite(pin3, 0);
}

void twoVib() {
    for (int counter = 1; counter <= 2; counter++) {
    analogWrite(pin3, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(pin3, 0);
    delay(waitTime);
    }
}

void threeVib() {
    for (int counter = 1; counter <= 3; counter++) {
    analogWrite(pin3, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(pin3, 0);
    delay(waitTime);
    }
}

void fourVib() {
    for (int counter = 1; counter <= 4; counter++) {
    analogWrite(pin3, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(pin3, 0);
    delay(waitTime);
    }
}