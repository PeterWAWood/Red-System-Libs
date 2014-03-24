Red/System [
  Purpose:	"Shift left by a supplied number of bits"
  Author:	"PeterWAWood"
  Version:	0.1.0
  File:		%libtommaths.reds		 
  Descripton:	"A reduced implementation of LibTomMath authored by Tom St Denis"
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-mul-2d: func [
	"Shift left by a supplied number of bits"
	a                 				[LTM-int!]				"Number to have the shift applied"
	bit-count		              [integer!]				"Number of bits to shift"
	c				                  [LTM-int!]				"Shifted integer"
	return:			              [integer!]				" LTM-OKAY or error code"
	/local
		bits-left	              [integer!]				;; Bits left to shift after digits
		carry		                [LTM-digit!]
		i			                  [integer!]				;; loop counter
		mask		                [LTM-digit!]			;; Bitmask for carries
		next-carry	            [LTM-digit!]
		response	              [integer!]				;; Response from lib calls
		shift		                [integer!]				;; Number of bits to shift MSB
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