.globl binary_search
binary_search:
  // ADD YOUR SOLUTION HERE 
  mov r3, #0          // set the startIndex to 0, r3 is the lower bound
  mov r4, r2          // set the endIndex = valuve from r2 , r4 is the upper bound
  sub r4, r4, #1      // r4 = length - 1
  mov r5, r4          // middleIndex is r5
  lsr r5, r5, #1      // r5 is the value of r4 >> #1 (left shift) by 2
  mov r6, #-1         // r6 is the value of keyIndex = -1
  mov r10, #1         // r10 is value of NumIters = 1
  mov r11, #0         // r11 is the value of numbers[middleIndex]

  While_Loop: 
              cmp r6, #-1
              bne Exit
              cmp r3, r4                   // compare the value of r3 and r4
              bgt Value_not_found          // if startIndex > endIndex goes to Value_not_found
              ldr r11, [r0, r5, lsl #2]    // load the value from numbers[middleIndex] to r11 [r11 = adderess (r0 + r5*4)]
              cmp r11, r1                  // compare the value of numbers[middleIndex] and key.
              beq Value_found              // if numbers[middleIndex] == key, the key of the value searched for is found
              bgt Key_is_lower             // if the key of the value searched for is lower than the the value from numbers[middleIndex], goes to this block
              blt Key_is_higher            // if the key of the value searched for is hier than the the value from numbers[middleIndex], goes to this block
  
  Key_is_lower:
              rsb r11, r10, #0             // numbers[ middleIndex ] = -NumIters
              str r11, [r0, r5, lsl #2]    // stores -NumIters to the address of numbers[middleIndex]
              mov r4, r5                   // endIndex = r5
              sub r4, r4, #1               // endIndex = middleIndex-1
              sub r5, r4, r3               // endIndex - startIndex
              lsr r5, r5, #1               // (endIndex - startIndex)/2
              add r5, r3, r5               // middleIndex = startIndex + (endIndex - startIndex)/2
              add r10, r10, #1             // NumIters ++
              B While_Loop

  Key_is_higher:
              rsb r11, r10, #0             // numbers[ middleIndex ] = -NumIters
              str r11, [r0, r5, lsl #2]    // stores -NumIters to the address of numbers[middleIndex]
              mov r3, r5                   // startIndex = r5
              add r3, r3, #1               // startIndex = middleIndex+1
              sub r5, r4, r3               // endIndex = middleIndex-1
              lsr r5, r5, #1               // (endIndex - startIndex)/2
              add r5, r3, r5               // middleIndex = startIndex + (endIndex - startIndex)/2
              add r10, r10, #1             // NumIters ++
              B While_Loop

  Value_not_found:
              B Exit      // return -1
  Value_found:
              mov r6, r5  // store the middleIndex in r6
              B Exit      // retrun r6

  Exit:
  mov r0, r6     // store r6 to r0
  mov pc, lr     // return keyIndex