Data segment
msg1 db 10, 13, "1.Addition $"
msg2 db 10, 13, "2.Subtraction $"
msg3 db 10, 13, "3.Multiplication $"
msg4 db 10, 13, "4.Division $"
msg5 db 10, 13, "5.Exit $"
msg6 db 10, 13, "Enter choice: $"
msg7 db 10, 13, "Enter first: $"
msg8 db 10, 13, "Enter second: $"
msg9 db 10, 13, "Result: $"
msg10 db 10, 13, "Quotient: $"
msg11 db 10, 13, "Remainder: $"
num1 dw ?
num2 dw ?
res dw ?
res2 dw ?
choice db ?
Data ends

Code Segment    
    assume cs: code, ds: data
    start:
    mov AX, data
    mov DS, AX

    menu:        
        mov DX, offset msg1
        mov AH, 09H    
        INT 21H    

        mov DX, offset msg2    
        mov AH, 09H    
        INT 21H    

        mov DX, offset msg3
        mov AH, 09H   
        INT 21H
  
        mov DX, offset msg4
        mov AH, 09H
        INT 21H

        mov DX, offset msg5
        mov AH, 09H
        INT 21H    

        mov DX, offset msg6
        mov AH, 09H
        INT 21H
   
        mov AH, 01H
        INT 21H
        sub AL, 30H
        mov choice, AL

        cmp AL, 05H
        jnz lblNos
        mov AH, 4CH
        INT 21H
    lblNos: 
        mov DX, offset msg7
        mov AH, 09H
        INT 21H   
            
        call Input
        mov num1, BX  
        
        mov DX, offset msg8     
        mov AH, 09H
        INT 21H     

        call Input
        mov num2, BX        
    lblAdd:
        mov AL, choice
        cmp AL, 01H
        jnz lblSub
        mov BX, num1
        mov CX, num2
        add BX, CX
        mov res, BX
        
        mov DX, offset msg9
        mov AH, 09H
        INT 21H
            
            call Output         
        jmp menu
    lblSub:
        mov AL, choice
        cmp AL, 02H
        jnz lblMul
        mov BX, num1
        mov CX, num2
        sub BX, CX
        mov res, BX
        
        mov DX, offset msg9
        mov AH, 09H
        INT 21H
            
            call Output         
        jmp menu
    lblMul:
        mov AL, choice
        cmp AL, 03H
        jnz lblDiv
        mov AX, num1
        mov CX, num2
        mul CX
        mov res, DX
        mov res2, AX
        
        mov DX, offset msg9
        mov AH, 09H
        INT 21H
                
        mov BX, res
            call Output
        mov BX, res2
        mov res, BX
        call Output         
        jmp menu
    lblDiv:
        mov AL, choice
        cmp AL, 04H
        mov DX, 0000H
        mov AX, num1
        mov BX, num2
        div BX
        mov res2, DX    ;remainder
        mov res, AX ;quotient
        
        mov DX, offset msg10
        mov AH, 09H
        INT 21H
                
        mov BX, res
            call Output

        mov DX, offset msg11
        mov AH, 09H
        INT 21H
      
        mov BX, res2
        mov res, BX
        call Output        
        jmp menu
    Input proc
        mov AH, 01H
        INT 21H
        call AsciiConv
        mov CL, 04H
        rol AL, CL
        mov BL, AL
 
        mov AH, 01H
        INT 21H
        call AsciiConv
        add BL, AL
        mov BH, BL
    
        mov AH, 01H
        INT 21H
        call AsciiConv
        mov CL, 04H
        rol AL, CL
        mov BL, AL
 
        mov AH, 01H
        INT 21H
        call AsciiConv
        add BL, AL
    ret
    endp

    Output proc
        and BX, 0F000H
        mov CL, 0CH
        ror BX, CL
        call AsciiReConv

        mov BX, res 
        and BX, 0F00H
        mov CL, 08H
        ror BX, CL    
        call AsciiReConv

        mov BX, res 
        and BX, 0F0H
        mov CL, 04H
        ror BX, CL
        call AsciiReConv
  
        mov BX, res
        and BX, 0FH    
        call AsciiReConv
    ret
    endp

    AsciiConv proc
        cmp AL, 41H
        jc labi
        sub AL, 07H
        labi:
            sub AL, 30H
        ret
    endp   

    AsciiReConv proc
        cmp BX, 000AH
        jc labo
        add BX, 0007H
        labo:
            add BX, 0030H
        mov DX, 0000H
        mov DL, BL
        mov AH, 02H
        INT 21H
        ret
    endp    

code ends
end start


