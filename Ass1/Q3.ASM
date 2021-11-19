.MODEL SMALL
.STACK 100H

.DATA

MSG DB "11H+31H = $"
VAL1 DB 11H    ; dec = 17
VAL2 DB 31H    ; dec = 49
VAL3 DB ?," (ASCII)$"  ; EXPECTED 65 OR 41H
DONE DB 0DH,0AH,"FIN$"

.CODE


MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        LEA DX,MSG
        MOV AH, 09H
        INT 21H

        MOV AL, VAL1
        ADD AL, VAL2    ; ADDING
        MOV VAL3, AL    ; STORING IN VAL3
        ;MOV DL, VAL3
        MOV DX, OFFSET VAL3
        MOV AH, 09H
        INT 21H         ; PRINTING VAL3

        MOV DX, OFFSET DONE
        INT 21H

        ;EXIT
        MOV AH, 4CH
        INT 21H


MAIN ENDP
END MAIN


; MASM Q3.ASM && LINK Q3.OBJ && Q3.EXE
