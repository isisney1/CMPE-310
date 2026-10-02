#include <stdio.h>
extern unsigned int maxVal; // Result declared in assembly
extern void compare(); // Assembly function
int main() {
    compare(); // Run assembly code
    printf("The maximum value is: %u\n", maxVal); // Print result

    return 0;
}
