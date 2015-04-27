/*  Author: Steve Gunn
 *  Licence: This work is licensed under the Creative Commons Attribution License.
 *           View this license at http://creativecommons.org/about/licenses/
 */

#include <stdint.h>
#include "../hw.h"

extern volatile int8_t rotary;

void init_rotary();
int8_t get_rotary();
uint8_t get_switch();
