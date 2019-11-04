#include<stdio.h>
#include<conio.h>

void main()
{
 int count,n;
 clrscr();
 printf("ENTER THE VALUE OF COUNT : ");
 scanf("%d",&count);
 while(n!=3)
 {
 printf("ENTER THE CHOICE \n1.INCREMENT \n2.DECREMENT\n3.EXIT \n :");
 scanf("%d",&n);
 switch(n)
 {
 case 1:
 asm mov cx, count;
 asm mov ah,01h;
 asm inc cl;
 asm int 10h;
 printf("\n\n");
 break;
 case 2:
 asm mov cx, count;
 asm mov ah,01h;
 asm dec cl;
 asm int 10h;
 printf("\n\n");
 break;
 case 3:
 asm mov ah,01h;
 asm int 10h;
 break;
}
}
 getch();
}
