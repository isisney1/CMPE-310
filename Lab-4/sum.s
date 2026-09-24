.section .bss
.global sum
.lcomm sum, 4                   # reserve 4 bytes for sum

.section .text
.global sum_up                  # make function visible to C program
sum_up:
    movl $sum, %eax             # EAX = SUM

    sum_loop:
        movl (%rdi), %ebx       # EBX = current number
        addl %ebx, (%eax)       # add current number to current sum
        addq $4, %rdi           # increment RDI by 4 bytes (int)
        decq %rsi               # count down
        jnz sum_loop            # repeat loop until all numbers are added

    ret                         # return control back to C program

.section .note.GNU-stack,"",@progbits
