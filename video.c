#include "video.h"

void clear_screen(void)
{
    unsigned int i = 0;

    // this loop clears the screen
    while(i < 80 * 25 * 2)
    {
        VIDEO_TEXT_MODE_PTR[i] = ' ';
        VIDEO_TEXT_MODE_PTR[i + 1] = 0x07; // light grey
        i = i + 2;
    }
}

void print(char * str)
{
    unsigned int i = 0;
    unsigned int j = 0;

    // this loop writes the string to video mem
    while(str[i] != '\0')
    {
        VIDEO_TEXT_MODE_PTR[j] = str[i];
        VIDEO_TEXT_MODE_PTR[j + 1] = 0x07; // light grey
        ++i;
        j = j + 2;
    }
}
