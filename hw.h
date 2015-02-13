#include <avr/io.h>

/* LED: On board LED */
#define LED_PORT PORTB
#define LED_DDR DDRB
#define LED_PIN PB7
/* SWN: North Switch */
#define SWN_PORT PORTB
#define SWN_DDR DDRC
#define SWN_PIN PC5
/* SWE: East Switch */
#define SWE_PORT PORTB
#define SWE_DDR DDRC
#define SWE_PIN PC4
/* SWS: South Switch */
#define SWS_PORT PORTB
#define SWS_DDR DDRC
#define SWS_PIN PC3
/* SWW: West Switch */
#define SWW_PORT PORTB
#define SWW_DDR DDRC
#define SWW_PIN PC2
/* SWC: Centre Switch */
#define SWC_PORT PORTE
#define SWC_DDR DDRE
#define SWC_PIN PE7
/* ROTA: Rotary encoder switch (clockwise) */
#define ROTA_PORT PORTE
#define ROTA_DDR DDRE
#define ROTA_PIN PE4
/* ROTB: Rotary encoder switch (anti-clockwise) */
#define ROTB_PORT PORTE
#define ROTB_DDR DDRE
#define ROTB_PIN PE5

// TODO: check ROTA and ROTB directions
