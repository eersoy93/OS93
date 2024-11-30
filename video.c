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

void print_char(char c, unsigned int x, unsigned int y, unsigned char color)
{
    unsigned int index = (80 * y + x) * 2;
    VIDEO_TEXT_MODE_PTR[index] = c;
    VIDEO_TEXT_MODE_PTR[index + 1] = color;
}

void print_string(char * str, unsigned int x, unsigned int y, unsigned char color)
{
    unsigned int i = 0;
    unsigned int index = (80 * y + x) * 2;

    if (str == 0 || x > 80 || y > 25)
    {
        return;
    }

    // this loop writes the string to video mem at the specified position
    while(str[i] != '\0' && index < 80 * 25 * 2)
    {
        VIDEO_TEXT_MODE_PTR[index] = str[i];
        VIDEO_TEXT_MODE_PTR[index + 1] = color;
        ++i;
        index = index + 2;
    }
}
