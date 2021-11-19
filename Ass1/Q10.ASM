.MODEL SMALL    ; Program uses a minimum of 64K of memory for code
.STACK 100H     ; Bytes of stack spaces for the Program

.CODE

MAIN PROC

        MOV AH, 02H
        MOV DL, 'A'
        MOV CX, 1AH     ; Stores 26 in CX

LOOP1:
        INT 21H
        INC DL
        LOOP LOOP1

        ;TERMINATE

        MOV AH, 4CH
        INT 21H

MAIN ENDP
END MAIN


; MASM Q10.ASM && LINK Q10.OBJ && Q10.EXE
