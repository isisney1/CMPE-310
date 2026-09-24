#include <stdio.h>
extern unsigned int sum; // Result declared in assembly
extern void sum_up(int[], int); // Assembly function
int main() {
    int total_nums = 51; // Total numbers to read from data.txt
    int numbers[total_nums];

    // Get numbers from data.txt
    FILE *data = fopen("data.txt", "r");

    if (data != NULL) {
        printf("Numbers from data.txt:\n");

        // Read numbers from file and store in array
        for (int i = 0; i < total_nums; i++) {
            fscanf(data, "%d", &numbers[i]);
        }
        
        sum_up(numbers, total_nums); // Run assembly code
        printf("Sum: %u\n", sum); // Print result

        fclose(data); // Close file
    } else {
        printf("Error opening data.txt\n"); // Error handling
    }
    
    return 0;
}

