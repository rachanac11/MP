DATA Segment

msg_1 db 0AH,0DH,"String Program!"
menu_1 db 0AH,0DH,"1. Concatenate $"
menu_2 db 0AH,0DH,"2. Exit $"
menu_3 db 0AH,0DH,"Enter Choice : $"
menu_4 db 0AH,0DH,"Invalid Input $"
msg_a db 0AH,0DH,"Enter String 1: $"
msg_b db 0AH,0DH,"Enter String 2: $"
msg_c db 0AH,0DH,"Concatenation of two Strings is : $"

str1 db 100 dup(?)
str2 db 100 dup(?)
len1 dw 0000H
len2 dw 0000H

choice db ?

DATA ends

CODE Segment
ASSUME CS:CODE,DS:DATA

start :

mov AX,DATA;
mov DS,AX;

menu_pr proc

mov DX,offset msg_1;
mov AH,09H;
int 21H;

mov DX,offset menu_1;
mov AH,09H;
int 21H;

mov DX,offset menu_2;
mov AH,09H;
int 21H;

mov DX,offset menu_3;
mov AH,09H;
int 21H;

mov AH,01H;
int 21H;

sub AL,30H;
mov choice,AL;

cmp choice,02H;
je exit_label;

cmp choice,01H;
je con_label;

jmp inv_label;

exit_label:
call exit_pr;

con_label:
call con_pr;
call menu_pr;

inv_label:

mov DX,offset menu_4;
mov AH,09H;
int 21H;

call menu_pr;

ret
endp

exit_pr proc

mov AH,4CH;
int 21H;

ret
endp

con_pr proc

mov DX,offset msg_a;
mov AH,09H;
int 21H;

lea BX,str1;
mov SI,0000H;
mov CX,0000H;
call inp_pr;
mov len1,CX;

mov DX,offset msg_b;
mov AH,09H;
int 21H;

lea BX,str2;
mov SI,0000H;
mov CX,0000H;
call inp_pr;
mov len2,CX;

mov DX,offset msg_c;
mov AH,09H;
int 21H;

lea BX,str1;
mov SI,0000H;
mov CX,len1;
call disp_pr;

mov DX," ";
mov AH,02H;
int 21H;

lea BX,str2;
mov SI,0000H;
mov CX,len2;
call disp_pr;

ret
endp

inp_pr proc

next1:
mov AH,01H;
int 21H;

cmp AL,0DH;
je next2;

mov [BX+SI],AL;
inc SI;
inc CX;
jmp next1;

next2:
mov AL,00H;

ret
endp

disp_pr proc

loop_p:
mov DL,[BX+SI];
mov AH,02H;
int 21H;

inc SI;
loop loop_p;

ret
endp

CODE ends
end start
