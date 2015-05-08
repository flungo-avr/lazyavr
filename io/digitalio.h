#ifndef LAZYAVR_DIGITALIOH
#define LAZYAVR_DIGITALIOH

/* Mode setting macros */
#define OUTPUT_(port, ddr, pin)        ddr |= 1 << pin
#define OUTPUT(spec)                   OUTPUT_(spec)
#define INPUT_(port, ddr, pin)         ddr &= ~(1 << pin)
#define INPUT(spec)                    INPUT_(spec)

/* Digital write macros (also used to toggle pull up resistor on inputs) */
#define SET_(port, ddr, pin)           port |= 1 << pin
#define SET(spec)                      SET_(spec)
#define CLEAR_(port, ddr, pin)         port &= ~(1 << pin)
#define CLEAR(spec)                    CLEAR_(spec)
#define TOGGLE_(port, ddr, pin)        port ^= 1 << pin
#define TOGGLE(spec)                   TOGGLE_(spec)

#endif
