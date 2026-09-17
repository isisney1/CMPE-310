.section .data
prompt_1:    .ascii "Enter the first string: "
prompt_1_len = . - prompt_1
prompt_2:    .ascii "Enter the second string: "
prompt_2_len = . - prompt_2

.section .bss
.lcomm string_1, 256                # reserve 256 bytes for string 1 (255 characters)
.lcomm string_2, 256                # reserve 256 bytes for string 2 (255 characters)

.section .text
.global _start
_start:
    # Write prompt 1 to stdout
    mov $1, %rax                    # write
    mov $1, %rdi                    # stdout
    mov $prompt_1, %rsi             # buf
    mov $prompt_1_len, %rdx         # len
    syscall

    # Read string 1 from stdin
    mov $0, %rax                    # read
    mov $0, %rdi                    # stdin
    mov $string_1, %rsi             # buf
    mov $256, %rdx                  # len
    syscall

    mov %eax, %ebx                  # set EBX to string 1 size

    # Write prompt 2 to stdout
    mov $1, %rax                    # write
    mov $1, %rdi                    # stdout
    mov $prompt_2, %rsi             # buf
    mov $prompt_2_len, %rdx         # len
    syscall

    # Read input 2 from stdin
    mov $0, %rax                    # read
    mov $0, %rdi                    # stdin
    mov $string_2, %rsi             # buf
    mov $256, %rdx                  # len
    syscall

    # Check if the second string is smaller
    cmp %eax, %ebx                  # compare sizes of string 1 and 2
    jle compare                     # jump to compare loop if string 1 is smaller
    mov %eax, %ebx                  # set EBX to string 2 size

    compare:
        mov string_1, %rsi
        mov string_2, %rdi

        
    character_loop:
        dec %ebx                    # EBX = EBX - 1
        jnz character_loop          # continue looping if EBX != 0


    done:
        mov $60, %rax               # exit
        mov $0,  %rdi               # status
        syscall
