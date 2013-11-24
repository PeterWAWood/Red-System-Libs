Red/System [
  Purpose:	"Multiple-precision integer library"
  Author:	"PeterWAWood"
  Version:	0.1.0
  File:		%libtommaths.reds		 
  Rights:	"A reduced implementation of LibTomMath authored by Tom St Denis"
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#define LTM-digit!			byte!				;; needs to hold 
												;;  DIGIT-BIT + 1 bits
#define LTM-digit-ptr!		[pointer! [byte!]]
#define LTM-word!			integer!			;; needs to hold 
												;;  2*DIGIT-BIT + 1 bits 
#define LTM-PREC			32          		;; default precision
												;;  (no. of digits)
#define LTM-DIGIT-BIT		7					;; bits in a digit

#define LTM-ZERO-DIGIT		#"^(00)"

#define LTM-LT				-1				    ;; less than
#define LTM-EQ				0				    ;; equal
#define LTM-GT				1               	;; greater than

#define	LTM-OKAY 			0	                ;; no error occurred
#define LTM-MEM				1               	;; out of memory
#define LTM-INVALID			2				    ;; invalid mp-integer
#define LTM-INVALID-ARGS	3               	;; invalid function arguments
												;;  were supplied
#define LTM-TOO-BIG			4				    ;; supplied number was too big

#define LTM-YES				true
#define LTM-NO				false
												
#define LTM-ZPOS       		0                  	;; positive integer
#define LTM-NEG        		1   			    ;; negative integer

LTM-MASK: (((as LTM-digit! 1) << as LTM-digit! LTM-DIGIT-BIT) - 
			(as LTM-digit! 1))

#define LTM-pad-size  [
	size: size + (LTM-PREC * 2) - (size % LTM-PREC)	
]

LTM-digit-index: 0
#define LTM-zero-set(digit start end) [
	LTM-digit-index: end
	until [
		digit/LTM-digit-index: LTM-ZERO-DIGIT
		LTM-digit-index: LTM-digit-index - 1
		LTM-digit-index < start
	]
]

#define LTM-zero?(a) [
	either a/used = 0 [LTM-YES] [LTM-NO]
]

LTM-int!: alias struct! [
	used		[integer!]
	alloc		[integer!]
	sign		[integer!]
	mp-digit	[LTM-digit-ptr!]
]

LTM-abs: func [
	"Provides the absolute value of a mp-int"
	a				[LTM-int!]	"The original integer"
	b				[LTM-int!]	"The absolute value"
	return:			[integer!]		"LTM-OKAY or an error code"
	/local
		response	[integer!]
][
	;; copy a to b
	if a <> b [
		response: LTM-copy a b
		if response <> LTM-OKAY [return response]
	]
	
	;; force sign of b to positive
	b/sign: LTM-ZPOS
	
	LTM-OKAY
	
]

LTM-add: func [
	"high level addition"
	a				[LTM-int!]			"The first integer of the addition"
	b				[LTM-int!]			"The second"
	c				[LTM-int!]			"The result of the addition"
	return:			[integer!]			"LTM-OKAY or an error code"
	/local
		response	[integer!]			;; call response code
		size-a		[integer!]			;; size of first integer
		size-b		[integer!]			;; size of second integer
][
	
	;; get sign of both inputs
	sign-a: a/sign
	sign-b: b/sign
	
	either sign-a = sign-b [				
		;; add the two numbers if they have the same sign
		c/sign: sign-a
		response: LTM-s-add a b c				
	][
		;; subtract the one with lesser magnitude from the other
		;; take the sign of the larger
		;; note: if the result of the addition is zero, LTM-clamp which is
		;;       called by both LTM-s-add and LTM-s-sub will ensure the sign
		;;		 is set correctly	
		either LTM-LT = LTM-cmp-mag a b  [
			c/sign: sign-b
			response: LTM-s-sub b a c
		][
			c/sign: sign-a
			response: LTM-s-sub a b c
		]	
	]
	
	response
	
]

LTM-clamp: func [
	"Trims unused digits from an mp-int!"
	mp-int			[LTM-int!]			"The integer to be trimmed"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		i			[integer!]	
][

	;; decrease used whilst the most significant digit is zero 
	i: mp-int/used
	while [
		all [
			LTM-ZERO-DIGIT = mp-int/mp-digit/i
			mp-int/used <> 0
		]
	][
		mp-int/used: mp-int/used - 1
		i: i - 1 
	]

	;; make sure sign is positive if size is zero
	if mp-int/used = 0 [mp-int/sign: LTM-ZPOS]
	
	LTM-OKAY
	
]

LTM-clear: func [
	"Clears a mp-int freeing the memory used for digits"
	mp-int			[LTM-int!]			"The integer to be cleared"
	return:			[integer!]			"LTM-OKAY or an error code"		
][
	
	;; check if the integer has already been cleared
	if mp-int/mp-digit = as LTM-digit-ptr! 0 [return LTM-INVALID]
	
	;; zero the digits before releasing the memory in case the user has
	;; mistakenly stored the address of the digits 
	if mp-int/used > 0 [
		LTM-zero-set(mp-int/mp-digit 1 mp-int/used)
	]

	;; free the memory
	free mp-int/mp-digit
	
	;; reset the structure members
	mp-int/mp-digit: as LTM-digit-ptr! 0
	mp-int/alloc: 0
	mp-int/used: 0
	mp-int/sign: LTM-ZPOS
	
	LTM-OKAY
	
]

LTM-cmp: func [
	"Compares two mp-ints "
	a				[LTM-int!]			"The first integer"
	b				[LTM-int!]			"The second integer"	
	return:			[integer!]				"LTM-GT, LTM-EQ or LTM-LT"
		
][
	
	;; compare on basis of sign
	if a/sign <> b/sign [
		either a/sign = LTM-NEG [
			return LTM-LT
		][
			return LTM-GT
		]
	]
	
	;; compare absolute values 
	either a/sign = LTM-NEG [
		LTM-cmp-mag b a			;; if negative reverse comparison
	][
		LTM-cmp-mag a b
	]
	
]

LTM-cmp-mag: func [
	"Compares the magnitude of two mp-ints (unsigned)"
	a				[LTM-int!]				"The first integer"
	b				[LTM-int!]				"The second integer"	
	return:			[integer!]				"LTM-GT, LTM-EQ or LTM-LT"
	/local
		i			[integer!]			
		
][
	
	;; compare on basis of non-zero digits
	if a/used > b/used [return LTM-GT]
	if a/used < b/used [return LTM-LT]
	if a/used = 0 [return LTM-EQ]         	;; both are zero
	
	;;compare from most significant digit
	i: a/used
	until [
		if a/mp-digit/i > b/mp-digit/i [return LTM-GT]
		if a/mp-digit/i < b/mp-digit/i [return LTM-LT]
				
		i: i - 1
		i < 1
	]

	LTM-EQ
	
]

LTM-copy: func [
	"Copies an mp-int to another"
	a				[LTM-int!]			"The integer to be copied"
	b				[LTM-int!]			"The copy"	
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		i			[integer!]
		response	[integer!]
	
][
	
	;; do nothing if a and b are the same
	if a = b [return LTM-OKAY]
	
	;; expand the destination if needed
	if a/used > b/alloc [
		response: LTM-grow b a/used
		if response <> LTM-OKAY [return response]
	]
	
	;; copy all the used digits from a to b
	if a/used > 0 [
		i: 1
		until [
			b/mp-digit/i: a/mp-digit/i
			i: i + 1
			i > a/used
		]
	]
		
	;; clear any remaining digits previously set in b
	if b/used > a/used [
		LTM-zero-set(b/mp-digit (a/used + 1) b/used)
	]
	
	;; copy used count and sign
	b/used: a/used
	b/sign: a/sign
	
	LTM-OKAY
	
]

LTM-copy-init: func [
	"Clones an mp-int, ie initialises an mp-int then copies the original"
	a				[LTM-int!]				"The cloan"
	b				[LTM-int!]				"The integer to be copied"	
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		response	[integer!]
	
][
	
	;; initialise the clone
	response: LTM-init a
	if response <> LTM-OKAY [return response]
	
	;; copy the orignal into the clone
	LTM-copy b a
	
]

LTM-div-2: func [
	"Divides an integer by 2"
	a				[LTM-int!]				"The integer to be halved"
	b				[LTM-int!]				"Half the integer"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		i			[integer!]				;; array index
		carry		[LTM-digit!]			;; carry digit
		next-carry	[LTM-digit!]			;; next carry digit to be applied
		oldused		[integer!]				;; to store b/used as input
		response	[integer!]				;; response code from library calls			
][

	;; make sure there are sufficient digits to store the result
	if b/alloc < a/used [
		response: LTM-grow b a/used
		if response <> LTM-OKAY [return response]
	]
	
	;; set used value of result
	oldused: b/used
	b/used: a/used
	
	;; divide by two, one digit at time
	carry: LTM-ZERO-DIGIT
	i: b/used
		
	until [
		
		;;get what will be the next carry digit from 
		;; the most significant bit of the current digit
		next-carry: a/mp-digit/i and as LTM-digit! 1
		
		;; now shift up this digit and add in previous carry
		b/mp-digit/i: (a/mp-digit/i >>> 1) or (carry << (LTM-DIGIT-BIT - 1))
		
		;;set the carry
		carry: next-carry
		
		i: i - 1
		i < 1
	]
		
	;; zero any excess digits that may not have been written over in the result
	if b/used < oldused [
		LTM-zero-set (b/mp-digit (b/used + 1) oldused)
	]
	
	;; finally set the sign
	b/sign: a/sign
	
	LTM-clamp b 						;; LTM-clamp retuns LTM-OKAY

]


LTM-grow: func [
	"Add space for more digits to a mp-int "
	mp-int			[LTM-int!]				"The integer to be expanded"
	size			[integer!]				"The desired size of the mp-int"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		tmp			[LTM-digit-ptr!]
][
	
	;; increase the size of mp-int if the requested size is greater than its
	;; current size
	if mp-int/alloc < size [
	
		;; ensure that there are always at least LTM-PREC digits empty 
		LTM-pad-size
	
		;; re-allocate the digit array
		;;  the required space is allocated to a temporary variable first
		;;	so that if there is a problem the original array is not lost
		tmp: allocate size
		if tmp = as LTM-digit-ptr! 0 [return LTM-MEM]
		
		;;  copy the existing data from mp-digit to tmp so that mp-digit can be
		;;   safely freed
		copy-memory tmp mp-int/mp-digit mp-int/alloc
		free mp-int/mp-digit
		mp-int/mp-digit: tmp
		
		;; zero excess digits and set alloc
		LTM-zero-set(mp-int/mp-digit mp-int/alloc size)
		mp-int/alloc: size

	]
	LTM-OKAY
]

LTM-init: func [
	"Initalises a new mp-int (multiple-precision integer)"
	mp-int			[LTM-int!]				"The integer to be intialised"
	return:			[integer!]				"LTM-OKAY or an error code"			
][

	;; allocate the memory
	mp-int/mp-digit: allocate  LTM-PREC
	
	;; return memory error if memory not allocated
	if mp-int/mp-digit = as LTM-digit-ptr! 0 [return LTM-MEM]
	
	;; set the digits to zero
	LTM-zero-set(mp-int/mp-digit 1 LTM-PREC)
	
	;; set the used to zero, allocated digits to the default precision
	;; and sign to positive	
	mp-int/used: 0
	mp-int/alloc: LTM-PREC
	mp-int/sign: LTM-ZPOS
	LTM-OKAY
]

LTM-init-multi: func [
	"Initalises multiple new mp-ints"
	[typed]
	count           [integer!]
	list            [typed-value!]				;; list of mp-ints 
	return:         [integer!]
	/local
		i			[integer!]
		j			[integer!]
		tmp-list	[typed-value!]		
][
	
	;; check that type of the mp-ints to be initalised
	;;  Red/System version 1 only allows checking that it is an alias
	i: 0
	tmp-list: list
	until [
		i: i + 1
		if not alias? tmp-list/type [return LTM-INVALID-ARGS]
		tmp-list: tmp-list + 1

		i = count
	]

	;; initialise the mp-ints, if a failure is encountered clear any 
	;;  previously initialised mp-ints
	i: 0
	tmp-list: list
	until [
		i: i + 1
		if LTM-OKAY <> LTM-init as LTM-int! tmp-list/value [
			;; clear any mp-ints that were successfully initalised
			if i > 1 [
				j: 1
				until [
					LTM-clear as LTM-int! list/value
					list: list + 1
					j: j + 1
					j = i	
				]
			]
			return LTM-MEM
		]
		
		tmp-list: tmp-list + 1
		i = count
	]
	
	LTM-OKAY
]

LTM-init-size: func [
	"Initalises a new mp-int (multiple-precision integer) to a given size"
	mp-int			[LTM-int!]				"The integer to be intialised"
	size			[integer!]				"Minimum number of digits"
	return:			[integer!]				"LTM-OKAY or an error code"		
][
	
	;; ensure that there are always at least LTM-PREC digits empty 
	LTM-pad-size
	
	;; allocate the memory
	mp-int/mp-digit: allocate  size
	
	;; return memory error if memory not allocated
	if mp-int/mp-digit = as LTM-digit-ptr! 0 [return LTM-MEM]
	
	;; set the digits to zero
	LTM-zero-set(mp-int/mp-digit 1 LTM-PREC)
	
	;; set the used to zero, allocated digits to the default precision
	;; and sign to positive	
	mp-int/used: 0
	mp-int/alloc: 2 * LTM-PREC
	mp-int/sign: LTM-ZPOS
	LTM-OKAY
]

LTM-lshd: func [
	"Shift left a number of digits"
	mp-int			[LTM-int!]				"The integer to be left shifted"
	shift			[integer!]				"Number of digits to be shifted"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		new-slot	[integer!]				;; used to shift digits
		old-slot	[integer!]				;; used to shift digits
		response	[integer!]				;;Response code from func calls
][
	;; if shift is 0 or less, there is nothing to do
	if shift < 1 [return LTM-OKAY]
	
	;; grow the size of the int if necessary
	if mp-int/used + shift > mp-int/alloc [
		response: LTM-grow mp-int mp-int/used + shift
		if response <> LTM-OKAY [return response]
	]
	
	;; copy the digits to their new position, starting with most significant
	;; and set the used to reflect the shift
	old-slot: mp-int/used
	mp-int/used: mp-int/used + shift
	new-slot: mp-int/used
	while [old-slot > 0][
		mp-int/mp-digit/new-slot: mp-int/mp-digit/old-slot
		new-slot: new-slot - 1
		old-slot: old-slot - 1
	]
	
	;; zero the lower digits
	LTM-zero-set(mp-int/mp-digit 1 shift)
	
	LTM-OKAY
]
	
LTM-mul-2: func [
	"Multiples an integer by 2"
	a				[LTM-int!]				"The integer to be doubled"
	b				[LTM-int!]				"Double the integer"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		i			[integer!]				;; array index
		carry		[LTM-digit!]			;; carry digit
		next-carry	[LTM-digit!]			;; next carry digit to be applied
		oldused		[integer!]				;; to store b/used as input
		response	[integer!]				;; response code from library calls
][

	;; make sure there are sufficient digits to store the response
	if b/alloc < (a/used + 1) [
		response: LTM-grow b (a/used + 1)
		if response <> LTM-OKAY [return response]
	]
	
	;; set used value of response
	oldused: b/used
	b/used: a/used
	
	;; multliply by two, one digit at time
	carry: LTM-ZERO-DIGIT
	i: 1
	
	until [
		
		;;get what will be the next carry digit from 
		;; the most significant bit of the current digit
		next-carry: a/mp-digit/i >>> (LTM-DIGIT-BIT - 1)
		
		;; now shift up this digit and add in previous carry
		b/mp-digit/i: ((a/mp-digit/i << 1) or carry) and LTM-MASK
		
		;;set the carry
		carry: next-carry
		
		i: i + 1
		i > a/used
	]
	
	;; add a new leading digit if there is a carry from the final shift
	;;  it will always be 1
	;; note: i has already been incremented to be a/used + 1
	if carry <> LTM-ZERO-DIGIT [
		b/mp-digit/i: as LTM-digit! 1
		b/used: b/used + 1
	]
	
	;; zero any excess digits that may not have been written over in the response
	if b/used < oldused [
		LTM-zero-set (b/mp-digit (b/used + 1) oldused)
	]
	
	;; finally set the sign
	b/sign: a/sign
	
	LTM-OKAY

]

LTM-mul-2d: func [
	"Shift left by a supplied number of bits"
	a				[LTM-int!]				"Number to have the shift applied"
	bit-count		[integer!]				"Number of bits to shift"
	c				[LTM-int!]				"Shifted integer"
	return:			[integer!]				" LTM-OKAY or error code"
	/local
		bits-left	[integer!]				;; Bits left to shift after digits
		carry		[LTM-digit!]
		i			[integer!]				;; loop counter
		mask		[LTM-digit!]			;; Bitmask for carries
		next-carry	[LTM-digit!]
		response	[integer!]				;; Response from lib calls
		shift		[integer!]				;; Number of bits to shift MSB
][
	;; copy a to c
	if (a <> c) [
		response: LTM-copy a c
		if response <> LTM-OKAY [return response]
	]
	
	;; extend c if needed
	if c/alloc < (c/used + (bit-count / LTM-DIGIT-BIT) + 1) [
		response: LTM-grow c (c/used + (bit-count / LTM-DIGIT-BIT) + 1)
		if response <> LTM-OKAY [return response]
	]
	
	;; first shift by the number of full digits in bit count
	if bit-count >= LTM-DIGIT-BIT [
		response: LTM-lshd c (bit-count / LTM-DIGIT-BIT)
		if response <> LTM-OKAY [return response]
	]
	
	;; then shift by the number of bits remaining
	bits-left: bit-count % LTM-DIGIT-BIT
	if bits-left > 0 [
		;; calc bitmask for carries
		mask: as LTM-digit! (1 << bits-left) - 1
		
		;; shift for MSBs
		shift: LTM-DIGIT-BIT - bits-left 
		
		;; initialise carry
		carry: as LTM-digit! 0
		
		;; shift each of the digits, applying the carry
		i: 1
		until [
			;; get the higher bits of the current word (ie the next carry)
			next-carry: (c/mp-digit/i >> shift) and mask
			
			;; shift the current digit and OR in the carry
			c/mp-digit/i: ((c/mp-digit/i << as LTM-digit! bits-left) or carry) and LTM-MASK
			
			;; set the carry to the carry bits of the current digit
			carry: next-carry
			
			i: i + 1
			i > c/used
		]
		
		;; set the final carry
		if carry <> as LTM-digit! 0 [
			c/used: c/used + 1
			i: c/used
			c/mp-digit/i: carry
		]
		
	]
	
	return LTM-clamp c				;; LTM-clamp returns LTM-OKAY
]

LTM-negate: func [
	"Negates an mp-int"
	a				[LTM-int!]				"The original integer"
	b				[LTM-int!]				"The negated integer"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		response	[integer!]
][
	
	;; copy a to b
	if a <> b [
		response: LTM-copy a b
		if response <> LTM-OKAY [return response]
	]

	;; force sign of zero values to positive, otherwise swap the sign
	either LTM-zero?(b) [
		b/sign: LTM-ZPOS
	][
		either a/sign = LTM-ZPOS [b/sign: LTM-NEG] [b/sign: LTM-ZPOS]	
	]
	
	LTM-OKAY
]

LTM-rshd: func [
	"Shift right a number of digits"
	mp-int			[LTM-int!]				"The integer to be right shifted"
	shift			[integer!]				"Number of digits to be shifted"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		new-slot	[integer!]				;; used to shift digits
		old-slot	[integer!]				;; used to shift digits
		old-used	[integer!]				;; store original used value
][
	;; if shift is 0 or less, there is nothing to do
	if shift < 1 [return LTM-OKAY]
	
	
	;; copy the digits to their new position, starting with least significant
	;; and set the used to reflect the shift
	old-used: mp-int/used
	old-slot: shift + 1
	mp-int/used: mp-int/used - shift
	new-slot: 1
	until [
		mp-int/mp-digit/new-slot: mp-int/mp-digit/old-slot
		new-slot: new-slot + 1
		old-slot: old-slot + 1
		new-slot > mp-int/used
	]
	
	;; zero the upper digits
	LTM-zero-set(mp-int/mp-digit (mp-int/used + 1) old-used)
	
	LTM-OKAY
]

LTM-set: func [
	"Sets a mp-int to a digit"
	mp-int			[LTM-int!]				"The integer to be set"
	mp-digit		[LTM-digit!]			"The digit"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		response	[integer!]
][
	;; check number can be stored in a single digit
	if mp-digit > LTM-MASK [return LTM-TOO-BIG]
	
	;; set to zero
	response: LTM-zero mp-int
	if response <> LTM-OKAY [return response]
	
	; set first digit
	mp-int/mp-digit/value: mp-digit and LTM-MASK
	either mp-int/mp-digit/value = LTM-ZERO-DIGIT [
		mp-int/used: 0
	][
		mp-int/used: 1
	]
	
	LTM-OKAY
	
]

LTM-set-int: func [
	"Sets a mp-int to a 32-bit integer"
	mp-int				[LTM-int!]			"The mp integer to be set"
	int					[integer!]			"The integer"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		i				[integer!]			;; loop counter
		j				[integer!]			;; temp
		k				[integer!]			;; temp
		response		[integer!]			;; response from lib calls
][
	
	LTM-zero mp-int
	
	;; set the mp-int four bits at a time ie 8 iterations
	i: 1
	until [
		
		;; shift the number four bits to the left
		response: LTM-mul-2d mp-int 4 mp-int

		if response <> LTM-OKAY [return response]
		
		;; OR in the top four bits of the source
		k: int >>> 28					;; These two statements are required
		j: 15 and k						;;  due to unexpected result if they 
										;;  are removed.
		mp-int/mp-digit/value: mp-int/mp-digit/value or (as LTM-digit! j)
							   
		;; shift the next four bits to the front of the integer
		int: int << 4
		
		;; increase used count on each iteration to be absolutely certain 
		;; nothing gets throw away by clamp (which is called in mul-2d)
		mp-int/used: mp-int/used + 1
		
		i: i + 1
		i > 8
	]
	
	;; remove leading zeros from the mp-int
	LTM-clamp mp-int 						;; returns LTM-OKAY 
	
]

LTM-sub: func [
	"high level subtraction"
	a					[LTM-int!]			"The initial integer"
	b					[LTM-int!]			"The integer to be subtracted"
	c					[LTM-int!]			"The result of the subtraction"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		response		[integer!]			;; call responseponse code
		size-a			[integer!]			;; size of first integer
		size-b			[integer!]			;; size of second integer
][
	
	;; get sign of both inputs
	sign-a: a/sign
	sign-b: b/sign
	
	either sign-a <> sign-b [				
		;; subtract a negative from a positive or +ve from a -ve
		;; in either case, add their magnitudes and use sign from 1st number
		c/sign: sign-a
		response: LTM-s-add a b c				
	][
		;; subtract a positive from a positive or -ve from -ve
		;; take the difference between their magnitudes
		;; subtract the smaller from the larger
		;; adjusting the sign as necessary
		either LTM-LT <> LTM-cmp-mag a b [
			;; first number is larger or they are equal in magnitude
			
			;; take sign from first one and subtract second from first
			c/sign: sign-a
			response: LTM-s-sub a b c
		][
			;; the second is of greater magnitude
			;; the responseult will have the opposite sign to the first number
			either sign-a = LTM-ZPOS [
				c/sign: LTM-NEG
			][
				c/sign: LTM-ZPOS
			]
			response: LTM-s-sub b a c
		]
	]

	response
	
]

LTM-s-add: func [
	"low level addition - absolute values"
	a				[LTM-int!]				"The first integer of the addition"
	b				[LTM-int!]				"The second"
	c				[LTM-int!]				"The responseult of the addition"
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		carry		[LTM-digit!]			;; carry digit
		i			[integer!]				;; counter
		min			[integer!]				;; min number of digits
		max			[integer!]				;; max number of digits
		oldused		[integer!]				;; value of c/used at start
		response	[integer!]				;; call responseponse code
		x			[LTM-int!]				;; used to point to larger of the 2 mp-int!
][
	
	;; find sizes and point x at the larger of the inputs
	either a/used > b/used [
		min: b/used
		max: a/used
		x: a
	][
		min: a/used
		max: b/used
		x: b
	]
	
	;; extend the responseult if needed
	if c/alloc < (max + 1) [
		response: LTM-grow c (max + 1)
		if response <> LTM-OKAY [return response]
	]
	
	;; get old used digit count and set new one
	oldused: c/used
	c/used: max + 1
	
	;; zero the carry
	carry: as LTM-digit! 0
	
	;; perform the addition
	
	;;add the digits which both numbers have
	;; compute sum one digit at a time
	i: 1
	until [						
		;; Sum[i] = A[i] + B[i] + Carry
		c/mp-digit/i: a/mp-digit/i + b/mp-digit/i + carry
		
		;; carry = carry bit of Sum[i]
		carry: c/mp-digit/i >>> LTM-DIGIT-BIT
		
		;; take away carry bit from Sum[i]
		c/mp-digit/i: c/mp-digit/i and LTM-MASK

		;; increment counter and pointers
		i: i + 1
		
		i > min
	]

	;; now copy the "higher" digits, remembering to carry where needed
	if max > min [
		i: min + 1
		until [
			;; add each digit with the carry
			c/mp-digit/i: x/mp-digit/i + carry

			;; get carry for next digit
			carry: c/mp-digit/i >>> LTM-DIGIT-BIT

			;; take away carry from Sum[i]
			c/mp-digit/i: c/mp-digit/i and LTM-MASK
			
			i: i + 1
			
			i > max
		]
	]
	
	;; add in the last carry
	;;  no need to check for non-zero as any leanding zeroes will be removed by 
	;;  calling clamp
	i: max + 1
	c/mp-digit/i: carry

	;; clear any digits in responseult that may have been left over
	if oldused > max [ LTM-zero-set(b/mp-digit (max + 1) oldused)]
	
	;; remove any leading zeros
	;; clamp will return okay or an error
	LTM-clamp c
	
]

LTM-s-mul-digs: func [
	{multiples absolute values of two integers
	  only computes up to the number of digits supplied in args }
	a					[LTM-int!]			"First integer"
	b					[LTM-int!]			"Second integer"
	c					[LTM-int!]			"The result"
	digits				[integer!]			" Number of digits to be computed"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		carry			[LTM-digit!]		;; carry digit
		i				[integer!]			;; counter
		min				[integer!]			;; min number of digits
		max				[integer!]			;; max number of digits
		oldused			[integer!]			;; value of c/used at start
		response		[integer!]			;; call response code
][

	;; can the fast multiplier be used
	
	
	LTM-OKAY	
]

LTM-s-sub: func [
	"low level subtraction - absolute values - first number must be larger of two"
	a					[LTM-int!]			"The larger integer"
	b					[LTM-int!]			"The integer to be subtracted"
	c					[LTM-int!]			"The result"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		carry			[LTM-digit!]		;; carry digit
		i				[integer!]			;; counter
		min				[integer!]			;; min number of digits
		max				[integer!]			;; max number of digits
		oldused			[integer!]			;; value of c/used at start
		response		[integer!]			;; call response code
][
	
	;; find sizes
	min: b/used
	max: a/used
	
	;; extend the responseult if needed
	if c/alloc < max [
		response: LTM-grow c max
		if response <> LTM-OKAY [return response]
	]
	
	;; get old used digit count and set new one
	oldused: c/used
	c/used: max
	
	;; zero the carry
	carry: as LTM-digit! 0
	
	;; perform the subtraction
	
	;;subtract the digits which both numbers have
	;; compute answers one digit at a time
	i: 1
	until[						
		;; C[i] = A[i] - B[i] - Carry
		c/mp-digit/i: a/mp-digit/i - b/mp-digit/i - carry
		
		;; carry = carry bit of C[i]
		carry: c/mp-digit/i >>> LTM-DIGIT-BIT
		
		;; take away carry bit from Sum[i]
		c/mp-digit/i: c/mp-digit/i and LTM-MASK

		;; increment counter and pointers
		i: i + 1
		
		i > min
	]

	;; now copy the "higher" digits, remembering to carry where needed

	if max > min [
		i: min + 1
		until [
			;; copy each digit but remembering the carry
			c/mp-digit/i: a/mp-digit/i - carry

			;; get carry for next digit
			carry: c/mp-digit/i >>> LTM-DIGIT-BIT

			;; take away carry from C[i]
			c/mp-digit/i: c/mp-digit/i and LTM-MASK
			
			i: i + 1
			
			i > max
		]
	]
	
	;; clear any digits in result that may have been left over
	if oldused > max [ LTM-zero-set(c/mp-digit (max + 1) oldused)]
	
	;; remove any leading zeros
	;; clamp will return okay or an error
	LTM-clamp c
	
]	

LTM-zero: func [
	"Sets a mp-int to zero"
	mp-int				[LTM-int!]			"The integer to be zeroed"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		i				[integer!]
][
	
	mp-int/sign: LTM-ZPOS
	mp-int/used: 0
	
	i: 1
	until [
		mp-int/mp-digit/i: LTM-ZERO-DIGIT
		i: i + 1
		i > mp-int/alloc
	]
	
	LTM-OKAY
	
]
