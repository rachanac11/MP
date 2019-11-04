Data Segment
    msg1 db 10,13,"1.Addition:$"
    msg2 db 10,13,"2.Subtraction:$"
    msg8 db 10,13,"3.Exit:$"
    msg3 db 10,13,"Enter your Choice:$"
    msg4 db 10,13,"Enter the first number:$"
    msg5 db 10,13,"Enter the second number:$"
    msg6 db 10,13,"Addition of two number is:$"
    msg7 db 10,13,"Subtraction of two number is:$"
    choice db ?
Data Ends

Code Segment
   assume cs:code, ds:data
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
    
    mov DX,offset msg8
    mov AH,09H
    INT 21H
    
    mov DX,offset msg3
    mov AH,09H
    INT 21H
    
    mov AH,01H
    INT 21H
    
    sub AL,30H
    mov choice,AL
    cmp choice,03H
        jnz lab1
    mov AH,4CH
    INT 21H
    
    
lab1:
    mov DX,offset msg4
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
    
    
    mov DX,offset msg5
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
        jnz lab2
    add BL,CL
    
    mov DX,offset msg6
    mov AH,09H
    INT 21H
    
    mov CL,BL
    
    AND BL,0F0H
    ROR BL,04H
    
    call Output
    mov BL,CL
    
    AND BL,0FH
    
    call Output
   
    jmp menu
   
lab2:
    cmp choice,02H
        
    sub BL,CL
    
    mov DX,offset msg7
    mov AH,09H
    INT 21H
    
    mov CL,BL
    
    AND BL,0F0H
    ROR BL,04H
    
    call Output
    mov BL,CL
    
    AND BL,0FH
    
    call Output
   
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

code ends
end start