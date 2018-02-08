INCLUDE Irvine32.inc
.data
iPrompt1  BYTE  "Enter the first number: ",0
iPrompt2  BYTE  "Enter the second number: ",0
Result	  BYTE  "The addition result is:  ",0


.code
main PROC
	
	mov ecx, 3
	l1:	call	Clrscr			; clear the screen
	push ecx
	getInt1:
	push edx
	mov	edx,OFFSET iPrompt1
	call	WriteString
	pop edx
	call	ReadInt
	jo getInt1
	mov ebx, eax
	getInt2:
	push edx
	mov	edx,OFFSET iPrompt2
	call	WriteString
	pop edx
	call	ReadInt
	jo getInt2
	ADD eax, ebx
		push edx
	mov	edx,OFFSET Result
	call	WriteString
	pop edx
	call WriteInt
	call ReadChar
	pop ecx
		loop l1

	exit
main ENDP

END main