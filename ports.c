#include "ports.h"

unsigned char inb(unsigned short port)
{
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

unsigned short inw(unsigned short port)
{
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

unsigned int ind(unsigned short port)
{
    unsigned int result;
    __asm__("in %%dx, %%eax" : "=a" (result) : "d" (port));
    return result;
}

void outb(unsigned short port, unsigned char value)
{
    __asm__("out %%al, %%dx" : : "a" (value), "d" (port));
}

void outw(unsigned short port, unsigned short value)
{
    __asm__("out %%ax, %%dx" : : "a" (value), "d" (port));
}

void outd(unsigned short port, unsigned int value)
{
    __asm__("out %%eax, %%dx" : : "a" (value), "d" (port));
}
