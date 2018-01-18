.include "beta.uasm"

        BR(STEP1)   // start execution with Step 1

        // the array to be sorted
        A:      LONG(10) LONG(56) LONG(27) LONG(69) LONG(73) LONG(99)
                LONG(44) LONG(36) LONG(10) LONG(72) LONG(71) LONG(1)

ALEN = (. - A)/4    // determine number of elements in A

// Please enter your code for each of the steps below...

STEP1:swapped = r1
	  CMOVE(0,swapped)
       
STEP2:i = r0
	  CMOVE(0,i)
       
STEP3:ADDC(i,1,i)
	  CMPLTC(i,12,r7)
	  BEQ(r7, STEP5)
       
STEP4:MULC(i,4,R2) // i in R0, convert index into byte offset
// load address is Reg[Ra] + sxt(16-bit) literal
	  LD(R2,A,R3)   // loads A[i]
	  LD(R2,A-4,R4) // loads A[i-1]
	  CMPLE(R4,R3,R5)
	  BNE(R5,STEP3)
	  ST(R3,A-4,R2)
	  ST(R4,A,R2)
	  CMOVE(1,swapped)
	  BR(STEP3)
        
STEP5:BNE(swapped,STEP1)
       

// When step 5 is complete, execution continues with the
// checkoff code.  You must include this code in order to
// receive credit for completing the problem.
.include "checkoff.uasm"
