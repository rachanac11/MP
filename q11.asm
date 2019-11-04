Data segment
    msg1 db 10,13,"1.Accept the string$"
    msg2 db 10,13,"2.Read the String$"
    msg3 db 10,13,"3.Palindrome ?$"
    msg4 db 10,13,"4.Exit$"
    msg5 db 10,13,"Enter you Choice:$"
    msg6 db 10,13,"Enter String:$"
    msg7 db 10,13,"The string entered is :$"
    msg8 db 10,13,"The string is palindrome$"
    msg9 db 10,13,"The string is not palindrome$"
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
    
    
    mov AH,01H
    INT 21H
    
    sub AL,30H
    mov choice,AL
    cmp choice,04H
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
    
    mov DX,offset msg6
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
    mov DX,offset msg7
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
        
    call checkpal
    jmp menu

checkpal proc
 mov al,len
 mov ah,00h
 mov bl,02h
 div bl
 mov cl,len
 dec cl
 mov ch,00h
 mov di,1000h
 mov si,1000h
 add di,cx
 mov cl,al
 mov ch,00h
 
     pchk: 
 mov al,[si]
 cmp al,[di]
 jnz np
 inc si
 dec di
 loop pchk

 mov dx,offset msg8
 mov ah,09h
 int 21h
 ret
 
      np: 
      mov dx,offset msg9
 mov ah,09h
 int 21h
 ret
endp    

Code ends
end start    