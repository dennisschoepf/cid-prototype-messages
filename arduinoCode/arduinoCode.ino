const int posButtonPin = 2;
const int negButtonPin = 3;

int posButtonState = 0;
int negButtonState = 0;

int lastPosButtonState = 0;
int lastNegButtonState = 0;

void setup() {
  Serial.begin(9600);
  
  pinMode(posButtonPin, INPUT);
  pinMode(negButtonPin, INPUT);
}


void loop() {
  negButtonState = digitalRead(negButtonPin);
  posButtonState = digitalRead(posButtonPin);

  if (posButtonState != lastPosButtonState) {
    if (posButtonState == HIGH) {
      Serial.println("Pressed Positive");
    }
  }

  if (negButtonState != lastNegButtonState) {
    if (negButtonState == HIGH) {
      Serial.println("Pressed Negative");
    }
  }

  lastPosButtonState = posButtonState;
  lastNegButtonState = negButtonState;
}
