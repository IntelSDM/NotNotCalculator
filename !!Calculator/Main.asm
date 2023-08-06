INCLUDE Irvine32.inc

.data
InputBuffer BYTE 100 DUP(0); 100 bytes for input storage
; Output Messages:
IntroMessage BYTE "Not Not Calculator:",10,10,0
OperatorSelection Byte "Select Operator(+,-,*,/):",10,0

.code
main PROC

    mov eax, 9h ; Blue text
    mov ebx, 0  ; Black background 
    call SetTextColor 


    mov edx, OFFSET IntroMessage
    call WriteString
    mov edx, OFFSET OperatorSelection
    call WriteString
    call ReadChar

    mov eax, 7   ; White text
    mov ebx, 0   ; Black background 
    call SetTextColor

main ENDP ; Clean up
END main