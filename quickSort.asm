////////////////////////////////////////////////////////////////////////////////
// Lab 6
////////////////////////////////////////////////////////////////////////////////

// Include the checkoff program:
.include "checkoff.uasm"

// Leave the following as zero to run ALL the test cases, and get your solution
//   validated if all pass.  If you have trouble with test case N, set it to N
//   to run JUST that test case (for easier debugging):
TestCase:       LONG(0)
//temp: LONG(0)

// Quicksort-in-place code.  We include the C/Python version here as a comment;
// you can use this as a model for your Beta assembly version:

//def partition(array,left,right):
//    # choose middle element of array as pivot
//    pivotIndex = (left+right) >> 1;
//    pivotValue = array[pivotIndex]
//
//    # swap array[right] and array[pivotIndex]
//    # note that we already store array[pivotIndex] in pivotValue
//    array[pivotIndex] = array[right]
//
//    # elements <= the pivot are moved to the left (smaller indices)
//    storeIndex = left
//    for i in xrange(left,right):  # don't include array[right]
//        temp = array[i]
//        if temp <= pivotValue:
//            array[i] = array[storeIndex]
//            array[storeIndex] = temp
//            storeIndex += 1
//
//    # move pivot to its final place
//    array[right] = array[storeIndex]
//    array[storeIndex] = pivotValue;
//    return storeIndex;

partition:
        PUSH(LP)
        PUSH(BP)
        MOVE(SP, BP)
		PUSH(R1)
		PUSH(R2)
		PUSH(R3)
		PUSH(R4)
		PUSH(R5)
		PUSH(R6)
		PUSH(R7)
		PUSH(R8)
		PUSH(R9)
		
		
		p_array=R2          // base address of array (arg 0)
  		p_left=R3
  		p_right=R4
  		p_pivotIndex=R5     // Corresponds to PivotIndex in C program
  		p_pivotValue=R6
  		p_storeIndex=R7
		i=R8
		temp=R9

		LD(BP,-16,p_left)	// load left in R3 
		LD(BP,-20,p_right)	// load right in R4
		LD(BP,-12,p_array)	// load array in R2
				
		ADD(p_left,p_right,R1)	// left + right in R1
		SHRC(R1,1,p_pivotIndex)	// left + right shifted right once in R0, given to p_pivotIndex
		
		SHLC(p_pivotIndex,2,R1)	// 4*pivotIndex in R1
		ADD(p_array,R1,R1)	// get array[pivotIndex]
		LD(R1,0,p_pivotValue)	// load array[pivotIndex] in p_pivotValue
		
		
		//swaping array[right] with array[pivotIndex], array[pivotIndex] in p_pivotValue
		SHLC(p_right,2,R1)	// 4*p_right in R1
		ADD(p_array,R1,R1)
		LD(R1,0,R0)	// load array[right] in R0
		
		SHLC(p_pivotIndex,2,R1)
		ADD(p_array,R1,R1)		// get array[pivotIndex] address
		ST(R0,0,R1)	// store array[right] in array[pivotIndex]
		
		//swap done - start looping
		//initializing
		MOVE(p_left,p_storeIndex)	// put p_left in p_storeIndex
		MOVE(p_left,i) // put p_left in i
		
		BR(Ltest)
		
Lwhile:	SHLC(i,2,R0)		// convert i in address offset in R0
		ADD(p_array,R0,R0)
		LD(R0,0,R1)	// array[i] in R1
		MOVE(R1,temp)	// array[i] in temp
		
		CMPLE(temp,p_pivotValue,R1)	// temp <= p_pivotValue (if statement)
		ADDC(i,1,i)	// i += 1
		BF(R1,Ltest)	// if False, go to Ltest
		
		//if True continue
		SHLC(p_storeIndex,2,R1)	// convert p_storeIndex in offset address
		ADD(p_array,R1,R1)
		LD(R1,0,R1)		// Load array[storeIndex] in R1
		ST(R1,0,R0)		// put array[storeIndex] in array[i] reusing R0 calculation
		
		MOVE(temp,R0)	// load temp in R0		
		SHLC(p_storeIndex,2,R1)	// convert storeIndex in address offset
		ADD(p_array,R1,R1)
		ST(R0,0,R1)		// put temp in array[storeIndex]
		
		ADDC(p_storeIndex,1,p_storeIndex) // storeIndex = storeIndex + 1
		
		


Ltest:	CMPLT(i,p_right,R0)	// i < p_right in R0
		BT(R0,Lwhile)
		
		// end of loop
		
		SHLC(p_storeIndex,2, R0)
		ADD(p_array,R0,R0)
		LD(R0,0,R0)
		
		SHLC(p_right,2,R1)
		ADD(p_array,R1,R1)
		ST(R0,0,R1)
		
		SHLC(p_storeIndex,2,R0)
		ADD(p_array,R0,R0)
		ST(p_pivotValue,0,R0)
		
		MOVE(p_storeIndex, R0)
		

// Fill in your code here...

        
		POP(R9)
		POP(R8)
		POP(R7)
		POP(R6)
		POP(R5)
		POP(R4)
		POP(R3)
		POP(R2)
		POP(R1)
		MOVE(BP, SP)
        POP(BP)
        POP(LP)
        JMP(LP)


//def quicksort(array, left, right):
//    if left < right:
//        pivotIndex = partition(array,left,right)
//        quicksort(array,left,pivotIndex-1)
//        quicksort(array,pivotIndex+1,right)

// quicksort(ArrayBase, left, right)
quicksort:
        PUSH(LP)
        PUSH(BP)
        MOVE(SP, BP)
		PUSH(R1)
		PUSH(R2)
		PUSH(R3)
		PUSH(R4)

// Fill in your code here...
		
		LD(BP,-16,R2)   // load left in R2
		LD(BP,-20,R1)	// load right in R1
						
		CMPLT(R2,R1,R3) // compare left and right (left < right ?)
		BF(R3,exit)		// if left >= right go to exit sequence
		LD(BP,-12,R3)	// if left < right == True load array in R3
		
		//.breakpoint
		
		PUSH(R1)		// Push right, left and array (opposite order)
		PUSH(R2)
		PUSH(R3)
		BR(partition,LP)	// branch to partition
		DEALLOCATE(3)
		
		MOVE(R0,R4)		// put result of partition in R4
		
		SUBC(R4,1,R0)	// call quicksort(array, left, pivotIndex-1)
		PUSH(R0)
		PUSH(R2)
		PUSH(R3)
		BR(quicksort,LP)
		DEALLOCATE(3)
		
		ADDC(R4,1,R0)	// call quicksort(array, pivotIndex+1, right)
		PUSH(R1)
		PUSH(R0)
		PUSH(R3)
		BR(quicksort,LP)
		DEALLOCATE(3)
		

		
exit:	POP(R4)
		POP(R3)
		POP(R2)
		POP(R1)
		MOVE(BP, SP)
        POP(BP)
        POP(LP)
        JMP(LP)

// Allocate a stack: SP is initialized by checkoff code.
StackBasePtr:
        LONG(StackArea)

.unprotect

StackArea:
        STORAGE(1000)
