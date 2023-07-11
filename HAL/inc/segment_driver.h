/*
 * segment_driver.h
 * ----------------
 * Author : Robin Riis
 *
 * Description:
 *   driver to control segment displays
 */

#ifndef SEGMENT_DRIVER_H_
#define SEGMENT_DRIVER_H_

/*
 * Read a hex display
 */

#define hex_read(segment_display) IORD_32DIRECT(SEGMENT_DISPLAYS_BASE, (segment_display*4))

/*
 * Set hex display 0
 */
#define hex0_set(value)           IOWR_32DIRECT(SEGMENT_DISPLAYS_BASE, 0x4, value)

/*
 * Set hex display 1
 */
#define hex1_set(value)           IOWR_32DIRECT(SEGMENT_DISPLAYS_BASE, 0x8, value)

/*
 * Set hex display 2
 */
#define hex2_set(value)           IOWR_32DIRECT(SEGMENT_DISPLAYS_BASE, 0xC, value)

/*
 * Set hex display 3
 */
#define hex3_set(value)           IOWR_32DIRECT(SEGMENT_DISPLAYS_BASE, 0x10, value)

/*
 * Set hex display 4
 */
#define hex4_set(value)           IOWR_32DIRECT(SEGMENT_DISPLAYS_BASE, 0x14, value)

/*
 * Set hex display 5
 */
#define hex5_set(value)           IOWR_32DIRECT(SEGMENT_DISPLAYS_BASE, 0x18, value)

/*
 * hex values
 */
#define HEX_ZERO    0x00
#define HEX_ONE     0x01
#define HEX_TWO     0x02
#define HEX_THREE   0x03
#define HEX_FOUR    0x04
#define HEX_FIVE    0x05
#define HEX_SIX     0x06
#define HEX_SEVEN   0x07
#define HEX_EIGHT   0x08
#define HEX_NINE    0x09
#define HEX_E       0x0A
#define HEX_H       0x0B
#define HEX_R       0x0C
#define HEX_O       0x0D
#define HEX_L       0x0E
#define HEX_T       0x0F
#define HEX_UNDER   0x10
#define HEX_OVER    0x11
#define HEX_LSIDE   0x12
#define HEX_MIDDLE  0x13
#define HEX_OFF     0x14

void hex_turn_off_all(void);
void hex_loading_pattern(void);
void hex_integer(int x);

#endif /* SEGMENT_DRIVER_H_ */
