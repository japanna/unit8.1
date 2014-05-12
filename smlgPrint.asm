# palindrome.asm -- reads a line of text and tests whether it is a palindrome.
## Register usage:
##	$t1	- A.
##	$t2	- B.
##	$t3	- the character *A.
##	$t4	- the character *B.
##	$v0	- syscall parameter / return values.
##	$a0	- syscall parameters.
##	$a1	- syscall parameters.


	.data

#table:    .word   3  -1  6  5  7  -3  -15  18  2 
#n:        .word   9

 table:  .word   3
 n:      .word   1

newline:         .asciiz  "\n"

	    
	.text

main:
	la $t1, n 					# t1 is the address of the quantity of items
	lw $s3, ($t1) 				# s3 contains the data at addres t1
	
	li $t0, 0					# counter of elements in table

	la $s0, table 				# s0 is the address of the table 
	lw $s1, ($s0)				# s1 contains the data at address s0,
 								# (the first integer in the table)
 	add $t0, $t0, 1 			# increment counter

 	beq $t0, $s3, end2			# if counter equals no of elements we end
 								# (this is the case when there is only one element)

 	add $s0, $s0, 4				# s0 is now the address of the second int
	lw $s2, ($s0)				# s2 contains the data at address s0
	add $t0, $t0, 1 			# increment counter

	add $s3, $s3, 1 			# add 1 to the quantity of elements so that 
								# we don't quit too soon


findMax:
	beq $t0, $s3, reset			# if counter equals number of elements				
	bgt $s1, $s2, greater		# else: if s1 > s2

 	move $s1, $s2				# the greater int is stored in s1
 	add $s0, $s0, 4				
 	lw $s2, ($s0)				# the next in to be compared is s2
 	add $t0, $t0, 1 			# increment counter
 	j findMax 					# compare again

 	greater:
	add $s0, $s0, 4				# s0 is now the address of the next int
	lw $s2, ($s0)				# s2 contains the data at address s0
	add $t0, $t0, 1 			# increment counter
	j findMax 					# compare again

reset:
	li $t0, 0					# reset counter of elements
	la $s0, table 				# s0 is the address of the table 
	lw $s5, ($s0)				# s5 contains the data at address s0,
 								# (the first integer in the table)
 	add $t0, $t0, 1 			# increment counter

	add $s0, $s0, 4				# s0 is now the address of the second int
	lw $s6, ($s0)				# s2 contains the data at address s0
	add $t0, $t0, 1 			# increment counter

	
findMin:

	beq $t0, $s3, end			# if counter equals number of elements				
	blt $s5, $s6, smaller		# else: if s5 < s6

 	move $s5, $s6				# the smaller int is stored in s5
 	add $s0, $s0, 4				
 	lw $s6, ($s0)				# the next in to be compared is s6
 	add $t0, $t0, 1 			# increment counter
 	j findMin 					# compare again

 	smaller:
	add $s0, $s0, 4				# s0 is now the address of the next int
	lw $s6, ($s0)				# s6 contains the data at address s0
	add $t0, $t0, 1 			# increment counter
	j findMin 					# compare again


end:
	move $a0, $s1 
	li $v0, 1 					# Print the max number 
	syscall 

	la     $a0, newline	    	# and then print out a newline.
	li     $v0, 4
	syscall

	move $a0, $s5 
	li $v0, 1 					# Print the min number 
	syscall 

	la     $a0, newline	    	# and then print out a newline.
	li     $v0, 4
	syscall

	li $v0, 10 					# quit program 
	syscall

end2:
	move $a0, $s1 
	li $v0, 1 					# Print the max number 
	syscall 

	la     $a0, newline	    	# and then print out a newline.
	li     $v0, 4
	syscall

	move $a0, $s1 
	li $v0, 1 					# Print the min number (same number as above)
	syscall 

	la     $a0, newline	    	# and then print out a newline.
	li     $v0, 4
	syscall

	li $v0, 10 					# quit program
	syscall


