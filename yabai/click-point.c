#include <ApplicationServices/ApplicationServices.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "usage: click-point <x> <y>\n");
        return 2;
    }

    double x = strtod(argv[1], NULL);
    double y = strtod(argv[2], NULL);
    CGPoint point = CGPointMake(x, y);

    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStatePrivate);
    CGEventRef move = CGEventCreateMouseEvent(source, kCGEventMouseMoved, point, kCGMouseButtonLeft);
    CGEventRef down = CGEventCreateMouseEvent(source, kCGEventLeftMouseDown, point, kCGMouseButtonLeft);
    CGEventRef up = CGEventCreateMouseEvent(source, kCGEventLeftMouseUp, point, kCGMouseButtonLeft);

    if (!source || !move || !down || !up) {
        fprintf(stderr, "failed to create mouse event\n");
        if (source) CFRelease(source);
        if (move) CFRelease(move);
        if (down) CFRelease(down);
        if (up) CFRelease(up);
        return 1;
    }

    CGEventSetFlags(move, 0);
    CGEventSetFlags(down, 0);
    CGEventSetFlags(up, 0);

    CGEventPost(kCGHIDEventTap, move);
    usleep(50000);
    CGEventPost(kCGHIDEventTap, down);
    usleep(50000);
    CGEventPost(kCGHIDEventTap, up);

    CFRelease(move);
    CFRelease(down);
    CFRelease(up);
    CFRelease(source);

    return 0;
}
