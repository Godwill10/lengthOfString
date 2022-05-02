

.data
  stringVariableName:  .asciiz   "Hello"
  stringVariableNameTWO:  .asciiz   "Population"
  text:  .asciiz   "The length of the string is "
  endst:  .asciiz   ".\n"
  answer: .word 0

.text
main:
  # push the ra register to the stack
  addi $sp,  $sp,  -4
  sw   $ra,  0($sp)

# Call the function by first putting the address of the array into $a0
  la $a0, stringVariableName    # Load address of stringVariableName
  jal strlen
  sw  $v0, answer

  # Print out the answer
  la   $a0,  text          # The address of the first letter of the string 'The sum is '
  addi $v0,  $zero, 4       # 4 prints a string
  syscall
  lw   $a0,  answer          # put the value of interest into $a0
  addi $v0,  $zero, 1       # prepare to print an int
  syscall
  la   $a0,  endst          # The address of the first letter of the string
  addi $v0,  $zero, 4       # 4 prints a string
  syscall

  # restore the ra register to the stack
  lw   $ra,  0($sp)
  addi $sp,  $sp,  4
  jr   $ra

# Finds the length of the stringVariableName
strlen:
  # push registers to the stack
  addi $sp,  $sp,  -12
  sw   $ra,  0($sp)
  sw   $s0,  4($sp)
  sw   $s1,  8($sp)

  # put arguments into s registers
  addi $s0,  $a0,   0      # base address of stringVariableName

  # initialize counter to zero
  add  $s1,  $zero, $zero

  # loop to get the length of stringVariableName
loop:
  lb $t1, 0($s0) #load the next character into t1
  beq $t1, $zero, exit # check for the null character
  addi $s0, $s0, 1 # increment the string pointer
  addi $s1, $s1, 1 # increment the count
  j loop # return to the top of the loop

exit:
  addi $v0, $s1, 0       #sum into return register v0

  lw   $ra,  0($sp)
  lw   $s0,  4($sp)
  lw   $s1,  8($sp)
  addi $sp,  $sp,  12

jr $ra
