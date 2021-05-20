int xaPin = A4;
int yaPin = A5;
int xbPin = A3;
int ybPin = A2;

int buttonPina = 2;
int buttonPinb = 7;

int Jug1Arriba = 9;
int Jug1Abajo = 10;
int Jug2Arriba = 11;
int Jug2Abajo = 12;

int xaPosition = 0;
int yaPosition = 0;
int xbPosition = 0;
int ybPosition = 0;
int buttonState = 0;

void setup() {
  // inicializar las comunicaciones en serie a 9600 bps:
  Serial.begin(9600); 
  
  pinMode(xaPin, INPUT);
  pinMode(yaPin, INPUT);
  pinMode(xbPin, INPUT);
  pinMode(ybPin, INPUT);
  pinMode(Jug1Arriba, OUTPUT);
  pinMode(Jug1Abajo, OUTPUT);
  pinMode(Jug2Arriba, OUTPUT);
  pinMode(Jug2Abajo, OUTPUT);

  //activar resistencia pull-up en el pin pulsador 
  pinMode(buttonPina, INPUT_PULLUP); 
  pinMode(buttonPinb, INPUT_PULLUP);
  
  // Para las versiones anteriores a 1.0.1 Arduino 
  // pinMode (buttonPin, INPUT); 
  // digitalWrite (buttonPin, HIGH);
  
}

void loop() {
  xaPosition = analogRead(xaPin);
  yaPosition = analogRead(yaPin);
  xbPosition = analogRead(xbPin);
  ybPosition = analogRead(ybPin);
  buttonState = digitalRead(buttonPina);
  //buttonState2 = digitalRead(buttonPinb);
  
  Serial.print("X1: ");
  Serial.print(xaPosition);
  Serial.print(" | Y1: ");
  Serial.println(yaPosition);
  Serial.print("X2: ");
  Serial.print(xbPosition);
  Serial.print(" | Y2: ");
  Serial.println(ybPosition);

  if(yaPosition>1000)
  {digitalWrite(Jug1Arriba,HIGH);}
  else
    digitalWrite(Jug1Arriba,LOW);

  if(yaPosition<30)
  {digitalWrite(Jug1Abajo,HIGH);}
  else
    digitalWrite(Jug1Abajo,LOW);

  if(ybPosition<30)
  {digitalWrite(Jug2Arriba,HIGH);}
  else
    digitalWrite(Jug2Arriba,LOW);

  if(ybPosition>1000)
  {digitalWrite(Jug2Abajo,HIGH);}
  else
    digitalWrite(Jug2Abajo,LOW);
}
