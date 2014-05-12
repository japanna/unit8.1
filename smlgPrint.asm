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
n:        .word   9

# TABLE:  .word   3
# n:      .word   1

#	.globl  test_loop
 #       .globl  length_loop
#        .globl  string_space
	    
	    .text

main: 
 la $s1, table 				# s1 innehåller adressen 
 lw $s0, ($s1)				# s0 innehaller data
 
inloop: 
#li $v0, 5 					# inputkod 
#syscall 
#move $s0, $v0 				# ett inläst tal till s0 
 
#beq $s0, 0, continue 		# sluta loopen om talet är 0 
 
#sw $s0, ($s1) 				# lagra ordet 
 
#add $s1, $s1, 4 			# s1 är nästa adress 
#j inloop 					# gör igen 

#continue: 					# Här är första loopen (inläsning) slut 
 
# sub $s2, $s1, 4 			# s2 är sista talets adress 
 
#la $s1, table 				# s1 är första talets adress 
 
#outloop: 
 
#bgt $s1, $s2, end 			# När s1>s2 är vi klara 
 
#lw $s0 ($s1) 				# Lägg minnesord i s0 
 
#move $a0, $s0 
li $v0, 1 					# Skriv ut det 
syscall 
 
#li $v0, 11 					# Gör radbyte 
#li $a0, 10 
#syscall 
 
#add $s1, $s1, 4 			# s1 är nästa adress 
#j outloop 					# Fortsätt loopen 
 
							# Här är andra loopen (utskrift) slut 
 
end:

li $v0, 10 					# kod för att sluta 
syscall 
