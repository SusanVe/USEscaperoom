char val;                          // Data received from the serial port 
int ledPin = 4;                    // Set the pin to digital I/O 4

void setup() { 
  pinMode(ledPin, OUTPUT);         // Set pin as OUTPUT 
  Serial.begin(9600);              // Start serial communication at 9600 bps 
} 
 
void loop() { 
  if (Serial.available()) {        // If data is available to read, 
    val = Serial.read();           // read it and store it in val 
  } 
  if (val == 'H') {                // If H was received
    digitalWrite(ledPin, HIGH);    // blink once
    digitalWrite(ledPin, LOW);
  } else if (val == 'I') {         // If I was received
    digitalWrite(ledPin, HIGH);    // blink twice 
    digitalWrite(ledPin, LOW);
    digitalWrite(ledPin, HIGH); 
    digitalWrite(ledPin, LOW);
  } else if (val == 'J') {         // If J was received
    digitalWrite(ledPin, HIGH);    // blink three times 
    digitalWrite(ledPin, LOW);
    digitalWrite(ledPin, HIGH); 
    digitalWrite(ledPin, LOW);
    digitalWrite(ledPin, HIGH); 
    digitalWrite(ledPin, LOW);
  } else { 
    digitalWrite(ledPin, LOW);     // Otherwise turn it OFF
  } 
  delay(100);                      // Wait 100 milliseconds for next reading 
} 