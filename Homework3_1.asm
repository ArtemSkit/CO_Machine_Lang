INCLUDE Irvine32.inc
.data
Arr1  DWORD 10 DUP(?)
Arr2  DWORD 20 DUP(?)
iPrompt1  BYTE  "Enter the lower bound: ",0
iPrompt2  BYTE  "Enter the upper bound: ",0


.code
main PROC
;Clear console
call Clrscr
jmp start ;Start with Arr1
start1: push Offset Arr2
push LENGTHOF Arr2
jmp getInt1
start: push Offset Arr1 ;Push offset and length on the stack
push LENGTHOF Arr1
getInt1:
	push edx
	mov	edx,OFFSET iPrompt1
	call	WriteString
	pop edx
	call	ReadInt	;Get lower bound
	jo getInt1
mov edx, eax
getInt2:
	push edx
	mov	edx,OFFSET iPrompt2
	call	WriteString
	pop edx
	call	ReadInt	;Get upper bound
	jo getInt2
cmp edx, eax ;Check it lower bound is less than upper bound
jg swap
push edx	;Push bounds on the stack
push eax
jmp Bounds_checked
swap:push eax	;Push bounds on the stack
push edx
Bounds_checked: call FillArray
pop eax	;Pop bounds from the stack
pop eax
call ShowArray
pop eax	;Pop offset and length from the stack
pop eax
cmp eax, Offset Arr2	;Check if it is Arr2
je quit
jmp start1	;Run procedure with Arr2
quit:	call ReadChar	;Wait for the user to press any key
exit
main endp


GetRandom PROC
push ebx
mov ebx, esp
mov eax, [ebx + 8]
sub eax, [ebx + 12]
inc eax
call RandomRange
add eax, [ebx + 12]
pop ebx
ret
GetRandom ENDP

ShowArray PROC
push ebx
mov ecx, [esp + 8]
mov ebx, [esp + 12]
mov esi, 0
l2: mov eax, [ebx + esi]
	add esi, 4
	call WriteInt
	mov al, 32
	call WriteChar
	loop l2
mov al, 0dh
call WriteChar
mov al, 0ah
call WriteChar
pop ebx
ret
ShowArray ENDP

FillArray PROC
push ebx
push eax
push ecx

mov ebx, esp
mov ecx, [ebx + 24]
push [ebx + 20]
push [ebx + 16]
mov ebx, [ebx + 28]
sub ebx, 4
call Randomize
l1: call GetRandom
	mov dword ptr [ebx + ecx * 4], eax
	loop l1
pop eax
pop eax

pop ecx
pop eax
pop ebx
ret
FillArray ENDP

END main