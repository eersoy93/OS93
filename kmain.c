#include "kmain.h"

void kmain(void)
{
    unsigned int i = 0;
    unsigned int j = 0;

    // this loop clears the screen
    while(j < 80 * 25 * 2)
    {
        VIDEO_TEXT_MODE_PTR[j] = ' ';
        VIDEO_TEXT_MODE_PTR[j+1] = 0x07; // light grey
        j = j + 2;
    }

    j = 0;

    // this loop writes the string to video mem
    while(KMAIN_HELLO_MSG[i] != '\0')
    {
        VIDEO_TEXT_MODE_PTR[j] = KMAIN_HELLO_MSG[i];
        VIDEO_TEXT_MODE_PTR[j+1] = 0x07; // light grey
        ++i;
        j = j + 2;
    }

}