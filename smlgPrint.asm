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

table:    .word   3  -1  6  5  7  -3  -15  18  2 
store: 	  .space  8									#store max & min
n:        .word   9

# TABLE:  .word   3
# n:      .word   1

#	.globl  test_loop
 #       .globl  length_loop
#        .globl  string_space
	    
	.text

main:
	la $t1, n 					# t1 is the address of the quantity of items
	lw $s3, ($t1) 				# s3 contains the data at addres t1
	add $s3, $s3, 1 			# add 1 to the number so that we don't quit too soon

	li $t0, 0					# counter of elements in table

	la $s0, table 				# s0 is the address of the table 
	lw $s1, ($s0)				# s1 contains the data at address s0,
 								# (the first integer in the table)
 	add $t0, $t0, 1 			# increment counter

 	add $s0, $s0, 4				# s0 is now the address of the second int
	lw $s2, ($s0)				# s2 contains the data at address s0
	add $t0, $t0, 1 			# increment counter


compare:
	beq $t0, $s3, end			# if counter equals no of elements we end				
	bgt $s1, $s2, greater		# if s1 > s2

 	smaller:					# else
 	lw $s1, $s2					# the greater int is stored in s1
 	add $s0, $s0, 4				
 	lw $s2, ($s0)				# the next in to be compared is s2
 	add $t0, $t0, 1 			# increment counter
 	j compare 					# compare again

 	greater:
	add $s0, $s0, 4				# s0 is now the address of the next int
	lw $s2, ($s0)				# s2 contains the data at address s0
	add $t0, $t0, 1 			# increment counter
	j compare 					# compare again

end:
	move $a0, $s1 
	li $v0, 1 # Skriv ut det 
	syscall 

	li $v0, 10 # kod för att sluta 
	syscall


	# if s1 > s2 , store next int in s2, compare s1 & s2 again

	# if s1 < s2, store s2 in s1, store next int in s2, compare s1, s2 again

