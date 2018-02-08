INCLUDE Irvine32.inc
.data
Arr  SDWORD 1,2,3,45,5,6,7,8,9,10
Arr1  SDWORD 1,2,33,4,5,6,7,8,9,10
Arr2  SDWORD 1,2,3,45,5,6,7,83,9,10


.code
main PROC
;Clear console
call Clrscr
push Offset Arr 
push LENGTHOF Arr
call FindLargest 
push Offset Arr1
push LENGTHOF Arr1
call FindLargest 
push Offset Arr2
push LENGTHOF Arr2
call FindLargest


call ReadChar	;Wait for the user to press any key
exit
main endp

FindLargest  PROC uses ebx ecx edx
mov ebx, esp
mov ecx, [ebx + 16]
mov edx, [ebx + 20]
mov eax, [edx]
l1: add edx, 4
	cmp eax, [edx]
	jl l2
	jmp l3
	l2: mov eax, [edx]
	l3: loop l1 

call WriteInt
push eax
mov al, 0dh
call WriteChar
mov al, 0ah
call WriteChar
pop eax
ret 8
FindLargest  ENDP

END main