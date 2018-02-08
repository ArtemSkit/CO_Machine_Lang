INCLUDE Irvine32.inc
.data
Arr  SDWORD 1,2,3,4,5,6,7,8,9,10
iPrompt1  BYTE  "Enter the lower bound: ",0
iPrompt2  BYTE  "Enter the upper bound: ",0


.code
main PROC
;Clear console
call Clrscr
mov ecx, 2
l2: push Offset Arr ;Push offset and length on the stack
	push LENGTHOF Arr
	getInt1:
		push edx
		mov	edx,OFFSET iPrompt1
		call	WriteString
		pop edx
		call	ReadInt	;Get lower bound
		jo getInt1
		cmp eax, 0
		jl getInt1
		push ebx
		mov ebx, LENGTHOF Arr
		dec ebx
		cmp eax, ebx
		jg getInt1
	mov edx, eax
	getInt2:
		push edx
		mov	edx,OFFSET iPrompt2
		call	WriteString
		pop edx
		call	ReadInt	;Get upper bound
		jo getInt2
		cmp eax, 0
		jl getInt2
		cmp eax, ebx
		jg getInt2
		pop ebx
	cmp edx, eax ;Check it lower bound is less than upper bound
	jg swap
	push edx	;Push bounds on the stack
	push eax
	jmp Bounds_checked
	swap:push eax	;Push bounds on the stack
	push edx
	Bounds_checked: call SummArray
	call WriteInt
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar
	pop eax	;Pop bounds from the stack
	pop eax
	pop eax	;Pop offset and length from the stack
	pop eax
	loop l2
call ReadChar	;Wait for the user to press any key
exit
main endp

SummArray PROC
push ebx
push ecx
push edx
push esi
mov ebx, esp
mov eax, [ebx + 20]
sub eax, [ebx + 24]
mov ecx, eax
inc ecx
mov edx, [ebx + 32]
mov esi, [ebx + 24] 
mov eax, 0
dec esi
l1: inc esi
	add eax, [edx + esi*4]
	loop l1
pop esi
pop edx
pop ecx
pop ebx
ret
SummArray ENDP

END main