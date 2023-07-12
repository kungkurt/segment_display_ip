#include <altera_timer_regs.h>
#include <segment_driver.h>

void hex_turn_off_all(void) {
  hex0_set(HEX_OFF);
  hex1_set(HEX_OFF);
  hex2_set(HEX_OFF);
  hex3_set(HEX_OFF);
  hex4_set(HEX_OFF);
  hex5_set(HEX_OFF);
}

void hex_loading_pattern(void) {
  int run = 1;
  int hex_choice = 0;
  int segment_choice = 0;
  TIMER_RESET;
  while(run) {
    TIMER_START;
    while(TIMER_READ < 7500000);
    hex_turn_off_all();
    switch(hex_choice) {
    case 0:
      if(segment_choice == 0) {
        hex0_set(HEX_OVER);
        hex_choice++;
      } else if(segment_choice == 1) {
        hex0_set(HEX_ONE);
        segment_choice = 3;
      } else if(segment_choice == 2) {
        hex0_set(HEX_UNDER);
        segment_choice--;
      } else {
        hex0_set(HEX_MIDDLE);
        hex_choice++;
      }
      break;
    case 1:
      if(segment_choice == 0) {
        hex1_set(HEX_OVER);
        hex_choice++;
      } else if(segment_choice == 2) {
        hex1_set(HEX_UNDER);
        hex_choice--;
      } else {
        hex1_set(HEX_MIDDLE);
        hex_choice++;
      }
      break;
    case 2:
      if(segment_choice == 0) {
        hex2_set(HEX_OVER);
        hex_choice++;
      } else if(segment_choice == 2) {
        hex2_set(HEX_UNDER);
        hex_choice--;
      } else {
        hex2_set(HEX_MIDDLE);
        hex_choice++;
      }
      break;
    case 3:
      if(segment_choice == 0) {
        hex3_set(HEX_OVER);
        hex_choice++;
      } else if(segment_choice == 2) {
        hex3_set(HEX_UNDER);
        hex_choice--;
      } else {
        hex3_set(HEX_MIDDLE);
        hex_choice++;
      }
      break;
    case 4:
      if(segment_choice == 0) {
        hex4_set(HEX_OVER);
        hex_choice++;
      } else if(segment_choice == 2) {
        hex4_set(HEX_UNDER);
        hex_choice--;
      } else {
        hex4_set(HEX_MIDDLE);
        hex_choice++;
      }
      break;
    case 5:
      if(segment_choice == 0) {
        hex5_set(HEX_OVER);
        segment_choice++;
      } else if(segment_choice == 1) {
        hex5_set(HEX_LSIDE);
        segment_choice++;
      } else if(segment_choice == 2) {
        hex5_set(HEX_UNDER);
        hex_choice--;
      } else {
        hex5_set(HEX_MIDDLE);
        run=0;
      }
    }
    TIMER_RESET;
    TIMER_START;
    while(TIMER_READ < 7500000);
    hex_turn_off_all();
  }
}

void hex_integer(int x) {
  hex_turn_off_all();
  for(int i = 0; i < 10; i++) {
    switch(i) {
    case 0:
      hex0_set(x % 10);
      break;
    case 1:
      hex1_set(x % 10);
      break;
    case 2:
      hex2_set(x % 10);
      break;
    case 3:
      hex3_set(x % 10);
      break;
    case 4:
      hex4_set(x % 10);
      break;
    case 5:
      hex5_set(x % 10);
      break;
    default:
      hex0_set(HEX_OFF);
      hex1_set(HEX_R);
      hex2_set(HEX_O);
      hex3_set(HEX_R);
      hex4_set(HEX_R);
      hex5_set(HEX_E);
      x = 0;
    }
    x /= 10;
    if(x <= 0) break;
  }
}
