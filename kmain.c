#include "kmain.h"
#include "ports.h"
#include "video.h"

void kmain(void)
{
    clear_screen();
    print(KMAIN_HELLO_MSG);

    while(1);
}
