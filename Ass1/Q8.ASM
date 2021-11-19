.MODEL SMALL    ; Program uses a minimum of 64K of memory for code
.STACK 100H     ; Bytes of stack spaces for the Program

.DATA
ARR DB '5327918'
COUNT DW ($-ARR)

.CODE

BS PROC
        MOV AX, @DATA
        MOV DS, AX

        CALL PRINTARR

        MOV CX, COUNT
        DEC CX

        L1: PUSH CX                ;STORE OUTER LOOP COUNTER
            MOV SI, OFFSET ARR     ;SI POINTS TO FIRST INDEX IN ARRAY

        L2: MOV AL, [SI]           ; AL USED INSTEAD OF AX, SINCE DATA IS A BYTE LONG

            CMP [SI+1], AL         ;COMPARE ELEMENT AND THE NEXT ELEMENT
            JG L3                  ;IF ELEMENT <= NEXT ELEMENT GOTO L3
            XCHG AL, [SI+1]        ;ELSE SWAP
            MOV [SI], AL

        L3: INC SI
            LOOP L2                ;INNER LOOP

            POP CX                 ;BACK TO OUTER LOOP
            LOOP L1                ;OUTER LOOP

        ;CALL PRINTARR

        MOV AH,02H
        MOV DL, [ARR]
        INT 21H                    ;PRINT SECOND MIN
        MOV DL, ' '
        INT 21H

        MOV AX, offset ARR
        ADD AX, COUNT
        SUB AX, 1
        MOV SI, AX
        MOV AH, 02H
        MOV DL, [SI]
        INT 21H                    ;PRINT SECOND MAX

        MOV AH, 4CH                ;TERMINATE PROCESS
        INT 21H

BS ENDP

PRINTARR PROC

        MOV AH, 02H

        MOV CX, COUNT
        MOV SI, OFFSET ARR

        LP: MOV DL, [SI]
            INT 21H
            MOV DL, ' '
            INT 21H
            INC SI
            LOOP LP

        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H

        RET

PRINTARR ENDP

END BS
