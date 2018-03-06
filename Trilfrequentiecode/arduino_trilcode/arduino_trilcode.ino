char val;                          // Data received from the serial port 
int compabc = 3;                   // Vibration componenten for 'ABC'
int compdef = 5;                   // Vibration componenten for 'DEF'
int compghi = 6;                   // Vibration componenten for 'GHI'
int compjkl = 9;                   // Vibration componenten for 'JKL'
int compmno = 10;                  // Vibration componenten for 'MNO'
int comppqrs = 11;                 // Vibration componenten for 'PQRS'
int comptuv = 0;                   // Vibration componenten for 'TUV'
int compwxyz = 0;                  // Vibration componenten for 'WXYZ'
int compspace = 0;                 // Vibration componenten for space

int powerVib = 153;                // Power set to 60% (153/255) for protection, because of 5v output
int waitTime = 300;                // Set duration of the vibration

void setup() { 
  pinMode(compabc, OUTPUT);         // Set pins as OUTPUT 
  pinMode(compdef, OUTPUT);
  pinMode(compghi, OUTPUT);
  pinMode(compjkl, OUTPUT);
  pinMode(compmno, OUTPUT);
  pinMode(comppqrs, OUTPUT);
  pinMode(comptuv, OUTPUT);
  pinMode(compwxyz, OUTPUT);
  pinMode(compspace, OUTPUT);
  Serial.begin(9600);              // Start serial communication at 9600 bps 
} 
 
void loop() {
  if (Serial.available()) {        // If data is available to read, 
    val = Serial.read();           // read it and store it in val 
  }

  switch(val) {

    case 'a':
      oneVib(compabc);
    break;
    case 'b':
      twoVib(compabc);
    break;
    case 'c':
      threeVib(compabc);
    break;
    case 'd':
      oneVib(compdef);
    break;
    case 'e':
      twoVib(compdef);
    break;
    case 'f':
      threeVib(compdef);
    break;
    case 'g':
      oneVib(compghi);
    break;
    case 'h':
      twoVib(compghi);
    break;
    case 'i':
      threeVib(compghi);
    break;
    case 'j':
      oneVib(compjkl);
    break;
    case 'k':
      twoVib(compjkl);
    break;
    case 'l':
      threeVib(compjkl);
    break;
    case 'm':
      oneVib(compmno);
    break;
    case 'n':
      twoVib(compmno);
    break;
    case 'o':
      threeVib(compmno);
    break;
    case 'p':
      oneVib(comppqrs);
    break;
    case 'q':
      twoVib(comppqrs);
    break;
    case 'r':
      threeVib(comppqrs);
    break;
    case 's':
      fourVib(comppqrs);
    break;
    case 't':
      oneVib(comptuv);
    break;
    case 'u':
      twoVib(comptuv);
    break;
    case 'v':
      threeVib(comptuv);
    break;
    case 'w':
      oneVib(compwxyz);
    break;
    case 'x':
      twoVib(compwxyz);
    break;
    case 'y':
      threeVib(compwxyz);
    break;
    case 'z':
      fourVib(compwxyz);
    break;
    case ' ':
      oneVib(compspace);
    break;
  }
}


void oneVib(int compNr) {
    analogWrite(compNr, powerVib);    // vibrate once
    delay(waitTime);
    analogWrite(compNr, 0);
}

void twoVib(int compNr) {
    for (int counter = 1; counter <= 2; counter++) {
    analogWrite(compNr, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(compNr, 0);
    delay(waitTime);
    }
}

void threeVib(int compNr) {
    for (int counter = 1; counter <= 3; counter++) {
    analogWrite(compNr, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(compNr, 0);
    delay(waitTime);
    }
}

void fourVib(int compNr) {
    for (int counter = 1; counter <= 4; counter++) {
    analogWrite(compNr, powerVib);    // vibrate four times
    delay(waitTime);
    analogWrite(compNr, 0);
    delay(waitTime);
    }
}
