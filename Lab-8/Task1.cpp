int LED = 12;
int continuity = 13;

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(continuity, INPUT_PULLUP);
}

void loop() {
  int continuityValue = digitalRead(continuity);

  if (continuityValue == LOW) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}
