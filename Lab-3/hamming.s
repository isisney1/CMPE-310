.section .data
prompt_1:    .ascii "Enter the first string: "
prompt_1_len = . - prompt_1
prompt_2:    .ascii "Enter the second string: "
prompt_2_len = . - prompt_2

.section .bss
.lcomm string_1, 256
.lcomm string_2, 256

.section .text
.global _start
_start:
    # Write prompt 1 to stdout
    mov $1,  %rax   # write
    mov $1,  %rdi   # stdout
    mov $prompt_1,      %rsi   # buf
    mov $prompt_1_len,  %rdx   # len
    syscall

    # Read string 1 from stdin
    mov $0,  %rax   # read
    mov $0,  %rdi   # stdin
    mov $string_1,  %rsi   # buf
    mov $256,       %rdx   # len
    syscall

    mov %eax, %ebx

    # Write prompt 2 to stdout
    mov $1,  %rax   # write
    mov $1,  %rdi   # stdout
    mov $prompt_2,      %rsi   # buf
    mov $prompt_2_len,  %rdx   # len
    syscall

    # Read input 2 from stdin
    mov $0,  %rax   # read
    mov $0,  %rdi   # stdin
    mov $string_2,  %rsi   # buf
    mov $256,       %rdx   # len
    syscall

    cmp %eax, %ebx
    jle compare
    mov %eax, %ebx

    compare:
        cmp %ecx, %ebx
        je done

        

        inc %ecx


    done:
        mov $60, %rax   # exit
        mov $0,  %rdi   # status
        syscall
