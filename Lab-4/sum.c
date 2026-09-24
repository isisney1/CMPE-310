#include <stdio.h>
extern unsigned int sum; // Result declared in assembly
extern void sum_up(int[], int); // Assembly function
int main() {
    char filename[] = "data.txt";

    // Prompt user for filename and open file
    printf("Enter filename: ");
    scanf("%s", filename);
    FILE *data = fopen(filename, "r");

    // Check if file opened successfully
    if (data != NULL) {
        // Get total numbers from file
        int total_nums;
        fscanf(data, "%d", &total_nums);

        // Declare array to hold numbers
        int numbers[total_nums];

        // Read numbers from file and store in array
        for (int i = 0; i < total_nums; i++) {
            fscanf(data, "%d", &numbers[i]);
        }

        sum_up(numbers, total_nums); // Run assembly code
        printf("Sum of %i numbers in %s: %u\n", total_nums, filename, sum); // Print result

        fclose(data); // Close file
    } else {
        printf("Error opening %s\n", filename);
    }
    
    return 0;
}

