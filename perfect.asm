# perfect.asm -- tests all integers between 5 and 500, 
#                and print out only the “perfect” ones
# by: Anna Ntenta CSCI E-10b, 2014

## Register usage:
##	$t1	- address of the number of elements in table
##	$s3	- number of elements in table
##	$t0 - counter of elements compared
##	$s0	- the address of the table
##	$s1	- contains the max integer
##	$s5	- contains the min integer
##	$a0	- syscall parameter



	.data

	numbers: 	.space 40			# allocate space in memory (more than enough) 
	newline:         .asciiz  "\n"
#	Upper_Limit:  .word   500
#	Lower_Limit:  .word   5

	.text

main:
	la $t1, numbers				# t1 is the address of the first divisor number

	li $s0, 0					# represents the sum
	li $s3, 0					# represents counter of numbers of divisors
	li $t4, 0					# counts how many numbers have been printed

	li $s1, 5 					# lower limit
	li $s2, 500 				# upper limit

find_divisors:
	div $s2, $s1				# divide s2 by s1 
	mfhi $t0					# the remainder is in HI - get it to check
	beqz $t0, summarize			# if the remainder is 0, add it to sum
	add $s1, $s1, 1				# otherwise increment lower limit
	b find_divisors				# check if next number is a divisor



summarize:
	sw $t0, ($t1)					# store the divisor in numbers at address t1
	add $s3, $s3, 1 			# increment counter of divisors
	add $t1, $t1, 4 				# the next address that we'll store a divisor at
	add $s0, $s0, $t0			# current sum of divisors
	blt $s0, $s2, find_divisors # if the sum is less than 500, keep finding divisors
	beq $s0, $s2, print			# if the sum equals 500, print all divisors 

print:
	la $t1, numbers				# t1 is the address of the first divisor number
inner:
	beq $t4, $s3, end			# if we have printed all divisors, end
	lw $a0, ($t1) 			# else
	li $v0, 1 					# print the divisor
	syscall
	la $a0, newline	    	# and then print out a newline.
	li $v0, 4
	syscall
	add $t4, $t4, 1 			# increment print counter
	add $t1, $t1, 4 			# increment the address that we'll find a divisor at
	b inner						# repeat



end:
li $v0, 10 					# quit program
	syscall
