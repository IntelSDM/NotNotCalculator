INCLUDE Irvine32.inc

.data
; Output Messages:
IntroMessage BYTE "Not Not Calculator:",0
OperatorMessage BYTE "Select Operator(+,-,*,/):",0
FirstInput BYTE "Input First Number: ",0
SecondInput BYTE "Input Second Number: ",0
ResultMessage BYTE "Result:",0
.code
main PROC
    mov eax, 9h ; Blue text
    mov ebx, 0  ; Black background 
    call SetTextColor 

    mov edx, OFFSET IntroMessage
    call WriteString

    call Crlf ; New line
    call Crlf ; New line

    ; Operator Input
    mov edx, OFFSET OperatorMessage
    call WriteString
    call ReadChar
    mov bl, al              ; Operator in BL


    call Crlf  ; New line

    ;First Number Input
    mov edx, OFFSET FirstInput
    call WriteString
    call ReadInt            ; Convert to int
    mov ecx, eax            ; Num 1 in ecx

    ; Second Number Input
    mov edx, OFFSET SecondInput
    call WriteString
    call ReadInt            ; Convert to int
    mov edx, eax            ; Num 2 in edx

    ; Operator Handler
    ; Just compare text to our operators, otherwise kill program
    cmp bl, '+'
    je AddNumbers
    jmp ExitProgram 

AddNumbers:
    call Crlf ; new line
    add ecx, edx
    mov edx, OFFSET ResultMessage
    call WriteString
    mov eax, ecx            ; ECX to EAX for writeint
    call WriteInt

ExitProgram:
    exit

main ENDP ; Clean up
END main