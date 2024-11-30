#ifndef KMAIN_H
#define KMAIN_H

#include "ports.h"

// Video definitions
char * VIDEO_TEXT_MODE_PTR = (char *)0xb8000; // video mem begins here.

// Other definitions
char * KMAIN_HELLO_MSG = "Hello from kmain!";

#endif // KMAIN_H
