char val;                          // Data received from the serial port 
int compabc = 2;                   // Vibration componenten for 'ABC'
int compdef = 3;                   // Vibration componenten for 'DEF'
int compghi = 4;                   // Vibration componenten for 'GHI'
int compjkl = 5;                   // Vibration componenten for 'JKL'
int compmno = 6;                  // Vibration componenten for 'MNO'
int comppqrs = 7;                 // Vibration componenten for 'PQRS'
int comptuv = 8;                   // Vibration componenten for 'TUV'
int compwxyz = 9;                  // Vibration componenten for 'WXYZ'
int compspace = 10;                 // Vibration componenten for space
int comp1 = 11;                     // Vibration component for number one

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
      val = 0;
    break;
    case 'b':
      twoVib(compabc);
      val = 0;
    break;
    case 'c':
      threeVib(compabc);
      val = 0;
    break;
    case 'd':
      oneVib(compdef);
      val = 0;
    break;
    case 'e':
      twoVib(compdef);
      val = 0;
    break;
    case 'f':
      threeVib(compdef);
      val = 0;
    break;
    case 'g':
      oneVib(compghi);
      val = 0;
    break;
    case 'h':
      twoVib(compghi);
      val = 0;
    break;
    case 'i':
      threeVib(compghi);
      val = 0;
    break;
    case 'j':
      oneVib(compjkl);
      val = 0;
    break;
    case 'k':
      twoVib(compjkl);
      val = 0;
    break;
    case 'l':
      threeVib(compjkl);
      val = 0;
    break;
    case 'm':
      oneVib(compmno);
      val = 0;
    break;
    case 'n':
      twoVib(compmno);
      val = 0;
    break;
    case 'o':
      threeVib(compmno);
      val = 0;
    break;
    case 'p':
      oneVib(comppqrs);
      val = 0;
    break;
    case 'q':
      twoVib(comppqrs);
      val = 0;
    break;
    case 'r':
      threeVib(comppqrs);
      val = 0;
    break;
    case 's':
      fourVib(comppqrs);
      val = 0;
    break;
    case 't':
      oneVib(comptuv);
      val = 0;
    break;
    case 'u':
      twoVib(comptuv);
      val = 0;
    break;
    case 'v':
      threeVib(comptuv);
      val = 0;
    break;
    case 'w':
      oneVib(compwxyz);
      val = 0;
    break;
    case 'x':
      twoVib(compwxyz);
      val = 0;
    break;
    case 'y':
      threeVib(compwxyz);
      val = 0;
    break;
    case 'z':
      fourVib(compwxyz);
      val = 0;
    break;
    case ' ':
      oneVib(compspace);
      val = 0;
    break;
    case '1':
      oneVib(comp1);
      val = 0;
    break;
  }
}


void oneVib(int compNr) {
    digitalWrite(compNr, HIGH);    // vibrate once
    delay(waitTime);
    digitalWrite(compNr, LOW);
}

void twoVib(int compNr) {
    for (int counter = 1; counter <= 2; counter++) {
    digitalWrite(compNr, HIGH);    // vibrate four times
    delay(waitTime);
    digitalWrite(compNr, LOW);
    delay(waitTime);
    }
}

void threeVib(int compNr) {
    for (int counter = 1; counter <= 3; counter++) {
    digitalWrite(compNr, HIGH);    // vibrate four times
    delay(waitTime);
    digitalWrite(compNr, LOW);
    delay(waitTime);
    }
}

void fourVib(int compNr) {
    for (int counter = 1; counter <= 4; counter++) {
    digitalWrite(compNr, HIGH);    // vibrate four times
    delay(waitTime);
    digitalWrite(compNr, LOW);
    delay(waitTime);
    }
}
