.MODEL SMALL    ; Program uses a minimum of 64K of memory for code
.STACK 100H     ; Bytes of stack spaces for the Program


.DATA

MYNAME DB "NAME : RITABROTO GANGULY", "$"
PROGTITLE DB 0DH, 0AH, "PROGRAM TITLE : PRINT NAME & TITLE$"


.CODE

MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        MOV DX, OFFSET MYNAME
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET PROGTITLE
        INT 21H


        ; TERMINATE

        MOV AH, 4CH
        INT 21H

MAIN ENDP
END MAIN


; MASM Q1.ASM && LINK Q1.OBJ && Q1.EXE
