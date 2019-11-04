DATA Segment

num_i db 0AH,0DH,"Enter the no. of inputs :$"
scan_i db 0AH,0DH,"Enter the no. :$"
ans_o db 0AH,0DH,"The sum of given nos. is :$"

arr db 40 dup(?)
num dw ?
sum dw 0000H

DATA ends

CODE Segment
ASSUME CS:CODE,DS:DATA

start:

mov AX,DATA;
mov DS,AX;

mov DX,offset num_i;
mov AH,09H;
int 21H;

mov CX,0000H;

mov AH,01H
int 21H
sub AL,30H
rol AL,04H
mov CL,AL;

mov AH,01H;
int 21H;
sub AL,30H;
add CL,AL;

mov num,CX;

lea BX,arr;
mov SI,0000H;


inp:

mov DX,offset scan_i;
mov AH,09H;
int 21H;

mov AH,01H;
int 21H;
mov AH,00H;
sub AL,30H;
rol AL,04H;
mov [BX+SI],AL;

mov AH,01H;
int 21H;
mov AH,00H;
sub AL,30H;
add [BX+SI],AL;

inc SI;

loop inp


calc:

lea BX,arr;
mov CX,num;
mov SI,0000H;

loopcalc:

mov AL,0000H;
mov AL,[BX+SI];
mov AH,00H;
add sum,AX;

inc SI;
loop loopcalc

ansdisp:

mov DX,offset ans_o;
mov AH,09H;
int 21H;

mov CX,0000H;

mov CX,sum;
and CX,0F000H;
ror CX,0CH;
cmp CL,0AH;
jc next;
add CL,07H;
next:
add CL,30H;
mov DL,CL;
mov AH,02H;
int 21H;

mov CX,sum;
and CX,0F00H;
ror CX,08H;
cmp CL,0AH;
jc next2;
add CL,07H;
next2:
add CL,30H;
mov DL,CL;
mov AH,02H;
int 21H;

mov CX,sum;
and CX,0F0H;
ror CX,04H;
cmp CL,0AH;
jc next3;
add CL,07H;
next3:
add CL,30H;
mov DL,CL;
mov AH,02H;
int 21H;

mov CX,sum
and CX,0FH;
cmp CL,0AH;
jc next4;
add CL,07H;
next4:
add CL,30H;
mov DL,CL;
mov AH,02H;
int 21H;

mov AH,4CH;
int 21H;

CODE ends
end start


