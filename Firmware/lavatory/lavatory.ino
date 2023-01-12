

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  pinMode(0, OUTPUT); // Servo
  pinMode(1, OUTPUT); // LED
  pinMode(3, OUTPUT); // high button
  digitalWrite(3, HIGH);
  pinMode(2, INPUT); // input button
  pinMode(4, OUTPUT); // button LED
  digitalWrite(3, HIGH);

  digitalWrite(1, HIGH);
  for(int i = 0; i < 100; i++) {
    digitalWrite(0, HIGH);   
    delayMicroseconds(2000); 
    digitalWrite(0, LOW);    
    delay(20);               
  }
  digitalWrite(1, LOW);
}

// the loop routine runs over and over again forever:
void loop() {
  digitalWrite(1, LOW);
  delay(1000);
  while(digitalRead(2) == HIGH);
  digitalWrite(4, LOW);
  while(digitalRead(2) == LOW);
  digitalWrite(4, HIGH);
  
  for(int i = 0; i < 1000; i++) {
    digitalWrite(1, HIGH);
    delayMicroseconds(i);
    digitalWrite(1, LOW);
    delayMicroseconds(1000-i);
  }
  digitalWrite(1, HIGH); 
  
  for(int i = 0; i < 100; i++) {
    digitalWrite(0, HIGH);   
    delayMicroseconds(max(1100, 2000 - i*40)); 
    digitalWrite(0, LOW);    
    delay(20);               
  }
  for(int i = 0; i < 100; i++) {
    digitalWrite(0, HIGH);   
    delayMicroseconds(min(2000, 1100 + i * 10)); 
    digitalWrite(0, LOW);    
    delay(20);               
  }

  for(int i = 0; i < 1000; i++) {
    digitalWrite(1, LOW);
    delayMicroseconds(i);
    digitalWrite(1, HIGH);
    delayMicroseconds(1000-i);
  }
  digitalWrite(1, LOW); 
}
