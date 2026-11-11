// Voltage Measurement using Arduino UNO
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

int voltageV = A0;

void setup() {
  pinMode(voltageV, INPUT);
  lcd.init();
  lcd.backlight();

  pinMode(12, OUTPUT);
  digitalWrite(12, HIGH);
}

void loop() {
  int VoltageMsmt = analogRead(voltageV);
  float Vcalc = (VoltageMsmt * 5.0) / 1023;

  lcd.setCursor(0, 0);
  lcd.print("VOLTAGE: ");
  lcd.print(Vcalc);
  lcd.print("V");
}
