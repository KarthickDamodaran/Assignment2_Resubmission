#include<stdio.h>
#include<conio.h>
#include<math.h>
double fact(int );
void main()
{
int n=100,x,i;
double w=100,pow_r,fact_r,term,result=0;
clrscr();
for(i=0;i<n;i++)
{
fact_r=fact(i);
pow_r=pow(w,i);
term=pow_r/fact_r;
result=result+term;
}
printf("Output: %lf",result);
getche();
}

double fact(int i)
{
double a=1;
while(i>0)
{
a=a*i;
i--;
}
return a;
}