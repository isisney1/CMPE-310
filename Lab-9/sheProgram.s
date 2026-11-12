.section .text
.global _start
_start:
    mov $0b10000000, %ah        # set AH to digit 7
    mov $0, %bl                 # 0 = move right, 1 = move left

    mov $0b10000000, %al        # set bit command byte A
                                # group B mode 0,
                                # port B output, port C output
                                # group A mode 0,
                                # port A output, port C output
    mov $0x643, %dx             # point DX to 8255 control register
    out %al, %dx                # configure all ports as mode 0 outputs

    LOOP:
        mov $0xFFFF, %cx           # number of loops (wait)

        WORD:
            S:
                mov $0b00000000, %al
                mov $0x640, %dx             # program port A of device
                out %al, %dx                # disable all digits

                mov $0b01101101, %al        # S: segments a,c,d,f,g ON
                mov $0x641, %dx             # point DX to Port B
                out %al, %dx                # output 'S' to the selected 7-segment digit

                mov %ah, %al                # enable digit, keep other digits off
                mov $0x640, %dx             # program port A of device
                out %al, %dx                # activate digit

                shr $1, %ah                 # select next digit

            H:
                mov $0b00000000, %al
                mov $0x640, %dx             # program port A of device
                out %al, %dx                # disable all digits

                mov $0b01110110, %al        # H: segments b,c,e,f,g ON
                mov $0x641, %dx             # point DX to Port B
                out %al, %dx                # output 'H' to the selected 7-segment digit

                mov %ah, %al                # enable digit, keep other digits off
                mov $0x640, %dx             # program port A of device
                out %al, %dx                # activate digit

                shr $1, %ah                 # select next digit

            E:
                mov $0b00000000, %al
                mov $0x640, %dx             # program port A of device
                out %al, %dx                # disable all digits

                mov $0b01111001, %al        # E: segments a,d,e,f,g ON
                mov $0x641, %dx             # point DX to Port B
                out %al, %dx                # output 'E' to the selected 7-segment digit

                mov %ah, %al                # enable digit, keep other digits off
                mov $0x640, %dx             # program port A of device
                out %al, %dx                # activate digit

                shl $2, %ah                 # go back to 'S' digit

            dec %cx
            jnz WORD

        cmp $0, %bl
        je SHIFTRIGHT

        SHIFTLEFT:
        mov $1, %bl                 # shifts left
        cmp $0b10000000, %ah        # check if word is at edge
        je SHIFTRIGHT               # start going right if at edge
        shl $1, %ah                 # shift word left
        jmp LOOP                    # jump to loop

        SHIFTRIGHT:
        mov $0, %bl                 # shifts right
        cmp $0b00000100, %ah        # check if word is at edge
        je SHIFTLEFT                # start going left if at edge
        shr $1, %ah                 # shift word right
        jmp LOOP                    # jump to loop
