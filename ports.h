#ifndef PORTS_H
#define PORTS_H

unsigned char inb(unsigned short port);
unsigned short inw(unsigned short port);
unsigned int ind(unsigned short port);

void outb(unsigned short port, unsigned char value);
void outw(unsigned short port, unsigned short value);
void outd(unsigned short port, unsigned int value);

#endif // PORTS_H
