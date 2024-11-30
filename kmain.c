#include "kmain.h"
#include "ports.h"
#include "video.h"

void kmain(void)
{
    clear_screen();
    print_string(KMAIN_HELLO_MSG, 5, 5, 0x07);
    print_char('X', 10, 10, 0x04);

    while(1);
}
