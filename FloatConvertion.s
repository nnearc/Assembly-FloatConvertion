
#################################################################
#
#Program Name      : This Program return the integer part of a Single
#			precision Float IEEE754
#Programmer        : Nearchos Nearchou
#Date Last Modif.  : 16 Sep. 2019
#################################################################
# Comments :
#
# A program that get a Single precision Float IEEE754 
#	and prints the integer part
#################################################################


# The start of the data segment
.data


 msg1: .asciiz "Please give a Float number:" 
 msg2: .asciiz "Sign: "
 msg3: .asciiz "Exponent: "
 msg4: .asciiz "Power: "
 msg5: .asciiz "Mantissa: "
 msg6: .asciiz "\n"
 msg7: .asciiz "The Integer value is: "  
 msg8: .asciiz "/"

# The start of text segment
  .text
  .globl main
main :
	
	la $a0,msg1
	li $v0,4
	syscall		#Place the question 

	li $v0,6	#Read a FLOAT
	syscall		#Get x
	
	mfc1  $s0, $f0 	#move floating point number to $s0

	jal convert_s2i

	move $s0,$v0
	la $a0,msg2	#"Sign"
	li $v0,4
	syscall
	move $a0,$t0	#Retured value
	li $v0,1
	syscall

 	addiu $v0,$0,4	# print new line "\n"
	la $a0,msg6
	syscall

	la $a0,msg3	#"Exponent"
	li $v0,4
	syscall
	move $a0,$t1	#Retured value
	li $v0,1
	syscall

 	addiu $v0,$0,4	# print new line "\n"
	la $a0,msg6
	syscall

	la $a0,msg4	#"POWER"
	li $v0,4
	syscall
	sub $t1,$t1,127	#minus 127 to get the POWER
	move $a0,$t1	#Retured value
	li $v0,1
	syscall

 	addiu $v0,$0,4	# print new line "\n"
	la $a0,msg6
	syscall

	la $a0,msg5	#"Mantissa"
	li $v0,4
	syscall
	move $a0,$t2	#Retured value
	li $v0,1
	syscall

	addiu $v0,$0,4	# print new line "\n"
	la $a0,msg6
	syscall

	la $a0,msg7	#"The Integer value is"
	li $v0,4
	syscall
	move $a0,$s0	#Retured value
	li $v0,1
	syscall

exit:
	li $v0,10	#Call EXIT system call(exit system call)
	syscall

convert_s2i:
	move $s1, $ra    #save return address into s1
	jal get_sign
	jal get_exponent
	jal get_mantissa
	move $ra, $s1    #restore return address that was saved into s1
	jr $ra

get_sign:
	srl $t0, $s0, 31        #$t0 = Sign Bit
	jr $ra

get_exponent: 
	sll $t1, $s0, 1
	srl $t1, $t1, 24       #t1 = Exponent Bit   
	jr $ra

get_mantissa:
	sll $t2, $s0, 9
	srl $t2, $t2, 9         #t2 = Mantissa A
	jr $ra