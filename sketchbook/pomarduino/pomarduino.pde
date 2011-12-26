#include <LiquidCrystal.h>

LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

const int LINE_SIZE = 16;

char first_line[LINE_SIZE] = "";
char anim_index = 0;

char remain_str[LINE_SIZE+1] = "";

int remaining_time = 0.5*60;

int last_pulse = 0;

void setup() {

  // Init LCD
  lcd.begin(16, 2);
  
   pinMode(10, OUTPUT);
  
  // Init Serial
  Serial.begin(9600);
  
}

void animate() {
    lcd.setCursor(0, 0);
    lcd.print(first_line);
  
    if ( anim_index >= LINE_SIZE )
      anim_index = 0;
     
    switch ( first_line[anim_index] ) {
      case '.':
        first_line[anim_index] = 'o';
        break;
      case 'o':
        first_line[anim_index] = 'O';
        break;
      case 'O':
        first_line[anim_index] = '0';
        anim_index++;
        break;
      case '0':
        first_line[anim_index] = '.';
        anim_index++;
        break;
      default:
        first_line[anim_index] = '.';
        break;
    }
}

void display_remaining(int min, int sec) {
 lcd.setCursor(0, 1);
 sprintf(remain_str, "%2d:%2d left", min, sec); 
 lcd.print(remain_str);
}

void loop() {
 
  if ( Serial.available() > 0 ) 
  {
   int time = Serial.read();
   remaining_time = time * 60;
  }
  
  
  if ( remaining_time > 0 ) {
    animate();
    display_remaining(remaining_time/60, remaining_time%60);
    remaining_time--;
    digitalWrite(10, HIGH);
  } else {
    lcd.clear();
    digitalWrite(10, LOW);
  }
  
  int delta = millis() - last_pulse;
  delay(1000 - delta);
  last_pulse = millis();
  
}
