.section .data
Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23
    .long 7
    .long 3
    .long 11
Array_length:
    .long 10

.section .bss
.global maxVal
.lcomm maxVal, 4                            # reserve 4 bytes for maxVal

.section .text
.global compare                             # make function visible to C program
compare:
    movl $0, %ecx                           # i = 0
    movl $Numbers, %esi                     # ESI = Numbers
    movl (%esi), %eax                       # EAX = Numbers[0]
    movl Array_length, %edx                 # EDX = Array_length
	jmp	.L2

.L4:
    movl (%esi, %ecx, 4), %ebx              # EBX = Numbers[i]
    cmpl %eax, %ebx                         # Numbers[i] <= EAX
    jle .L3
    movl %ebx, %eax                         # EAX = Numbers[i]
.L3:
	addl $1, %ecx                           # i++
.L2:
    cmpl %edx, %ecx                         # i < Array_length
	jl .L4

    movl %eax, maxVal
    ret                                     # return control back to C program

.section .note.GNU-stack,"",@progbits
