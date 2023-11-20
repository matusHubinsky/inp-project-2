; Autor reseni: Matúš Hubinský xhubin04

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
.data
login:			.asciiz "xhubin04"  ; sem doplnte vas login
cipher:			.space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
				; retezce pro vypis pomoci syscall 5
				; (viz nize "funkce" print_string)      

; CODE SEGMENT
.text

main:   
	; initiallize registers
	daddu	r9, r0, r0
	daddi	r11, r0, 0 
	daddi   r25, r0, 0

do_while_begin:
	; check if character is number
	daddi	r4, r0, 58
	lb      r22, login(r11)
	dsubu   r22, r22, r4

test_number:
	; condition
	slt	 	r9, r22, r0  
	; load value
	lb		r4, login(r11)
	beq		r9, r0, not_num  
	; character is number, so we must end program and print cipher
	jal move_cipher

not_num:
	; choose next state
	beq		r25, r0, add_key 	; jump to add_key if r25 is 0
	bne 	r25, r0, sub_key	; jump to sub_key if r25 is 1
	
add_key:
	; set next iteration to sub_key
	daddi	r25, r0, 1
	lb		r4, login(r11)
	; + 'h'
	daddi	r22, r0, 104		
	daddu	r4, r4, r22
	; - 'a'
	daddi	r22, r0, 96
	dsubu 	r4, r4, r22
	jal do_while_body

sub_key:
	; set next iteration to add_key
	daddi	r25, r0, 0
	lb		r4, login(r11)
	; - 'u'
	daddi	r22, r0, 117		
	dsubu 	r4, r4, r22
	; + 'z'
	daddi	r22, r0, 122
	daddu 	r4, r4, r22
	jal do_while_body

do_while_body:
	; modulo
	daddi	r22, r0, 123
	slt		r9, r4, r22
	bne		r9, r0, add_value
	beq		r9, r0, sub_value

sub_value:			
	daddi r22, r0, 26
	dsubu r4, r4, r22
	jal do_while_end

add_value:
	daddi r22, r0, 0
	daddu r4, r22, r4				
	jal do_while_end

do_while_end:
	; store current cipher index
	sb 		r4, cipher(r11)
	daddi	r11, r11, 1

	; check if whole login is ciphered
	bne		r4, r0, do_while_begin
	
move_cipher:
	; string have to be ended with 0 character
	daddi	r11, r11, 1
	daddi	r4, r0, 0
	sb 		r4, cipher(r11)
	; printing cipher
	daddi	r4, r0, cipher			; move cipher to r4
	jal print_string
	syscall 0   ; halt


print_string:   ; adresa retezce se ocekava v r4
	sw      r4, params_sys5(r0)
	daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
	syscall 5   ; systemova procedura - vypis retezce na terminal
	jr      r31 ; return - r31 je urcen na return address
