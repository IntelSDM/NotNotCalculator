INCLUDE Irvine32.inc

.data
; Output Messages:
IntroMessage BYTE "Not Not Calculator:",0
OperatorMessage BYTE "Select Operator(+,-,*,/):",0
FirstInput BYTE "Input First Number: ",0
SecondInput BYTE "Input Second Number: ",0
ResultMessage BYTE "Result: ",0
SubtractionErrorMessage BYTE "First Number Is Greater Than Second Number. Retry with a correct number combination.",0
DivisionErrorMessage BYTE "Second Number Is 0. Retry with a correct number combination.",0
RemainderMessage Byte "Remainder: ",0
.code
main PROC
    mov eax, 9h ; Blue text
    mov ebx, 0  ; Black background 
    call SetTextColor 

    mov edx, OFFSET IntroMessage
    call WriteString

    call Crlf ; New line
    call Crlf ; New line

    Operator:
    ; Operator Input
    mov edx, OFFSET OperatorMessage
    call WriteString
    call ReadChar
    mov bl, al              ; Operator in BL


    call Crlf  ; New line
    
    Input1:
    ;First Number Input
    mov edx, OFFSET FirstInput
    call WriteString
    call ReadInt            ; Convert to int
    mov ecx, eax            ; Num 1 in ecx

    Input2:
    ; Second Number Input
    mov edx, OFFSET SecondInput
    call WriteString
    call ReadInt            ; Convert to int
    mov edx, eax            ; Num 2 in edx

    ; Operator Handler
    ; Just compare text to our operators, otherwise kill program
    cmp bl, '+'
    je AddNumbers
    cmp bl, '-'
    je SubtractNumbers
    cmp bl, '*'
    je MultiplyNumbers
    cmp bl, '/'
    je DivideNumbers
    jmp ExitProgram 

AddNumbers:
    add ecx, edx
    jmp Result

SubtractNumbers:
    sub ecx, edx
    js SubtractionNegativeError   ; Jump to negative error if result is negative
    jmp Result

MultiplyNumbers:
    imul ecx, edx
    jmp Result

DivideNumbers:
    mov eax, ecx 
    mov esi, edx
    mov edx, 0 ; clear edx, for some reason we cant use edx, must be clear
    mov ebx, esi ; divisor
    cmp esi, 0
    je DivisionNegativeError
    idiv ebx    ; eax = whole number, edx = remainder
    mov esi,edx ; store remainder from edx

    call Crlf ; New line
    mov edx, OFFSET ResultMessage
    call WriteString
    call WriteInt ; full value is in eax

    call Crlf ; New line
    mov edx, OFFSET RemainderMessage
    call WriteString
    mov eax, esi
    call WriteInt
    jmp ExitProgram


SubtractionNegativeError:
    mov edx, OFFSET SubtractionErrorMessage
    call WriteString
    call Crlf ; New line
    jmp Input1

DivisionNegativeError:
    mov edx, OFFSET DivisionErrorMessage
    call WriteString
    call Crlf ; New line
    jmp Input1
Result:
    call Crlf ; New line
    mov edx, OFFSET ResultMessage
    call WriteString
    mov eax, ecx            ; ECX to EAX for writeint
    call WriteInt

ExitProgram:
    exit

main ENDP ; Clean up
END main