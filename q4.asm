Data segment
    msg1 db 10,13,"1.Accept the string$"
    msg2 db 10,13,"2.Read the String$"
    msg3 db 10,13,"3.Length of the String$"
    msg4 db 10,13,"4.Reverse of the string$"
    msg5 db 10,13,"5.Exit$"
    msg6 db 10,13,"Enter you Choice:$"
    msg7 db 10,13,"Enter String:$"
    msg8 db 10,13,"The string entered is :$"
    msg9 db 10,13,"The length of the string is:$"
    msg10 db 10,13,"The reverse string is:$"
    choice db ?
    len db ?
Data ends

Code segment
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
    
    mov DX,offset msg5
    mov AH,09H
    INT 21H
    
    mov DX,offset msg6
    mov AH,09H
    INT 21H
    
    mov AH,01H
    INT 21H
    
    sub AL,30H
    mov choice,AL
    cmp choice,05H
        jnz lab1
    mov AH,4CH
    INT 21H
    
lab1:
    cmp AL,01H
        jnz lab2
    call accept
    jmp menu
 
accept proc    
    mov SI,1000H
    mov DI,2000H
    mov CX,0000H
    
    mov DX,offset msg7
    mov AH,09H
    INT 21H
    
back:    
    mov AH,01H
    INT 21H
    
    cmp AL,0DH
    je comp
    
    inc CX
    
    mov [SI],AL
    mov [DI],AL
    
    
    inc SI
    inc DI
    
    jmp back
comp:
    mov len,CL
    ret 
    endp    
    
lab2:
    cmp AL,02H
        jnz lab3
    call display
    jmp menu
    
display proc
    mov DX,offset msg8
    mov AH,09H
    INT 21H
    
    mov CL,len
    mov CH,00H
    mov SI,1000H
    
disp:
    mov DL,[SI]
    mov AH,02H
    INT 21H
    
    inc SI
    
    loop disp
    ret 
    endp
    
lab3:
    cmp AL,03H
       jnz lab4
    call lengths
    jmp menu

lengths proc
    mov DX,offset msg9
    mov AH,09H
    INT 21H
    
    mov BL,len
    call dispnum
    ret 
    endp

dispnum proc
    mov AL,BL
    AND AL,0F0H
    ROR AL,04H

    mov DL,AL
    call output
    
    mov AH,02H
    INT 21H

    mov AL,BL
    AND AL,0FH

    mov DL,AL
    call output
    mov AH,02H
    INT 21H
   
    endp

Output proc
    cmp DL,0AH
        jc labo
        add DL,07H
    labo: 
        add DL,30H
        ret 
        endp
        
lab4:
    cmp AL,04H
     call reverse
     jmp menu
     
reverse proc
    mov DX,offset msg10
    mov AH,09H
    INT 21H
    
    mov CL,len
    mov CH,00H
    mov SI,1000H
    add SI,CX
    dec SI
    
dispr:
    mov DL,[SI]
    mov AH,02H
    INT 21H
    
    dec SI
    loop dispr
    ret 
    endp
    
Code ends
end start    