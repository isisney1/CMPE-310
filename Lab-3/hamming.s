.section .data
prompt_1:    .ascii "Enter the first string: "
prompt_1_len = . - prompt_1
prompt_2:    .ascii "Enter the second string: "
prompt_2_len = . - prompt_2
prompt_3:    .ascii "The hamming distance is: "
prompt_3_len = . - prompt_3

.section .bss
.lcomm string_1, 256                # reserve 256 bytes for string 1 (255 characters)
.lcomm string_2, 256                # reserve 256 bytes for string 2 (255 characters)
.lcomm hamming_distance, 4          # reserve 4 bytes for hamming distance
.lcomm output, 4

.section .text
.global _start
_start:
    # Write prompt 1 to stdout
    movq $1, %rax                   # write
    movq $1, %rdi                   # stdout
    movq $prompt_1, %rsi            # buf
    movq $prompt_1_len, %rdx        # len
    syscall

    # Read string 1 from stdin
    movq $0, %rax                   # read
    movq $0, %rdi                   # stdin
    movq $string_1, %rsi            # buf
    movq $256, %rdx                 # len
    syscall

    movl %eax, %ebx                 # set EBX to string 1 size

    # Write prompt 2 to stdout
    movq $1, %rax                   # write
    movq $1, %rdi                   # stdout
    movq $prompt_2, %rsi            # buf
    movq $prompt_2_len, %rdx        # len
    syscall

    # Read input 2 from stdin
    movq $0, %rax                   # read
    movq $0, %rdi                   # stdin
    movq $string_2, %rsi            # buf
    movq $256, %rdx                 # len
    syscall

    # Check if the second string is smaller
    cmpl %eax, %ebx                 # compare sizes of string 1 and 2
    jle compare                     # jump to compare loop if string 1 is smaller
    movl %eax, %ebx                 # set EBX to string 2 size

    compare:
        movq $string_1, %rsi        # create a pointer to string 1
        movq $string_2, %rdi        # create a pointer to string 2
        movl $0, %ecx               # ECX = 0
        decl %ebx                   # remove the \n at the end of the shortest string

    character_loop:
        movb (%rsi), %ah
        movb (%rdi), %al

        xorb %ah, %al
        
        count_ones:
            testb $1, %al
            jz file_through
            incl %ecx

        file_through:
            shrb $1, %al
            jnz count_ones

        incq %rsi
        incq %rdi
        decl %ebx                   # EBX = EBX - 1
        jnz character_loop          # continue looping if EBX != 0

    movl %ecx, hamming_distance

    # Convert Hamming distance to ASCII
    movl %ecx, %eax
    movl $10, %ebx
    movq $output + 4, %r8

    convert:
        xorl %edx, %edx
        divl %ebx
        addb $'0', %dl
        decq %r8
        movb %dl, (%r8)
        testl %eax, %eax
        jnz convert

        # Print the Hamming distance
        movq $1, %rax
        movq $1, %rdi
        movq %r8, %rsi
        movq $output + 4, %rdx
        subq %r8, %rdx
        syscall

    done:
        movq $60, %rax
        movq $0, %rdi
        syscall
