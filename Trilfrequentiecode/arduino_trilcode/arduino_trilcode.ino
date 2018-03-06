char val;                          // Data received from the serial port 
int ledPin = 3;                    // Set the pin to digital PWM pin 3
int powerVib = 153;                // Power set to 60%
int waitTime = 300;                // Set duration of the vibration

void setup() { 
  pinMode(ledPin, OUTPUT);         // Set pin as OUTPUT 
  Serial.begin(9600);              // Start serial communication at 9600 bps 
} 
 
void loop() { 
  if (Serial.available()) {        // If data is available to read, 
    val = Serial.read();           // read it and store it in val 
  } 
  if (val == 'H') {                // If H was received
    twoVib();
    val = 0;
  } else if (val == 'I') {         // If I was received
    threeVib();
    val = 0;
  } else if (val == '4') {
    fourVib();
    val = 0;  
  }
}


void oneVib() {
    analogWrite(ledPin, powerVib);    // vibrate once
    delay(waitTime);
    analogWrite(ledPin, 0);
}

void twoVib() {
    for (int counter = 1; counter <= 2; counter++) {
    analogWrite(ledPin, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(ledPin, 0);
    delay(waitTime);
    }
}

void threeVib() {
    for (int counter = 1; counter <= 3; counter++) {
    analogWrite(ledPin, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(ledPin, 0);
    delay(waitTime);
    }
}

void fourVib() {
    for (int counter = 1; counter <= 4; counter++) {
    analogWrite(ledPin, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(ledPin, 0);
    delay(waitTime);
    }
}
