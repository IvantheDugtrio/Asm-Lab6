.386
.MODEL FLAT
ExitProcess PROTO NEAR32 stdcall, dwExitCode:dword
include io.h

CR	EQU	0Dh				;the carriage return
LF	EQU	0Ah				;the line feed

.STACK 4096

.DATA
szHeader BYTE	"Ivan De Dios",
		CR,LF,"CS 3B",
		CR,LF,"LAB #6 due 2/28/2014",
		CR,LF,"HEX TO ASCII",
		CR,LF,CR,LF,"Procedure CreateHexString will recieve the hex number ",
		CR,LF,"(12AB) to be converted and the address of the output ",
		CR,LF,"string on the stack.",0
		
szNewLine BYTE 	CR,LF,0		
szIOBuffer BYTE		10 DUP (0)		;string for user input and program output

dwHexString DWORD	4779			;hex word to be converted

.CODE
_start:
	mov eax,dwHexString
	dtoa szIOBuffer,eax
	output szIOBuffer
	output szNewLine
	
	push OFFSET szIOBuffer
	push dwHexString
	
	CALL OutputHeader
	CALL CreateHexString
	
	output szNewLine
	output szIOBuffer
	INVOKE ExitProcess,0

OutputHeader PROC NEAR32
		output szHeader
	ret
OutputHeader ENDP
	
CreateHexString PROC NEAR32
		push ebp	;save base pointer
		mov ebp,esp
		
		pushfd
		pushad
		
		mov ecx,4		;initialize loop counter
		mov ebx,[ebp + 12]	;put string address in EBX
		mov eax,[ebp + 8]	;put number in AX
	_rotate:
		rol ax,4		;rotate ax to the left by 1 byte
		mov dl,al		;save al in dl
		and dl,0Fh		;zero out the higher value in al
		add dl, 30h
		cmp dl,39h		;is it "0" through "9"?
		jbe _outputString
		add dl,8h		;if no it's "A" through "F"
	_outputString:
		mov BYTE PTR [ebx],al	;
		add ebx,1
		loop _rotate
		add BYTE PTR [ebx],0	
		popad
		popfd
		
		pop ebp
	ret 8
CreateHexString ENDP
	
PUBLIC _start
END