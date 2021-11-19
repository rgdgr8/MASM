; Add and Subtract two 16 bit numbers
new_line macro
	mov ah,02h
	mov dl,0dh
	int 21h
	mov dl,0ah
	int 21h
endm

;macro to print space
space macro
	mov ah,02h
	mov dl,' '
	int 21h
endm

;macro to print a message
printm macro mess
	lea dx,mess
	mov ah,09h
	int 21h
endm

;macro to exit
exitp macro
	mov ah,4ch
	int 21h
endm

;macro for hex input
hex_input macro
	local skip,input,letter,shift
	; output: bx
	xor bx,bx
	mov ah,01h
	int 21h
	cmp al,0dh
	je skip
	input:
		xor ah,ah
		cmp ax,'A'
		jge letter
		sub ax,'0'
		jmp shift
		letter:
			sub ax,55
		shift:	
			shl bx,1
			shl bx,1
			shl bx,1
			shl bx,1
		or bx,ax
		; take input
		mov ah,01h
		int 21h
		cmp al,0dh
		jne input
	skip:
endm

;macro for hex_output
hex_output macro
	local output,display_loop,letter,line
	; input: bx	
	mov ah,02h
	mov cx,0
	output:
		mov dx,bx
		and dx,0fh
		cmp dx,10
		jge letter
		add dx,'0'
		jmp line
	letter:
			add dx,55
	line:
		push dx
		inc cx
		shr bx,1
		shr bx,1
		shr bx,1
		shr bx,1
	jnz output
	mov cx,cx
	display_loop:
		pop dx
		int 21h
	loop display_loop
endm

.model small
.stack 100h
.data
        inpmsg1 db "Enter 1st number in hex: $"
        inpmsg2 db "Enter 2nd number in hex: $"
        oupmsg1 db "Their sum in hex is: $"
        oupmsg2 db "Their difference in hex is: $"
	num1 dw ?
	num2 dw ?
.code
	main proc
		mov ax,@data
		mov ds,ax
		;input prompt
		printm inpmsg1
		hex_input
		mov num1,bx
		printm inpmsg2
		hex_input
		mov num2,bx		
		;calculating sum
		printm oupmsg1		
		mov cx,num1
		add bx,cx
		jnc display
		carry_disp:
			;display carry
			mov ah,02h
			mov dl,'1'
			int 21h
		display:
			hex_output
		;calculating difference
		new_line
		printm oupmsg2		
		mov bx,num1
		mov cx,num2
		sub bx,cx		
		hex_output		
		exitp
	main endp
end main
