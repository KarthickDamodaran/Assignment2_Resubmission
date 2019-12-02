     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY
;Input is given in s3 register. Number of Series terms in s6 register. Exponent of input is available in s9
__main  FUNCTION	
     VLDR.F32 s6,=20;Number of series terms required
	 VLDR.F32 s5,=1;used for decrementing or incrementing purposes
	 VLDR.F32 s8,=0;current iteration number 
	 VLDR.F32 s9,=0;Result is available here
sign VLDR.F32 s7,=1;hold the factorial result. initialised with 1 as 0!=1
     VMOV.F32 s10,s8;store the iteration count to retrieve later
loop VCMP.F32 s8, #0;if 0, don't disturb s7 as 0!=1 which is already present in s7
     vmrs    APSR_nzcv, FPSCR
     BEQ next
     VMUL.F32 s7,s8,s7;if n!=0,iteratively calculate the factorial result till the final result is available in s7
     VSUB.F32 s8,s8,s5
     B loop
	 
next VMOV.F32 s8,s10;retrieving the current iteration count
     VLDR.F32 s3,=100;Number for which e^x is to be calculated i.e x
	 VLDR.F32 s5,=1;
	 VLDR.F32 s4,=1;holds the x^n term. Initialised with 1 as x^0=1
	 VCMP.F32 s8,#0;If n==0, don't disturb s4
	 vmrs    APSR_nzcv, FPSCR
	 BEQ new
	 
term VMUL.F32 s4,s4,s3;if n!=0, iteratively calculate till the s4 register holds x^n
     VSUB.F32 s8,s8,s5
	 VCMP.F32 s8,#0
	 vmrs    APSR_nzcv, FPSCR
	 BGT term
	 
new  VDIV.F32 s4,s4,s7;Calculate the series term, i.e (x^n)/n!
     VADD.F32 s9,s4,s9;accumulate the series terms in s9 register
	 VMOV.F32 s8,s10;Retrieve the iteration count
	 VADD.F32 s8,s8,s5;Increment it
	 VCMP.F32 s8,s6;Repeat till the required number of series terms are calculated
	 vmrs    APSR_nzcv, FPSCR
	 BLT sign
	 
stop B stop	 
     ENDFUNC
     END 