#ifndef VIDEO_H
#define VIDEO_H

// Video text mode constants
char * VIDEO_TEXT_MODE_PTR = (char *)0xb8000; // Video mem begins here.

// Video text mode functions
void clear_screen(void);
void print(char * str);

#endif // VIDEO_H
