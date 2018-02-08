
.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
bigEndian BYTE 12h,34h,56h,78h
littleEndian DWORD ?
fibNumber DWORD 1, 6 DUP(?)

.code
main proc

	;version 1
	mov al, bigEndian[3]

	invoke ExitProcess,0
main endp
end main