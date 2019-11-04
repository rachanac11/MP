Data Segment
msg db 0dh, 0ah, "ENTER THE NUMBER OF ELEMENTS IN THE ARRAY : $"
msg1 db 0dh, 0ah, "ENTER THE NUMBER : $"
newl db 0dh, 0ah, "$"
result db 0dh,0ah, "THE MINIMUM IS : $"
len db ?
min db ?
Data ends
Code segment
    assume CS: code, DS: data
start:
    mov ax,Data
    mov DS,ax
    
    mov dx,offset msg
    mov ah,09h
    int 21h
    
    call accept
    
    mov len,bl
    mov cl,bl
    mov ch,00h
    
    mov di,1000h
    
    back:
    mov dx,offset msg1
    mov ah,09h
    int 21h
    call accept
    mov [di],bl
    inc di
    loop back
    
    mov di,1000h
    mov cl,len
    mov ch,00h
    
    mov dx,offset newl
    mov ah,09h
    int 21h
    
    mov al,[di]
    mov min,al
    
    mi:
    mov bl,min
    mov al,[di]
    cmp bl,al
    jc a
    mov min,al
    jmp b
    a: mov min,bl
    b: inc di
    loop mi
    
    mov dx,offset result
    mov ah,09h
    int 21h
    
    mov bl,min
    call dispNum
    
    mov ah,4ch
    int 21h
    
    accept proc
    mov ah,01h
    int 21h
    call asciiconv
    rol al,4
    mov bl,al
    mov ah,01h
    int 21h
    call asciiconv
    add bl,al
    ret
    endp
    
    dispNum proc
    mov cl,bl
    and bl,0f0h
    ror bl,4
    call AsciiConv1
    mov dl,bl
    mov ah,02h
    int 21h
    mov bl,cl
    and bl,0fh
    call AsciiConv1
    mov dl,bl
    mov ah,02h
    int 21h
    ret 
    endp
    
    AsciiConv proc
    cmp al,41h
    jc skip
    sub al,07h
    skip: sub al,30h
    ret
    endp

    AsciiConv1 proc
    cmp bl,0ah
    jc skip1
    add bl,07h
    skip1: add bl,30h
    ret
    endp

Code ends
end start