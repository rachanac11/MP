Data Segment
    msg1 db 10,13,"1.Addition$"
    msg2 db 10,13,"2.Subtraction$"
    msg3 db 10,13,"3.Exit$"
    msg4 db 10,13,"Enter your Choice:$"
    msg5 db 10,13,"Enter the first number:$"
    msg6 db 10,13,"Enter the second number:$"
    msg7 db 10,13,"Addition of two number is:$"
    msg8 db 10,13,"Subtraction of two number is:$"
    msg9 db 10,13,"Invalid choice$"
    choice db ?
    num dw ?
Data Ends

Code Segment
    assume cs:code,ds:data
Start:
    mov AX,data
    mov DS,AX
    
menu:
    mov DX,offset msg1
    mov AH,09H
    INT 21H
    
    mov DX,offset msg2
    mov AH,09H
    INT 21H
    
    mov DX,offset msg3
    mov AH,09H
    INT 21H
    
    mov DX,offset msg4
    mov AH,09H
    INT 21H
    
    mov AH,01H
    INT 21H
    
    sub AL,30H
    mov choice,AL
    cmp choice,03H
        jnz laba
    Mov AH,4CH
    INT 21H

laba:
    mov DX,offset msg5
    mov AH,09H
    INT 21H
    
    mov AH,01H
    INT 21H
    
    call input
    ROL AL,04H
    mov BL,AL
    
    mov AH,01H
    INT 21H
    
    call input
    add BL,AL
    mov BH,BL
    
    mov AH,01H
    INT 21H
    
    call input
    ROL AL,04H
    mov BL,AL
    
    mov AH,01H
    INT 21H
    
    call input
    add BL,AL
    
    mov DX,offset msg6
    mov AH,09H
    INT 21H
    
    mov AH,01H
    INT 21H
    
    call input
    ROL AL,04H
    mov CL,AL
    
    mov AH,01H
    INT 21H
    
    call input
    add CL,AL
    mov CH,CL
    
    mov AH,01H
    INT 21H
    
    call input
    ROL AL,04H
    mov CL,AL
    
    mov AH,01H
    INT 21H
    
    call input
    add CL,AL
    
    cmp choice,01H
        jnz labb
    mov DX,offset msg7
    mov AH,09H
    INT 21H
    
    add BX,CX
    
    mov num,BX
    
    AND BX,0F000H
    ROR BX,0CH
    call output
    
    mov BX,num
    
    AND BX,0F00H
    ROR BX,08H
    call output
    
    mov BX,num
    
    AND BX,00F0H
    ROR BX,04H
    call output
    
    mov BX,num
    
    AND BX,000FH
    
    call output
    
    jmp menu
    
labb:
    cmp choice,02H
        jnz labc
    mov DX,offset msg8
    mov AH,09H
    INT 21H
    
    sub BX,CX
    
    mov num,BX
    
    AND BX,0F000H
    ROR BX,0CH
    call output
    
    mov BX,num
    
    AND BX,0F00H
    ROR BX,08H
    call output
    
    mov BX,num
    
    AND BX,00F0H
    ROR BX,04H
    call output
    
    mov BX,num
    
    AND BX,000FH
    
    call output
    
    jmp menu
    
labc:
    mov DX,offset msg9
    mov AH,09H
    INT 21H
    
    jmp menu
Input proc
    cmp AL,41H
        jc labi
    sub AL,07H
    labi:
        sub AL,30H
        ret
    endp
Output proc
    cmp BX,000AH
        jc labo
        add BX,0007H
    labo: 
        add BX,0030H
        mov DX,0000H
        mov DL,BL
        mov AH,02H
        INT 21H
        ret
    endp

Code ends
end Start