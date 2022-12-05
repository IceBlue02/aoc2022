        
asciinewline			EQU		10
asciidash				EQU		44
asciicomma			    EQU		45
asciizero				EQU		48
wordsize				EQU		1
        
init
        ADR		R4, infile ; tracks position in string
        MOV		R5, #0 ; Working character from string
        MOV		R6, #0 ; Working number
        MOV		R7, #0 ; containing count					
        
main
        LDRB		R5, [R4] 		; Get next char
        CMP		R5, #0 			; Null terminates string
        BEQ		done
        CMP		R5, #asciinewline
        ADDEQ	R4, R4, #1 		; Skip over newline
        
        MOV		R0, R4			; Get the 4 numbers from the line
        BL		get_next_num
        MOV		R8, R1
        BL		get_next_num
        MOV		R9, R1
        BL		get_next_num
        MOV		R10, R1
        BL		get_next_num
        MOV     R11, R1
        MOV		R3, R1			; Move numbers into parameter positions
        MOV		R4, R0
        MOV		R0, R8
        MOV		R1, R9
        MOV		R2, R10
        BL		is_contained
        CMP     R0, #1
        BEQ     _main_inc

        ; Check for the case where fully contained
        MOV		R0, R8
        MOV		R1, R9
        MOV		R2, R10
        MOV     R3, R11
        BL      is_overlapped
_main_inc
        ADD		R7, R7, R0		; Increment total count using result
        
        B		main
done
        MOV R0, R7
        END
        
        ;		Given a string position where the pointer is at the start of a number, get the next
        ;		digit from the string.
        ;		R0 returns string pointer
        ;		R1 returns
get_next_num
        STMFD	SP!, {R4-R6, LR}
        MOV		R6, R0
        LDRB		R1, [R6], #1 ; Get next char and increment
        LDRB		R5, [R6], #1 ; Another digit?
        CMP		R5, #asciizero
        MOVLO   R0, R1
        BLO		_get_next_num_one_digit
        LSL		R1, R1, #8          ; Shift digit if two digits
        ORR		R0, R5, R1   ; Combine digits
        ADD		R6, R6, #1    ; Increment past separator
_get_next_num_one_digit
        BL		char2_to_int
        MOV		R1, R0
        MOV		R0, R6
        LDMFD	SP!, {R4-R6, PC}
        
        ;		Given the 4 numbers on the line, determines if the one group contains another
        ;		Format: R0-R1,R2-R3
        ;		R0 Returns 1 if contained, otherwise 

is_contained        
STMFD	SP!, {R4,	LR}
MOV		R4, R0
MOV		R0, #0
;		Determine whether the first or second section starts first
CMP		R4, R2
MOVEQ   R0, #1  ; If the two bounds are equal, must be contained
BHI		_is_contained_2_first
_is_contained_1_first
CMP		R1, R3
MOVHS	R0, #1
B		_is_contained_rt
_is_contained_2_first
CMP		R1, R3
MOVLS	R0, #1
_is_contained_rt
LDMFD	SP!, {R4,	PC}

is_overlapped        
        STMFD	SP!, {R4, R11, LR}
        MOV		R4, R0
        MOV     R0, #0
        CMP     R1, R4   ; Ensure lower of first pair is in R1, higher in R4
        MOVHI   R11, R1
        MOVHI   R1, R4
        MOVHI   R4, R11
_is_overlapped_t_1
        CMP     R2, R1
        BLO     _is_overlapped_t_2
        CMP     R2, R4
        MOVLS   R0, #1
        BLS     _is_overlapped_rt
_is_overlapped_t_2
        CMP     R3, R1
        BLO     _is_overlapped_rt
        CMP     R3, R4
        MOVLS   R0, #1
_is_overlapped_rt
        LDMFD	SP!, {R4, R11, PC}

        
        ;		Takes a 2 character numberic string and turns it into an int.
        ;		R0- Address of string variable
        ;		R0 Returns numeric value of int
        
char2_to_int	; R0- Address of both var
        STMFD	SP!, {R4-R6, LR}
        AND		R5, R0,  #0xFF00
        LSR		R5, R5, #8
        AND		R6, R0, #0xFF       ; Mask off unwanted data
        CMP     R5, #0
        SUBHI	R5, R5, #asciizero ; Get the integer value, if not empty
        SUB		R6, R6, #asciizero ; Get the integer value
        ;		My emulator has no MUL, so time for some shift/add hacks!
        ADD		R5, R5, R5, LSL #2 ;  (R5 + R5 * 2^2 = R5 + 4R5 = 5R5)
        ADD		R0, R6, R5, LSL #1 ;  (5R5 * 2^1 = 5R5 * 2 = 10R5)
        LDMFD	SP!, {R4-R6,	PC}
