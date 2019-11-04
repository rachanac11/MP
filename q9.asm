Data Segment
    msg1 db 10,13,"1.Multiplication:$"
    msg2 db 10,13,"2.Division:$"
    msg3 db 10,13,"3.Exit:$"
    msg4 db 10,13,"Enter your Choice:$"
    msg5 db 10,13,"Enter the first number:$"
    msg6 db 10,13,"Enter the second number:$"
    msg7 db 10,13,"Multiplication of two number is:$"
    msg8 db 10,13,"Quotient is:$"
    msg9 db 10,13,"Remainder is:$"
    choice db ?
    res dw ?
Data Ends
Code Segment
    assume cs:code , ds:data
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
    mov AH,4CH
    INT 21H
laba:
    mov DX,offset msg5
    mov AH,09H
    INT 21H
    
    mov AH,01H
    INT 21H
    call Input
    ROL AL,04H
    mov BL,AL
    
    mov AH,01H
    INT 21H

    call Input
    add BL,AL    
    
    
    mov DX,offset msg6
    mov AH,09H
    INT 21H
   
    mov AH,01H
    INT 21H
    
    call Input
    ROL AL,04H
    mov CL,AL
    
    mov AH,01H
    INT 21H

    call Input
    add CL,AL    
    
    cmp choice,01H
        jnz labb
    mov AL,BL
    mul CL
    mov res,AX
    mov BX,AX
    
    
    mov DX,offset msg7
    mov AH,09H
    INT 21H
    
    AND BX,0F000H
    ROR BX,0CH
    
    call Output
    mov BX,res
    
    AND BX,0F00H
    ROR BX,08H
    
    call output
    
    mov BX,res
    
    AND BX,00F0H
    ROR BX,04H
    
    call output
    mov BX,res
    
    AND BX,000FH
    
    call output
    jmp menu
labb:
    cmp choice,02H
    mov AX,0000H
    mov AL,BL
    div CL
    mov res,AX
    mov BX,AX
    mov CL,AH
    
    mov DX,offset msg8
    mov AH,09H
    INT 21H
    
    mov BX,res
    AND BX,0F0H
    ROR BX,04H

    call output

    mov BX,res
    AND bx,0FH

    call output

    mov bl,cl
    mov DX,offset msg9
    mov AH,09H
    INT 21H
    
   
    call output
JMP MENU    
Input proc
    cmp AL,41H
        jc labi
    sub AL,07H
    labi:
        sub AL,30H
        ret
    endp
Output proc
    cmp BL,0AH
        jc labo
    add BL,07H
    labo: 
        add BL,30H
        mov DL,BL
        mov AH,02H
        INT 21H
        ret
    endp

Code ends
end start