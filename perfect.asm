# perfect.asm -- tests all integers between 5 and 500, 
#                and print out only the “perfect” ones
# by: Anna Ntenta CSCI E-10b, 2014

## Register usage:
##	$s0	- counter for the sum of divisors
##	$s1	- lower limit
##	$s2 - upper limit
##	$t5	- counter for division of number
##	$t0	- test for remainder of 0
##	$a0	- syscall parameter



	.data

	newline:         .asciiz  "\n"
#	Upper_Limit:  .word   500
#	Lower_Limit:  .word   5

	.text

main:
	li $s0, 0					# represents the sum

	li $s1, 5 					# lower limit
	li $s2, 500 				# upper limit

count:
	beq $s1, $s2, end 			# if we've counted up to 500, end
	li $t5, 1 					# counter for division

inner:
	beq $s1, $t5, increment		# we're done dividing this number
	div $s1, $t5				# divide s1 by a number less than itself 
	mfhi $t0					# the remainder is in HI - check if zero
	beqz $t0, summarize			# if the remainder is 0, add it to sum
	add $t5, $t5, 1				# otherwise increment divisor
	b inner					# check if next number is a divisor



summarize:
	add $s0, $s0, $t5			# add divisor to current sum of divisors
	
	add $t5, $t5, 1				# increment divisor
	beq $s0, $s1, is_sum		# if sum equals current number
	blt $s0, $s1, inner	  		# if the sum is less than the number looked at, 
								#    keep finding divisors
	
	bgt $s0, $s1, increment		# if sum is equal to number but not all divisors found
								# , it's not a perfect no 

							

print:
	li $s0, 0					# reset sum
	move $a0, $s1 				# print the perfect number
	li $v0, 1 					
	syscall

	la     $a0, newline	    	# and then print out a newline.
	li     $v0, 4
	syscall

	add $s1, $s1, 1 			# increment number we're looking at
	b count 					# goto beginning of outer loop



end:
li $v0, 10 					# quit program
	syscall

is_sum:
	beq $t5, $s1, print		# if the divisor equals the number we're looking at, 
								# print the number 

increment:
	add $s1, $s1, 1 		# increment number we're looking at
	li $s0, 0				# reset sum
	b count 				# goto beginning of outer loop

