Red/System [
	Title:   "Red/System lib tom maths tests"
	Author:  "Peter W A Wood"
	File: 	 %litommaths-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../../../../Languages/Red/quick-test/quick-test.reds
#include %../libtommaths.reds

print-digits: func [
	mp-int				[LTM-int!]
	/local
	bp					[LTM-digit-ptr!]
	i					[integer!]
][
	print ["The digits (least significant first) are:" lf]	
	bp: mp-int/mp-digit
	i: 0
	while [i < mp-int/used][
		print [as integer! bp/value lf]
		i: i + 1
		bp: bp + 1
	]
]

~~~start-file~~~ "lib tom maths"

===start-group=== "mp-init"
	--test-- "mi1"
		mi1-mp-int: declare LTM-int!
		response: LTM-init mi1-mp-int
	--assert response = LTM-OKAY
	--assert mi1-mp-int/used = 0
	--assert mi1-mp-int/alloc = LTM-PREC
	--assert mi1-mp-int/sign =  LTM-ZPOS
	--assert 0 <> as integer! mi1-mp-int/mp-digit
		mi1-i: mi1-mp-int/alloc
		until [
			--assert mi1-mp-int/mp-digit/value = null-byte
				mi1-mp-int/mp-digit: mi1-mp-int/mp-digit + 1
				mi1-i: mi1-i - 1
				mi1-i = 0
		]

===end-group===

===start-group=== "mp-clear"
	--test-- "mc1"
		mc1-mp-int: declare LTM-int!
		response: LTM-init mc1-mp-int
	--assert response = LTM-OKAY
		mc1-mp-int/used: 1
		mc1-mp-int/sign: LTM-NEG
		response: LTM-clear mc1-mp-int
	--assert response = LTM-OKAY
	--assert mc1-mp-int/used = 0
	--assert mc1-mp-int/alloc = 0
	--assert mc1-mp-int/sign = LTM-ZPOS
	--assert mc1-mp-int/mp-digit = as byte-ptr! 0
	
	--test-- "mc2"
		mc2-mp-int: declare LTM-int!
		response: LTM-init mc2-mp-int
	--assert response = LTM-OKAY
		response: LTM-clear mc2-mp-int
	--assert response = LTM-OKAY
		mc2-mp-int/used: 1
		response: LTM-clear mc2-mp-int
	--assert response = LTM-INVALID	
	--assert mc2-mp-int/used = 1

===end-group===

===start-group=== "mp-grow"

	--test-- "mg1"
		mg1-mp-int: declare LTM-int!
		response: LTM-init mg1-mp-int
	--assert response = LTM-OKAY
		mg1-i: mg1-mp-int/mp-digit
		mg1-i/value: #"^(01)"
		mg1-i: mg1-i + 1
		mg1-i/value: #"^(FF)"
		mg1-bp: allocate 8 				;; allocate memory to try to avoid
										;; same memory being allocated.
		response: LTM-grow mg1-mp-int LTM-PREC + 1
	--assert response = LTM-OKAY
	--assert mg1-mp-int/alloc = (3 * LTM-PREC)
		mg1-j: mg1-mp-int/mp-digit
	--assert mg1-j/value = #"^(01)"
		mg1-j: mg1-j + 1
	--assert mg1-j/value = #"^(FF)"
		free mg1-bp
		response: LTM-clear mg1-mp-int
	--assert response = LTM-OKAY
	
	--test-- "mg2"
		mg2-mp-int: declare LTM-int!
		response: LTM-init mg2-mp-int
	--assert response = LTM-OKAY
		response: LTM-grow mg2-mp-int LTM-PREC - 1
	--assert response = LTM-OKAY
	--assert mg2-mp-int/alloc = LTM-PREC
		response: LTM-clear mg2-mp-int
	--assert response = LTM-OKAY

===end-group===

===start-group=== "mp-init-size"
	--test-- "mis1"
		mis1-mp-int: declare LTM-int!
		response: LTM-init-size mis1-mp-int 1
	--assert response = LTM-OKAY
	--assert mis1-mp-int/used = 0
	--assert mis1-mp-int/alloc = (2 * LTM-PREC)
	--assert mis1-mp-int/sign =  LTM-ZPOS
	--assert 0 <> as integer! mis1-mp-int/mp-digit
		mis1-i: mis1-mp-int/alloc
		mis1-bp: mis1-mp-int/mp-digit
		until [
			--assert mis1-bp/value = null-byte
				mis1-bp: mis1-bp + 1
				mis1-i: mis1-i - 1
				mis1-i = 0
		]
		response: LTM-clear mis1-mp-int
	--assert response = LTM-OKAY

===end-group===

===start-group=== "mp-init-multi"

	--test-- "mim1"
		mim1-mp-int1: declare LTM-int!
		mim1-mp-int2: declare LTM-int!
		response: LTM-init-multi [mim1-mp-int1 mim1-mp-int2]
	--assert response = LTM-OKAY
	--assert mim1-mp-int1/used = 0
	--assert mim1-mp-int2/used = 0
	--assert mim1-mp-int1/alloc = LTM-PREC
	--assert mim1-mp-int2/alloc = LTM-PREC
	--assert mim1-mp-int1/sign =  LTM-ZPOS
	--assert mim1-mp-int2/sign =  LTM-ZPOS
	--assert 0 <> as integer! mim1-mp-int1/mp-digit
	--assert 0 <> as integer! mim1-mp-int2/mp-digit
		mim1-i: mim1-mp-int1/alloc
		mim1-bp: mim1-mp-int1/mp-digit
		until [
			--assert mim1-bp/value = null-byte
				mim1-bp: mim1-bp + 1
				mim1-i: mim1-i - 1
				mim1-i = 0
		]
		response: LTM-clear mim1-mp-int1
	--assert response = LTM-OKAY
		mim1-i: mim1-mp-int2/alloc
		mim1-bp: mim1-mp-int2/mp-digit
		until [
			--assert mim1-bp/value = null-byte
				mim1-bp: mim1-bp + 1
				mim1-i: mim1-i - 1
				mim1-i = 0
		]
		response: LTM-clear mim1-mp-int2
	--assert response = LTM-OKAY
		
===end-group===

===start-group=== "mp-clamp"
	--test-- "mcl1"
		mcl1-mp-int: declare LTM-int!
		response: LTM-init mcl1-mp-int
	--assert response = LTM-OKAY
		mcl1-mp-int/used: 4
		mcl1-mp-int/sign: LTM-NEG
		response: LTM-clamp mcl1-mp-int
	--assert response = LTM-OKAY
	--assert mcl1-mp-int/used = 0
	--assert mcl1-mp-int/alloc = LTM-PREC
	--assert mcl1-mp-int/sign = LTM-ZPOS
	--assert mcl1-mp-int/mp-digit <> as byte-ptr! 0
		response: LTM-clear mcl1-mp-int
	--assert response = LTM-OKAY
	
	--test-- "mcl2"
		mcl2-mp-int: declare LTM-int!
		response: LTM-init mcl2-mp-int
	--assert response = LTM-OKAY
		mcl2-mp-int/used: 4
		mcl2-mp-int/sign: LTM-ZPOS
		mcl2-mp-int/mp-digit/value: #"^(01)"
		response: LTM-clamp mcl2-mp-int
	--assert response = LTM-OKAY
	--assert mcl2-mp-int/used = 1
	--assert mcl2-mp-int/sign = LTM-ZPOS
	--assert mcl2-mp-int/alloc = LTM-PREC
	--assert mcl2-mp-int/mp-digit/value = #"^(01)"
		response: LTM-clear mcl2-mp-int
	--assert response = LTM-OKAY
	
	--test-- "mcl3"
		mcl3-mp-int: declare LTM-int!
		response: LTM-init mcl3-mp-int
	--assert response = LTM-OKAY
		mcl3-mp-int/used: 1
		mcl3-mp-int/sign: LTM-ZPOS
		mcl3-mp-int/mp-digit/value: #"^(0F)"
		response: LTM-clamp mcl3-mp-int
	--assert response = LTM-OKAY
	--assert mcl3-mp-int/used = 1
	--assert mcl3-mp-int/sign = LTM-ZPOS
	--assert mcl3-mp-int/alloc = LTM-PREC
	--assert mcl3-mp-int/mp-digit/value = #"^(0F)"
		response: LTM-clear mcl3-mp-int
	--assert response = LTM-OKAY

===end-group===

===start-group=== "mp-copy"

	--test-- "mcpy1"
		mcpy1-mp-int1: declare LTM-int!
		response: LTM-init mcpy1-mp-int1
	--assert response = LTM-OKAY
		mcpy1-mp-int1/used: 1
		mcpy1-mp-int1/mp-digit/value: #"^(11)"
		response: LTM-copy mcpy1-mp-int1 mcpy1-mp-int1
	--assert response = LTM-OKAY
	--assert mcpy1-mp-int1/used = 1
	--assert mcpy1-mp-int1/sign = LTM-ZPOS
	--assert mcpy1-mp-int1/alloc = LTM-PREC
	--assert mcpy1-mp-int1/mp-digit/value = #"^(11)"
	
	--test-- "mcpy2"
		mcpy2-mp-int1: declare LTM-int!
		response: LTM-init mcpy2-mp-int1
	--assert response = LTM-OKAY
		mcpy2-mp-int1/used: LTM-PREC + 1
		mcpy2-mp-int1/mp-digit/value: #"^(21)"
		response: LTM-grow mcpy2-mp-int1 LTM-PREC + 1
	--assert response = LTM-OKAY
		mcpy2-mp-int2: declare LTM-int!
		response: LTM-init mcpy2-mp-int2
	--assert response = LTM-OKAY
		response: LTM-copy mcpy2-mp-int1 mcpy2-mp-int2
	--assert response = LTM-OKAY	
	--assert mcpy2-mp-int2/used = 33				;; mp-copy doesn't clamp
	--assert mcpy2-mp-int2/sign = LTM-ZPOS
	--assert mcpy2-mp-int2/alloc = (3 * LTM-PREC)
	--assert mcpy2-mp-int2/mp-digit/value = #"^(21)"
	
===end-group===

===start-group=== "mp-copy-init"

	--test-- "mcpyi1"
		mcpyi1-mp-int1: declare LTM-int!
		response: LTM-init mcpyi1-mp-int1
	--assert response = LTM-OKAY
		mcpyi1-mp-int1/used: 1
		mcpyi1-mp-int1/mp-digit/value: #"^(11)"
		mcpi1-mp-int2: declare LTM-int!
		mcpyi1-mp-int1/sign: LTM-NEG
		mcpyi1-mp-int2: declare LTM-int!
		response: LTM-copy-init mcpyi1-mp-int2 mcpyi1-mp-int1
	--assert response = LTM-OKAY
	--assert mcpyi1-mp-int2/used = 1
	--assert mcpyi1-mp-int2/sign = LTM-NEG
	--assert mcpyi1-mp-int2/alloc = LTM-PREC
	--assert mcpyi1-mp-int2/mp-digit/value = #"^(11)"
		
	--test-- "mcpyi2"
		mcpyi2-mp-int1: declare LTM-int!
		response: LTM-init mcpyi2-mp-int1
	--assert response = LTM-OKAY
		mcpyi2-mp-int1/used: LTM-PREC + 1
		mcpyi2-mp-int1/mp-digit/value: #"^(21)"
			response: LTM-grow mcpyi2-mp-int1 LTM-PREC + 1
	--assert response = LTM-OKAY
		mcpyi2-mp-int2: declare LTM-int!
		response: LTM-copy-init mcpyi2-mp-int2 mcpyi2-mp-int1
	--assert response = LTM-OKAY	
	--assert mcpyi2-mp-int2/used = 33				;; mp-copy doesn't clamp
	--assert mcpyi2-mp-int2/sign = LTM-ZPOS
	--assert mcpyi2-mp-int2/alloc = (3 * LTM-PREC)
	--assert mcpyi2-mp-int2/mp-digit/value = #"^(21)"

===end-group===

===start-group=== "mp-zero"

	--test-- "mz1"
		mz1-mp-int1: declare LTM-int!
		response: LTM-init mz1-mp-int1
	--assert response = LTM-OKAY
		mz1-mp-int1/mp-digit/value: #"^(21)"
		mz1-mp-int1/sign: LTM-NEG
		response: LTM-zero mz1-mp-int1
	--assert response = LTM-OKAY
	--assert mz1-mp-int1/used = 0	
	--assert mz1-mp-int1/sign = LTM-ZPOS
	--assert mz1-mp-int1/alloc = LTM-PREC
	--assert mz1-mp-int1/mp-digit/value = #"^(00)"
	
===end-group===

===start-group=== "mp-abs"

	--test-- "ma1"
		ma1-mp-int1: declare LTM-int!
		response: LTM-init ma1-mp-int1
	--assert response = LTM-OKAY
		ma1-mp-int1/mp-digit/value: #"^(21)"
		ma1-mp-int1/sign: LTM-NEG
		ma1-mp-int1/used: 1
		ma1-mp-int2: declare LTM-int!
		response: LTM-init ma1-mp-int2
	--assert response = LTM-OKAY
		response: LTM-abs ma1-mp-int1 ma1-mp-int2
	--assert response = LTM-OKAY
	--assert ma1-mp-int1/used = 1	
	--assert ma1-mp-int1/sign = LTM-NEG
	--assert ma1-mp-int1/alloc = LTM-PREC
	--assert ma1-mp-int1/mp-digit/value = #"^(021)"
	--assert ma1-mp-int2/used = 1
	--assert ma1-mp-int2/sign = LTM-ZPOS
	--assert ma1-mp-int2/alloc = LTM-PREC
	--assert ma1-mp-int2/mp-digit/value = #"^(021)"
	
	--test-- "ma2"
		ma2-mp-int1: declare LTM-int!
		response: LTM-init ma2-mp-int1
	--assert response = LTM-OKAY
		ma2-mp-int1/mp-digit/value: #"^(21)"
		ma2-mp-int1/sign: LTM-ZPOS
		ma2-mp-int1/used: 1
		ma2-mp-int2: declare LTM-int!
		response: LTM-init ma2-mp-int2
	--assert response = LTM-OKAY
		response: LTM-abs ma2-mp-int1 ma2-mp-int2
	--assert response = LTM-OKAY
	--assert ma2-mp-int2/used = 1	
	--assert ma2-mp-int2/sign = LTM-ZPOS
	--assert ma2-mp-int2/alloc = LTM-PREC
	--assert ma2-mp-int2/mp-digit/value = #"^(021)"

===end-group===

===start-group=== "mp-neg"

	--test-- "mn1"
		mn1-mp-int1: declare LTM-int!
		response: LTM-init mn1-mp-int1
	--assert response = LTM-OKAY
		mn1-mp-int1/mp-digit/value: #"^(21)"
		mn1-mp-int1/sign: LTM-NEG
		mn1-mp-int1/used: 1
		mn1-mp-int2: declare LTM-int!
		response: LTM-init mn1-mp-int2
	--assert response = LTM-OKAY
		response: LTM-negate mn1-mp-int1 mn1-mp-int2
	--assert response = LTM-OKAY
	--assert mn1-mp-int1/used = 1	
	--assert mn1-mp-int1/sign = LTM-NEG
	--assert mn1-mp-int1/alloc = LTM-PREC
	--assert mn1-mp-int1/mp-digit/value = #"^(021)"
	--assert mn1-mp-int2/used = 1
	--assert mn1-mp-int2/sign = LTM-ZPOS
	--assert mn1-mp-int2/alloc = LTM-PREC
	--assert mn1-mp-int2/mp-digit/value = #"^(021)"
	
	--test-- "mn2"
		mn2-mp-int1: declare LTM-int!
		response: LTM-init mn2-mp-int1
	--assert response = LTM-OKAY
		mn2-mp-int1/mp-digit/value: #"^(21)"
		mn2-mp-int1/sign: LTM-ZPOS
		mn2-mp-int1/used: 1
		mn2-mp-int2: declare LTM-int!
		response: LTM-init mn2-mp-int2
	--assert response = LTM-OKAY
		response: LTM-negate mn2-mp-int1 mn2-mp-int2
	--assert response = LTM-OKAY
	--assert mn2-mp-int2/used = 1	
	--assert mn2-mp-int2/sign = LTM-NEG
	--assert mn2-mp-int2/alloc = LTM-PREC
	--assert mn2-mp-int2/mp-digit/value = #"^(021)"
	
	--test-- "mn3"
		mn3-mp-int1: declare LTM-int!
		response: LTM-init mn3-mp-int1
	--assert response = LTM-OKAY
		response: LTM-negate mn3-mp-int1 mn3-mp-int1
	--assert response = LTM-OKAY
	--assert mn3-mp-int1/sign = LTM-ZPOS
	--assert mn3-mp-int1/used = 0

===end-group===

===start-group=== "mp-set"
	
	--test-- "mpset1"
		mpset1-mp-int: declare LTM-int!
		response: LTM-init mpset1-mp-int
	--assert response = LTM-OKAY
		response: LTM-set mpset1-mp-int as LTM-digit! 1
	--assert response = LTM-OKAY
	--assert mpset1-mp-int/used = 1
	--assert mpset1-mp-int/mp-digit/value = as LTM-digit! 1
	
	--test-- "mpset2"
		mpset2-mp-int: declare LTM-int!
		response: LTM-init mpset2-mp-int
	--assert response = LTM-OKAY
		response: LTM-set mpset2-mp-int as LTM-digit! 127
	--assert response = LTM-OKAY
	--assert mpset2-mp-int/used = 1
	--assert mpset2-mp-int/mp-digit/value = as LTM-digit! 127
		
===end-group===

===start-group=== "compare magnitude"

	--test-- "mp-cmp-mag1"
		mp-cmp-mag1-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag1-mp-int1
	--assert response = LTM-OKAY
		mp-cmp-mag1-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag1-mp-int2
	--assert response = LTM-OKAY
		response: LTM-cmp-mag mp-cmp-mag1-mp-int1 mp-cmp-mag1-mp-int2
	--assert response = LTM-EQ
	
	--test-- "mp-cmp-mag2"
		mp-cmp-mag2-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag2-mp-int1
		mp-cmp-mag2-mp-int1/used: 1
		mp-cmp-mag2-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp-mag2-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag2-mp-int2
	--assert response = LTM-OKAY
		response: LTM-cmp-mag mp-cmp-mag2-mp-int1 mp-cmp-mag2-mp-int2
	--assert response = LTM-GT
	
	--test-- "mp-cmp-mag3"
		mp-cmp-mag3-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag3-mp-int1
		mp-cmp-mag3-mp-int1/used: 1
		mp-cmp-mag3-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp-mag3-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag3-mp-int2
		mp-cmp-mag3-mp-int2/used: 2
		mp-cmp-mag3-bp: mp-cmp-mag3-mp-int2/mp-digit
		mp-cmp-mag3-bp: mp-cmp-mag3-bp + 1
		mp-cmp-mag3-bp/value: #"^(7F)"
	--assert response = LTM-OKAY
		response: LTM-cmp-mag mp-cmp-mag3-mp-int1 mp-cmp-mag3-mp-int2
	--assert response = LTM-LT
	
	--test-- "mp-cmp-mag4"
		mp-cmp-mag4-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag4-mp-int1
		mp-cmp-mag4-mp-int1/used: 1
		mp-cmp-mag4-mp-int1/mp-digit/value: #"^(7F)"
	--assert response = LTM-OKAY
		mp-cmp-mag4-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag4-mp-int2
	--assert response = LTM-OKAY
		mp-cmp-mag4-mp-int2/used: 1
		mp-cmp-mag4-mp-int2/mp-digit/value: #"^(7F)"
		response: LTM-cmp-mag mp-cmp-mag4-mp-int1 mp-cmp-mag4-mp-int2
	--assert response = LTM-EQ
	
	--test-- "mp-cmp-mag5"
		mp-cmp-mag5-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int1
		mp-cmp-mag5-mp-int1/used: 1
		mp-cmp-mag5-mp-int1/mp-digit/value: #"^(7F)"
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int2
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2/used: 1
		mp-cmp-mag5-mp-int2/mp-digit/value: #"^(7E)"
		response: LTM-cmp-mag mp-cmp-mag5-mp-int1 mp-cmp-mag5-mp-int2
	--assert response = LTM-GT
	
	--test-- "mp-cmp-mag5"
		mp-cmp-mag5-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int1
		mp-cmp-mag5-mp-int1/used: 1
		mp-cmp-mag5-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int2
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2/used: 1
		mp-cmp-mag5-mp-int2/mp-digit/value: #"^(02)"
		response: LTM-cmp-mag mp-cmp-mag5-mp-int1 mp-cmp-mag5-mp-int2
	--assert response = LTM-LT
	
	--test-- "mp-cmp-mag6"
		mp-cmp-mag6-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag6-int1
	--assert response = LTM-OKAY
		mp-cmp-mag6-int1/mp-digit/value: as LTM-digit! 1
		mp-cmp-mag6-int1/used: 1
		mp-cmp-mag6-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag6-int2
	--assert response = LTM-OKAY
		mp-cmp-mag6-int2/used: 2
		mp-cmp-mag6-bp: mp-cmp-mag6-int2/mp-digit
		mp-cmp-mag6-bp/value: as LTM-digit! 1
		mp-cmp-mag6-bp: mp-cmp-mag6-bp + 1
		mp-cmp-mag6-bp/value: as LTM-digit! 2
		response: LTM-cmp-mag mp-cmp-mag6-int1 mp-cmp-mag6-int2
	--assert response = LTM-LT
	
===end-group===

===start-group=== "compare"

	--test-- "mp-cmp1"
		mp-cmp1-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp1-mp-int1
	--assert response = LTM-OKAY
		mp-cmp1-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp1-mp-int2
	--assert response = LTM-OKAY
		response: LTM-cmp mp-cmp1-mp-int1 mp-cmp1-mp-int2
	--assert response = LTM-EQ
	
	--test-- "mp-cmp2"
		mp-cmp2-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp2-mp-int1
		mp-cmp2-mp-int1/used: 1
		mp-cmp2-mp-int1/mp-digit/value: #"^(01)"
		mp-cmp2-mp-int1/sign: LTM-NEG
	--assert response = LTM-OKAY
		mp-cmp2-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp2-mp-int2
	--assert response = LTM-OKAY
		response: LTM-cmp mp-cmp2-mp-int1 mp-cmp2-mp-int2
	--assert response = LTM-LT
	
	--test-- "mp-cmp3"
		mp-cmp3-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp3-mp-int1
		mp-cmp3-mp-int1/used: 1
		mp-cmp3-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp3-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp3-mp-int2
		mp-cmp3-mp-int2/sign: LTM-NEG
		mp-cmp3-mp-int2/used: 2
		mp-cmp3-bp: mp-cmp3-mp-int2/mp-digit
		mp-cmp3-bp: mp-cmp3-bp + 1
		mp-cmp3-bp/value: #"^(7F)"
	--assert response = LTM-OKAY
		response: LTM-cmp mp-cmp3-mp-int1 mp-cmp3-mp-int2
	--assert response = LTM-GT
	
	--test-- "mp-cmp4"
		mp-cmp4-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp4-mp-int1
		mp-cmp4-mp-int1/used: 1
		mp-cmp4-mp-int1/sign: LTM-NEG
		mp-cmp4-mp-int1/mp-digit/value: #"^(7F)"
	--assert response = LTM-OKAY
		mp-cmp4-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp4-mp-int2
	--assert response = LTM-OKAY
		mp-cmp4-mp-int2/used: 1
		mp-cmp4-mp-int2/sign: LTM-NEG
		mp-cmp4-mp-int2/mp-digit/value: #"^(7F)"
		response: LTM-cmp mp-cmp4-mp-int1 mp-cmp4-mp-int2
	--assert response = LTM-EQ
	
	--test-- "mp-cmp5"
		mp-cmp5-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp5-mp-int1
		mp-cmp5-mp-int1/used: 1
		mp-cmp5-mp-int1/mp-digit/value: #"^(7F)"
	--assert response = LTM-OKAY
		mp-cmp5-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp5-mp-int2
	--assert response = LTM-OKAY
		mp-cmp5-mp-int2/used: 1
		mp-cmp5-mp-int2/mp-digit/value: #"^(7E)"
		response: LTM-cmp mp-cmp5-mp-int1 mp-cmp5-mp-int2
	--assert response = LTM-GT
	
	--test-- "mp-cmp5"
		mp-cmp5-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp5-mp-int1
	--assert response = LTM-OKAY
		mp-cmp5-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp5-mp-int2
	--assert response = LTM-OKAY
		mp-cmp5-mp-int2/used: 1
		mp-cmp5-mp-int2/sign: LTM-NEG
		mp-cmp5-mp-int2/mp-digit/value: #"^(01)"
		response: LTM-cmp mp-cmp5-mp-int1 mp-cmp5-mp-int2
	--assert response = LTM-GT
	
===end-group===


===start-group=== "s-add"						;; low level subtraction

	--test-- "mp-s-add1"
		mp-s-add1-int1: declare LTM-int!
		response: LTM-init mp-s-add1-int1
	--assert response = LTM-OKAY
		mp-s-add1-int1/mp-digit/value: as LTM-digit! 1
		mp-s-add1-int1/used: 1
		mp-s-add1-int2: declare LTM-int!
		response: LTM-init mp-s-add1-int2
	--assert response = LTM-OKAY
		mp-s-add1-int3: declare LTM-int!
		response: LTM-init mp-s-add1-int3
	--assert response = LTM-OKAY
		response: LTM-s-add mp-s-add1-int1 mp-s-add1-int2 mp-s-add1-int3
	--assert response = LTM-OKAY
	--assert mp-s-add1-int3/used = 1
	--assert mp-s-add1-int3/mp-digit/value = as LTM-digit! 1
		
	--test-- "mp-s-add2"
		mp-s-add2-int1: declare LTM-int!
		response: LTM-init mp-s-add2-int1
	--assert response = LTM-OKAY
		mp-s-add2-int1/mp-digit/value: as LTM-digit! 1
		mp-s-add2-int1/used: 1
		mp-s-add2-int2: declare LTM-int!
		response: LTM-init mp-s-add2-int2
	--assert response = LTM-OKAY
		mp-s-add2-int2/used: 2
		mp-s-add2-bp: mp-s-add2-int2/mp-digit
		mp-s-add2-bp/value: as LTM-digit! 1
		mp-s-add2-bp: mp-s-add2-bp + 1
		mp-s-add2-bp/value: as LTM-digit! 2
		mp-s-add2-int3: declare LTM-int!
		response: LTM-init mp-s-add2-int3
	--assert response = LTM-OKAY
		response: LTM-s-add mp-s-add2-int2 mp-s-add2-int1 mp-s-add2-int3
	--assert response = LTM-OKAY
	--assert mp-s-add2-int3/used = 2
		mp-s-add2-bp: mp-s-add2-int3/mp-digit
	--assert mp-s-add2-bp/value = as LTM-digit! 2
		mp-s-add2-bp: mp-s-add2-bp + 1
	--assert mp-s-add2-bp/value = as LTM-digit! 2
		
	--test-- "mp-s-add3"
		mp-s-add3-int1: declare LTM-int!
		response: LTM-init mp-s-add3-int1
	--assert response = LTM-OKAY
		mp-s-add3-int1/mp-digit/value: as LTM-digit! 1
		mp-s-add3-int1/used: 1
		mp-s-add3-int2: declare LTM-int!
		response: LTM-init mp-s-add3-int2
	--assert response = LTM-OKAY
		mp-s-add3-int2/used: 2
		mp-s-add3-bp: mp-s-add3-int2/mp-digit
		mp-s-add3-bp/value: as LTM-digit! 127
		mp-s-add3-bp: mp-s-add3-bp + 1
		mp-s-add3-bp/value: as LTM-digit! 2
		mp-s-add3-int3: declare LTM-int!
		response: LTM-init mp-s-add3-int3
	--assert response = LTM-OKAY
		response: LTM-s-add mp-s-add3-int2 mp-s-add3-int1 mp-s-add3-int3
	--assert response = LTM-OKAY
	--assert mp-s-add3-int3/used = 2
		mp-s-add3-bp: mp-s-add3-int3/mp-digit
	--assert mp-s-add3-bp/value = as LTM-digit! 0
		mp-s-add3-bp: mp-s-add3-bp + 1
	--assert mp-s-add3-bp/value = as LTM-digit! 3
	
	--test-- "mp-s-add4"
		mp-s-add3-int1: declare LTM-int!
		response: LTM-init mp-s-add3-int1
	--assert response = LTM-OKAY
		mp-s-add3-int1/mp-digit/value: as LTM-digit! 1
		mp-s-add3-int1/used: 1
		mp-s-add3-int2: declare LTM-int!
		response: LTM-init mp-s-add3-int2
	--assert response = LTM-OKAY
		mp-s-add3-int2/used: 1
		mp-s-add3-int2/mp-digit/value: as LTM-digit! 1
		mp-s-add3-int3: declare LTM-int!
		response: LTM-init mp-s-add3-int3
	--assert response = LTM-OKAY
		mp-s-add3-int2/used: 2
		mp-s-add3-bp: mp-s-add3-int3/mp-digit
		mp-s-add3-bp/value: as LTM-digit! 1
		mp-s-add3-bp: mp-s-add3-bp + 1
		mp-s-add3-bp/value: as LTM-digit! 2	
	--assert response = LTM-OKAY
		response: LTM-s-add mp-s-add3-int2 mp-s-add3-int1 mp-s-add3-int3
	--assert response = LTM-OKAY
	--assert mp-s-add3-int3/used = 1
	--assert mp-s-add3-int3/mp-digit/value = as LTM-digit! 2
			
===end-group===

===start-group=== "s-sub"						;; low level subtraction

	--test-- "mp-s-sub1"
		mp-s-sub1-int1: declare LTM-int!
		response: LTM-init mp-s-sub1-int1
	--assert response = LTM-OKAY
		mp-s-sub1-int1/mp-digit/value: as LTM-digit! 1
		mp-s-sub1-int1/used: 1
		mp-s-sub1-int2: declare LTM-int!
		response: LTM-init mp-s-sub1-int2
	--assert response = LTM-OKAY
		mp-s-sub1-int3: declare LTM-int!
		response: LTM-init mp-s-sub1-int3
	--assert response = LTM-OKAY
		response: LTM-s-sub mp-s-sub1-int1 mp-s-sub1-int2 mp-s-sub1-int3
	--assert response = LTM-OKAY
	--assert mp-s-sub1-int3/used = 1
	--assert mp-s-sub1-int3/mp-digit/value = as LTM-digit! 1
		
	--test-- "mp-s-sub2"
		mp-s-sub2-int1: declare LTM-int!
		response: LTM-init mp-s-sub2-int1
	--assert response = LTM-OKAY
		mp-s-sub2-int1/mp-digit/value: as LTM-digit! 1
		mp-s-sub2-int1/used: 1
		mp-s-sub2-int2: declare LTM-int!
		response: LTM-init mp-s-sub2-int2
	--assert response = LTM-OKAY
		mp-s-sub2-int2/used: 2
		mp-s-sub2-bp: mp-s-sub2-int2/mp-digit
		mp-s-sub2-bp/value: as LTM-digit! 1
		mp-s-sub2-bp: mp-s-sub2-bp + 1
		mp-s-sub2-bp/value: as LTM-digit! 2
		mp-s-sub2-int3: declare LTM-int!
		response: LTM-init mp-s-sub2-int3
	--assert response = LTM-OKAY
		response: LTM-s-sub mp-s-sub2-int2 mp-s-sub2-int1 mp-s-sub2-int3
	--assert response = LTM-OKAY
	--assert mp-s-sub2-int3/used = 2
		mp-s-sub2-bp: mp-s-sub2-int3/mp-digit
	--assert mp-s-sub2-bp/value = as LTM-digit! 0
		mp-s-sub2-bp: mp-s-sub2-bp + 1
	--assert mp-s-sub2-bp/value = as LTM-digit! 2
		
	--test-- "mp-s-sub3"
		mp-s-sub3-int1: declare LTM-int!
		response: LTM-init mp-s-sub3-int1
	--assert response = LTM-OKAY
		mp-s-sub3-int1/mp-digit/value: as LTM-digit! 1
		mp-s-sub3-int1/used: 1
		mp-s-sub3-int2: declare LTM-int!
		response: LTM-init mp-s-sub3-int2
	--assert response = LTM-OKAY
		mp-s-sub3-int2/used: 2
		mp-s-sub3-bp: mp-s-sub3-int2/mp-digit
		mp-s-sub3-bp/value: as LTM-digit! 127
		mp-s-sub3-bp: mp-s-sub3-bp + 1
		mp-s-sub3-bp/value: as LTM-digit! 2
		mp-s-sub3-int3: declare LTM-int!
		response: LTM-init mp-s-sub3-int3
	--assert response = LTM-OKAY
		response: LTM-s-sub mp-s-sub3-int2 mp-s-sub3-int1 mp-s-sub3-int3
	--assert response = LTM-OKAY
	--assert mp-s-sub3-int3/used = 2
		mp-s-sub3-bp: mp-s-sub3-int3/mp-digit
	--assert mp-s-sub3-bp/value = as LTM-digit! 126
		mp-s-sub3-bp: mp-s-sub3-bp + 1
	--assert mp-s-sub3-bp/value = as LTM-digit! 2
	
	--test-- "mp-s-sub4"
		mp-s-sub4-int1: declare LTM-int!
		response: LTM-init mp-s-sub4-int1
	--assert response = LTM-OKAY
		mp-s-sub4-int1/mp-digit/value: as LTM-digit! 1
		mp-s-sub4-int1/used: 1
		mp-s-sub4-int2: declare LTM-int!
		response: LTM-init mp-s-sub4-int2
	--assert response = LTM-OKAY
		mp-s-sub4-int2/used: 1
		mp-s-sub4-int2/mp-digit/value: as LTM-digit! 2
		mp-s-sub4-int3: declare LTM-int!
		response: LTM-init mp-s-sub4-int3
	--assert response = LTM-OKAY
		mp-s-sub4-int3/used: 2
		mp-s-sub4-bp: mp-s-sub4-int3/mp-digit
		mp-s-sub4-bp/value: as LTM-digit! 1
		mp-s-sub4-bp: mp-s-sub4-bp + 1
		mp-s-sub4-bp/value: as LTM-digit! 2	
	--assert response = LTM-OKAY
		response: LTM-s-sub mp-s-sub4-int2 mp-s-sub4-int1 mp-s-sub4-int3
	--assert response = LTM-OKAY
	--assert mp-s-sub4-int3/used = 1
	--assert mp-s-sub4-int3/mp-digit/value = as LTM-digit! 1
	
	--test-- "mp-s-sub5"
		mp-s-sub5-int1: declare LTM-int!
		response: LTM-init mp-s-sub5-int1
	--assert response = LTM-OKAY
		mp-s-sub5-int1/mp-digit/value: as LTM-digit! 127
		mp-s-sub5-int1/used: 1
		mp-s-sub5-int2: declare LTM-int!
		response: LTM-init mp-s-sub5-int2
	--assert response = LTM-OKAY
		mp-s-sub5-int2/used: 2
		mp-s-sub5-bp: mp-s-sub5-int2/mp-digit
		mp-s-sub5-bp/value: as LTM-digit! 0
		mp-s-sub5-bp: mp-s-sub5-bp + 1
		mp-s-sub5-bp/value: as LTM-digit! 2
		mp-s-sub5-int3: declare LTM-int!
		response: LTM-init mp-s-sub5-int3
	--assert response = LTM-OKAY
		response: LTM-s-sub mp-s-sub5-int2 mp-s-sub5-int1 mp-s-sub5-int3
	--assert response = LTM-OKAY
	--assert mp-s-sub5-int3/used = 2
		mp-s-sub5-bp: mp-s-sub5-int3/mp-digit
	--assert mp-s-sub5-bp/value = as LTM-digit! 1
		mp-s-sub5-bp: mp-s-sub5-bp + 1
	--assert mp-s-sub5-bp/value = as LTM-digit! 1
	
===end-group===

===start-group=== "add"						

	--test-- "mp-add1"
		mp-add1-int1: declare LTM-int!
		response: LTM-init mp-add1-int1
	--assert response = LTM-OKAY
		mp-add1-int1/mp-digit/value: as LTM-digit! 1
		mp-add1-int1/used: 1
		mp-add1-int2: declare LTM-int!
		response: LTM-init mp-add1-int2
	--assert response = LTM-OKAY
		mp-add1-int3: declare LTM-int!
		response: LTM-init mp-add1-int3
	--assert response = LTM-OKAY
		response: LTM-add mp-add1-int1 mp-add1-int2 mp-add1-int3
	--assert response = LTM-OKAY
	--assert mp-add1-int3/used = 1
	--assert mp-add1-int3/mp-digit/value = as LTM-digit! 1
		
	--test-- "mp-add2"
		mp-add2-int1: declare LTM-int!
		response: LTM-init mp-add2-int1
	--assert response = LTM-OKAY
		mp-add2-int1/mp-digit/value: as LTM-digit! 1
		mp-add2-int1/used: 1
		mp-add2-int2: declare LTM-int!
		response: LTM-init mp-add2-int2
	--assert response = LTM-OKAY
		mp-add2-int2/used: 2
		mp-add2-bp: mp-add2-int2/mp-digit
		mp-add2-bp/value: as LTM-digit! 1
		mp-add2-bp: mp-add2-bp + 1
		mp-add2-bp/value: as LTM-digit! 2
		mp-add2-int3: declare LTM-int!
		response: LTM-init mp-add2-int3
	--assert response = LTM-OKAY
		response: LTM-add mp-add2-int2 mp-add2-int1 mp-add2-int3
	--assert response = LTM-OKAY
	--assert mp-add2-int3/used = 2
		mp-add2-bp: mp-add2-int3/mp-digit
	--assert mp-add2-bp/value = as LTM-digit! 2
		mp-add2-bp: mp-add2-bp + 1
	--assert mp-add2-bp/value = as LTM-digit! 2
		
	--test-- "mp-add3"
		mp-add3-int1: declare LTM-int!
		response: LTM-init mp-add3-int1
	--assert response = LTM-OKAY
		mp-add3-int1/mp-digit/value: as LTM-digit! 1
		mp-add3-int1/used: 1
		mp-add3-int2: declare LTM-int!
		response: LTM-init mp-add3-int2
	--assert response = LTM-OKAY
		mp-add3-int2/used: 2
		mp-add3-bp: mp-add3-int2/mp-digit
		mp-add3-bp/value: as LTM-digit! 127
		mp-add3-bp: mp-add3-bp + 1
		mp-add3-bp/value: as LTM-digit! 2
		mp-add3-int3: declare LTM-int!
		response: LTM-init mp-add3-int3
	--assert response = LTM-OKAY
		response: LTM-add mp-add3-int2 mp-add3-int1 mp-add3-int3
	--assert response = LTM-OKAY
	--assert mp-add3-int3/used = 2
		mp-add3-bp: mp-add3-int3/mp-digit
	--assert mp-add3-bp/value = as LTM-digit! 0
		mp-add3-bp: mp-add3-bp + 1
	--assert mp-add3-bp/value = as LTM-digit! 3
	
	--test-- "mp-add4"
		mp-add4-int1: declare LTM-int!
		response: LTM-init mp-add4-int1
	--assert response = LTM-OKAY
		mp-add4-int1/mp-digit/value: as LTM-digit! 1
		mp-add4-int1/used: 1
		mp-add4-int2: declare LTM-int!
		response: LTM-init mp-add4-int2
	--assert response = LTM-OKAY
		mp-add4-int2/used: 1
		mp-add4-int2/mp-digit/value: as LTM-digit! 1
		mp-add4-int3: declare LTM-int!
		response: LTM-init mp-add4-int3
	--assert response = LTM-OKAY
		mp-add4-int2/used: 2
		mp-add4-bp: mp-add4-int3/mp-digit
		mp-add4-bp/value: as LTM-digit! 1
		mp-add4-bp: mp-add4-bp + 1
		mp-add4-bp/value: as LTM-digit! 2	
	--assert response = LTM-OKAY
		response: LTM-add mp-add4-int2 mp-add4-int1 mp-add4-int3
	--assert response = LTM-OKAY
	--assert mp-add4-int3/used = 1
	--assert mp-add4-int3/mp-digit/value = as LTM-digit! 2
	
	--test-- "mp-add5"
		mp-add5-int1: declare LTM-int!
		response: LTM-init mp-add5-int1
	--assert response = LTM-OKAY
		mp-add5-int1/mp-digit/value: as LTM-digit! 1
		mp-add5-int1/used: 1
		mp-add5-int1/sign: LTM-NEG
		mp-add5-int2: declare LTM-int!
		response: LTM-init mp-add5-int2
	--assert response = LTM-OKAY
		mp-add5-int2/used: 1
		mp-add5-int2/mp-digit/value: as LTM-digit! 1
		mp-add5-int3: declare LTM-int!
		response: LTM-init mp-add5-int3
	--assert response = LTM-OKAY
		mp-add5-int2/used: 2
		mp-add5-bp: mp-add5-int3/mp-digit
		mp-add5-bp/value: as LTM-digit! 1
		mp-add5-bp: mp-add5-bp + 1
		mp-add5-bp/value: as LTM-digit! 2	
	--assert response = LTM-OKAY
		response: LTM-add mp-add5-int2 mp-add5-int1 mp-add5-int3
	--assert response = LTM-OKAY
	--assert mp-add5-int3/used = 0
	--assert mp-add5-int3/mp-digit/value = as LTM-digit! 0
	--assert mp-add5-int3/sign = LTM-ZPOS
						
	--test-- "mp-add6"
		mp-add6-int1: declare LTM-int!
		response: LTM-init mp-add6-int1
	--assert response = LTM-OKAY
		mp-add6-int1/mp-digit/value: as LTM-digit! 1
		mp-add6-int1/used: 1
		mp-add6-int1/sign: LTM-NEG
		mp-add6-int2: declare LTM-int!
		response: LTM-init mp-add6-int2
	--assert response = LTM-OKAY
		mp-add6-int2/used: 1
		mp-add6-int2/mp-digit/value: as LTM-digit! 1
		mp-add6-int2/sign: LTM-NEG
		mp-add6-int2/used: 2
		mp-add6-bp: mp-add6-int2/mp-digit
		mp-add6-bp/value: as LTM-digit! 1
		mp-add6-bp: mp-add6-bp + 1
		mp-add6-bp/value: as LTM-digit! 2
		mp-add6-int3: declare LTM-int!
		response: LTM-init mp-add6-int3
	--assert response = LTM-OKAY
		response: LTM-add mp-add6-int2 mp-add6-int1 mp-add6-int3
	--assert response = LTM-OKAY
	--assert mp-add6-int3/used = 2
	--assert mp-add6-int3/mp-digit/value = as LTM-digit! 2
	--assert mp-add6-int3/sign = LTM-NEG
		mp-add6-bp: mp-add6-int3/mp-digit
	--assert mp-add6-bp/value = as LTM-digit! 2
		mp-add6-bp: mp-add6-bp + 1
	--assert mp-add2-bp/value = as LTM-digit! 2
	
===end-group===

===start-group=== "sub"						

	--test-- "mp-sub1"
		mp-sub1-int1: declare LTM-int!
		response: LTM-init mp-sub1-int1
	--assert response = LTM-OKAY
		mp-sub1-int1/mp-digit/value: as LTM-digit! 1
		mp-sub1-int1/used: 1
		mp-sub1-int2: declare LTM-int!
		response: LTM-init mp-sub1-int2
	--assert response = LTM-OKAY
		mp-sub1-int3: declare LTM-int!
		response: LTM-init mp-sub1-int3
	--assert response = LTM-OKAY
		response: LTM-sub mp-sub1-int1 mp-sub1-int2 mp-sub1-int3
	--assert response = LTM-OKAY
	--assert mp-sub1-int3/used = 1
	--assert mp-sub1-int3/mp-digit/value = as LTM-digit! 1
		
	--test-- "mp-sub2"
		mp-sub2-int1: declare LTM-int!
		response: LTM-init mp-sub2-int1
	--assert response = LTM-OKAY
		mp-sub2-int1/mp-digit/value: as LTM-digit! 1
		mp-sub2-int1/used: 1
		mp-sub2-int2: declare LTM-int!
		response: LTM-init mp-sub2-int2
	--assert response = LTM-OKAY
		mp-sub2-int2/used: 2
		mp-sub2-bp: mp-sub2-int2/mp-digit
		mp-sub2-bp/value: as LTM-digit! 1
		mp-sub2-bp: mp-sub2-bp + 1
		mp-sub2-bp/value: as LTM-digit! 2
		mp-sub2-int3: declare LTM-int!
		response: LTM-init mp-sub2-int3
	--assert response = LTM-OKAY
		response: LTM-sub mp-sub2-int1 mp-sub2-int2 mp-sub2-int3
	--assert response = LTM-OKAY
	--assert mp-sub2-int3/used = 2
	--assert mp-sub2-int3/sign = LTM-NEG
		mp-sub2-bp: mp-sub2-int3/mp-digit
	--assert mp-sub2-bp/value = as LTM-digit! 0
		mp-sub2-bp: mp-sub2-bp + 1
	--assert mp-sub2-bp/value = as LTM-digit! 2
		
	--test-- "mp-sub3"
		mp-sub3-int1: declare LTM-int!
		response: LTM-init mp-sub3-int1
	--assert response = LTM-OKAY
		mp-sub3-int1/mp-digit/value: as LTM-digit! 1
		mp-sub3-int1/used: 1
		mp-sub3-int2: declare LTM-int!
		response: LTM-init mp-sub3-int2
	--assert response = LTM-OKAY
		mp-sub3-int2/used: 2
		mp-sub3-bp: mp-sub3-int2/mp-digit
		mp-sub3-bp/value: as LTM-digit! 127
		mp-sub3-bp: mp-sub3-bp + 1
		mp-sub3-bp/value: as LTM-digit! 2
		mp-sub3-int3: declare LTM-int!
		response: LTM-init mp-sub3-int3
	--assert response = LTM-OKAY
		response: LTM-sub mp-sub3-int1 mp-sub3-int2 mp-sub3-int3
	--assert response = LTM-OKAY
	--assert mp-sub3-int3/used = 2
	--assert mp-sub3-int3/sign = LTM-NEG
		mp-sub3-bp: mp-sub3-int3/mp-digit
	--assert mp-sub3-bp/value = as LTM-digit! 126
		mp-sub3-bp: mp-sub3-bp + 1
	--assert mp-sub3-bp/value = as LTM-digit! 2
	
	--test-- "mp-sub4"
		mp-sub4-int1: declare LTM-int!
		response: LTM-init mp-sub4-int1
	--assert response = LTM-OKAY
		mp-sub4-int1/mp-digit/value: as LTM-digit! 1
		mp-sub4-int1/used: 1
		mp-sub4-int2: declare LTM-int!
		response: LTM-init mp-sub4-int2
	--assert response = LTM-OKAY
		mp-sub4-int2/used: 1
		mp-sub4-int2/mp-digit/value: as LTM-digit! 1
		mp-sub4-int3: declare LTM-int!
		response: LTM-init mp-sub4-int3
	--assert response = LTM-OKAY
		mp-sub4-int2/used: 2
		mp-sub4-bp: mp-sub4-int3/mp-digit
		mp-sub4-bp/value: as LTM-digit! 1
		mp-sub4-bp: mp-sub4-bp + 1
		mp-sub4-bp/value: as LTM-digit! 2	
	--assert response = LTM-OKAY
		response: LTM-sub mp-sub4-int1 mp-sub4-int2 mp-sub4-int3
	--assert response = LTM-OKAY
	--assert mp-sub4-int3/used = 0
	--assert mp-sub4-int3/mp-digit/value = as LTM-digit! 0
	--assert mp-sub4-int3/sign = LTM-ZPOS
	
	--test-- "mp-sub5"
		mp-sub5-int1: declare LTM-int!
		response: LTM-init mp-sub5-int1
	--assert response = LTM-OKAY
		mp-sub5-int1/mp-digit/value: as LTM-digit! 1
		mp-sub5-int1/used: 1
		mp-sub5-int1/sign: LTM-NEG
		mp-sub5-int2: declare LTM-int!
		response: LTM-init mp-sub5-int2
	--assert response = LTM-OKAY
		mp-sub5-int2/used: 1
		mp-sub5-int2/mp-digit/value: as LTM-digit! 1
		mp-sub5-int2/sign: LTM-NEG
		mp-sub5-int3: declare LTM-int!
		response: LTM-init mp-sub5-int3
	--assert response = LTM-OKAY
	--assert response = LTM-OKAY
		response: LTM-sub mp-sub5-int1 mp-sub5-int2 mp-sub5-int3
	--assert response = LTM-OKAY
	--assert mp-sub5-int3/used = 0
	--assert mp-sub5-int3/mp-digit/value = as LTM-digit! 0
	--assert mp-sub5-int3/sign = LTM-ZPOS
						
	--test-- "mp-sub6"
		mp-sub6-int1: declare LTM-int!
		response: LTM-init mp-sub6-int1
	--assert response = LTM-OKAY
		mp-sub6-int1/mp-digit/value: as LTM-digit! 1
		mp-sub6-int1/used: 1
		mp-sub6-int1/sign: LTM-NEG
		mp-sub6-int2: declare LTM-int!
		response: LTM-init mp-sub6-int2
	--assert response = LTM-OKAY
		mp-sub6-int2/used: 1
		mp-sub6-int2/mp-digit/value: as LTM-digit! 1
		mp-sub6-int2/sign: LTM-NEG
		mp-sub6-int2/used: 2
		mp-sub6-bp: mp-sub6-int2/mp-digit
		mp-sub6-bp/value: as LTM-digit! 1
		mp-sub6-bp: mp-sub6-bp + 1
		mp-sub6-bp/value: as LTM-digit! 2
		mp-sub6-int3: declare LTM-int!
		response: LTM-init mp-sub6-int3
	--assert response = LTM-OKAY
		response: LTM-sub mp-sub6-int1 mp-sub6-int2 mp-sub6-int3
	--assert response = LTM-OKAY
	--assert mp-sub6-int3/used = 2
	--assert mp-sub6-int3/sign = LTM-ZPOS
		mp-sub6-bp: mp-sub6-int3/mp-digit
	--assert mp-sub6-bp/value = as LTM-digit! 0
		mp-sub6-bp: mp-sub6-bp + 1
	--assert mp-sub2-bp/value = as LTM-digit! 2
	
===end-group===

===start-group=== "multiply by 2"						

	--test-- "mp-mul-2-1"
		mp-mul-2-1-int1: declare LTM-int!
		response: LTM-init mp-mul-2-1-int1
	--assert response = LTM-OKAY
		mp-mul-2-1-int2: declare LTM-int!
		response: LTM-init mp-mul-2-1-int2
	--assert response = LTM-OKAY
		response: LTM-mul-2 mp-mul-2-1-int1 mp-mul-2-1-int2
	--assert response = LTM-OKAY
	--assert mp-mul-2-1-int2/used = 0
	--assert mp-mul-2-1-int2/mp-digit/value = as LTM-digit! 0
		
	--test-- "mp-mul-2-2"
		mp-mul-2-2-int1: declare LTM-int!
		response: LTM-init mp-mul-2-2-int1
	--assert response = LTM-OKAY
		mp-mul-2-2-int1/mp-digit/value: as LTM-digit! 16
		mp-mul-2-2-int1/used: 1
		mp-mul-2-2-int2: declare LTM-int!
		response: LTM-init mp-mul-2-2-int2
	--assert response = LTM-OKAY
		response: LTM-mul-2 mp-mul-2-2-int1 mp-mul-2-2-int2 
	--assert response = LTM-OKAY
	--assert mp-mul-2-2-int2/used = 1
		mp-mul-2-2-bp: mp-mul-2-2-int2/mp-digit
	--assert mp-mul-2-2-bp/value = as LTM-digit! 32
		
	--test-- "mp-mul-2-3"
		mp-mul-2-3-int1: declare LTM-int!
		response: LTM-init mp-mul-2-3-int1
	--assert response = LTM-OKAY
		mp-mul-2-3-int1/mp-digit/value: as LTM-digit! 127
		mp-mul-2-3-int1/used: 1
		mp-mul-2-3-int2: declare LTM-int!
		response: LTM-init mp-mul-2-3-int2
	--assert response = LTM-OKAY
		response: LTM-mul-2 mp-mul-2-3-int1 mp-mul-2-3-int2
	--assert response = LTM-OKAY
	--assert mp-mul-2-3-int2/used = 2
		mp-mul-2-3-bp: mp-mul-2-3-int2/mp-digit
	--assert mp-mul-2-3-bp/value = as LTM-digit! 126
		mp-mul-2-3-bp: mp-mul-2-3-bp + 1
	--assert mp-mul-2-3-bp/value = as LTM-digit! 1
	
	--test-- "mp-mul-2-4"
		mp-mul-2-4-int1: declare LTM-int!
		response: LTM-init mp-mul-2-4-int1
	--assert response = LTM-OKAY
		mp-mul-2-4-int1/mp-digit/value: as LTM-digit! 1
		mp-mul-2-4-int1/used: 1
		mp-mul-2-4-int1/sign: LTM-NEG
		mp-mul-2-4-int2: declare LTM-int!
		response: LTM-init mp-mul-2-4-int2
	--assert response = LTM-OKAY
		response: LTM-mul-2 mp-mul-2-4-int1 mp-mul-2-4-int2 
	--assert response = LTM-OKAY
	--assert mp-mul-2-4-int2/used = 1
	--assert mp-mul-2-4-int2/mp-digit/value = as LTM-digit! 2
	--assert mp-mul-2-4-int2/sign = LTM-NEG
	
	--test-- "mp-mul-2-5"
		mp-mul-2-5-int1: declare LTM-int!
		response: LTM-init mp-mul-2-5-int1
		mp-mul-2-5-int1/used: 1
		mp-mul-2-5-int1/mp-digit/value: as LTM-digit! 31
	--assert response = LTM-OKAY
		mp-mul-2-5-int2: declare LTM-int!
		response: LTM-init mp-mul-2-5-int2
	--assert response = LTM-OKAY
		response: LTM-mul-2 mp-mul-2-5-int1 mp-mul-2-5-int2
	--assert response = LTM-OKAY
	--assert mp-mul-2-5-int2/used = 1
	--assert mp-mul-2-5-int2/mp-digit/value = as LTM-digit! 62
	--assert mp-mul-2-5-int2/sign = LTM-ZPOS
						
	--test-- "mp-mul-2-6"
		mp-mul-2-6-int1: declare LTM-int!
		response: LTM-init mp-mul-2-6-int1
	--assert response = LTM-OKAY
		mp-mul-2-6-int1/mp-digit/value: as LTM-digit! 127
		mp-mul-2-6-int1/used: 1
		mp-mul-2-6-int1/sign: LTM-NEG
		mp-mul-2-6-int2: declare LTM-int!
		response: LTM-init mp-mul-2-6-int2
	--assert response = LTM-OKAY
		response: LTM-mul-2 mp-mul-2-6-int1 mp-mul-2-6-int2
	--assert response = LTM-OKAY
	--assert mp-mul-2-6-int2/used = 2
	--assert mp-mul-2-6-int2/sign = LTM-NEG
		mp-mul-2-6-bp: mp-mul-2-6-int2/mp-digit
	--assert mp-mul-2-6-bp/value = as LTM-digit! 126
		mp-mul-2-6-bp: mp-mul-2-6-bp + 1
	--assert mp-mul-2-6-bp/value = as LTM-digit! 1
	
===end-group===

===start-group=== "divide by 2"						

	--test-- "mp-div-2-1"
		mp-div-2-1-int1: declare LTM-int!
		response: LTM-init mp-div-2-1-int1
	--assert response = LTM-OKAY
		mp-div-2-1-int2: declare LTM-int!
		response: LTM-init mp-div-2-1-int2
	--assert response = LTM-OKAY
		response: LTM-div-2 mp-div-2-1-int1 mp-div-2-1-int2
	--assert response = LTM-OKAY
	--assert mp-div-2-1-int2/used = 0
	--assert mp-div-2-1-int2/mp-digit/value = as LTM-digit! 0
		
	--test-- "mp-div-2-2"
		mp-div-2-2-int1: declare LTM-int!
		response: LTM-init mp-div-2-2-int1
	--assert response = LTM-OKAY
		mp-div-2-2-int1/mp-digit/value: as LTM-digit! 32
		mp-div-2-2-int1/used: 1
		mp-div-2-2-int2: declare LTM-int!
		response: LTM-init mp-div-2-2-int2
	--assert response = LTM-OKAY
		response: LTM-div-2 mp-div-2-2-int1 mp-div-2-2-int2 
	--assert response = LTM-OKAY
	--assert mp-div-2-2-int2/used = 1
		mp-div-2-2-bp: mp-div-2-2-int2/mp-digit
	--assert mp-div-2-2-bp/value = as LTM-digit! 16
		
	--test-- "mp-div-2-3"
		mp-div-2-3-int1: declare LTM-int!
		response: LTM-init mp-div-2-3-int1
	--assert response = LTM-OKAY
		mp-div-2-3-bp: mp-div-2-3-int1/mp-digit
		mp-div-2-3-bp/value: as LTM-digit! 126
		mp-div-2-3-bp: mp-div-2-3-bp + 1
		mp-div-2-3-bp/value: as LTM-digit! 1
		mp-div-2-3-int1/used: 2
		mp-div-2-3-int2: declare LTM-int!
		response: LTM-init mp-div-2-3-int2
	--assert response = LTM-OKAY
		response: LTM-div-2 mp-div-2-3-int1 mp-div-2-3-int2
	--assert response = LTM-OKAY
	--assert mp-div-2-3-int2/used = 1
	--assert mp-div-2-3-int2/mp-digit/value = as LTM-digit! 127
		
	--test-- "mp-div-2-4"
		mp-div-2-4-int1: declare LTM-int!
		response: LTM-init mp-div-2-4-int1
	--assert response = LTM-OKAY
		mp-div-2-4-int1/mp-digit/value: as LTM-digit! 2
		mp-div-2-4-int1/used: 1
		mp-div-2-4-int1/sign: LTM-NEG
		mp-div-2-4-int2: declare LTM-int!
		response: LTM-init mp-div-2-4-int2
	--assert response = LTM-OKAY
		response: LTM-div-2 mp-div-2-4-int1 mp-div-2-4-int2 
	--assert response = LTM-OKAY
	--assert mp-div-2-4-int2/used = 1
	--assert mp-div-2-4-int2/mp-digit/value = as LTM-digit! 1
	--assert mp-div-2-4-int2/sign = LTM-NEG
	
	--test-- "mp-div-2-5"
		mp-div-2-5-int1: declare LTM-int!
		response: LTM-init mp-div-2-5-int1
		mp-div-2-5-int1/used: 1
		mp-div-2-5-int1/mp-digit/1: as LTM-digit! 33
	--assert response = LTM-OKAY
		mp-div-2-5-int2: declare LTM-int!
		response: LTM-init mp-div-2-5-int2
	--assert response = LTM-OKAY
		response: LTM-div-2 mp-div-2-5-int1 mp-div-2-5-int2
	--assert response = LTM-OKAY
	--assert mp-div-2-5-int2/used = 1
	--assert mp-div-2-5-int2/mp-digit/1 = as LTM-digit! 16
	--assert mp-div-2-5-int2/sign = LTM-ZPOS
							
	--test-- "mp-div-2-6"
		mp-div-2-6-int1: declare LTM-int!
		response: LTM-init mp-div-2-6-int1
	--assert response = LTM-OKAY
		mp-div-2-6-int1/mp-digit/value: as LTM-digit! 127
		mp-div-2-6-int1/used: 1
		mp-div-2-6-int1/sign: LTM-NEG
		mp-div-2-6-int2: declare LTM-int!
		response: LTM-init mp-div-2-6-int2
	--assert response = LTM-OKAY
		response: LTM-div-2 mp-div-2-6-int1 mp-div-2-6-int2
	--assert response = LTM-OKAY
	--assert mp-div-2-6-int2/used = 1
	--assert mp-div-2-6-int2/sign = LTM-NEG
	--assert mp-div-2-6-int2/mp-digit/1 = as LTM-digit! 63
	
===end-group===

===start-group=== "left shift digits"
	
	--test-- "mp-lshd1"
		mp-lshd1-int: declare LTM-int!
		response: LTM-init mp-lshd1-int
	--assert response = LTM-OKAY
		mp-lshd1-int/used: 4
		mp-lshd1-int/mp-digit/1: as LTM-digit! 124
		mp-lshd1-int/mp-digit/2: as LTM-digit! 125
		mp-lshd1-int/mp-digit/3: as LTM-digit! 126
		mp-lshd1-int/mp-digit/4: as LTM-digit! 127
		response: LTM-lshd mp-lshd1-int 1
	--assert response = LTM-OKAY
	--assert mp-lshd1-int/used = 5
	--assert mp-lshd1-int/mp-digit/1 = as LTM-digit! 0
	--assert mp-lshd1-int/mp-digit/2 = as LTM-digit! 124
	--assert mp-lshd1-int/mp-digit/3 = as LTM-digit! 125
	--assert mp-lshd1-int/mp-digit/4 = as LTM-digit! 126
	--assert mp-lshd1-int/mp-digit/5 = as LTM-digit! 127
	
	--test-- "mp-lshd2"
		mp-lshd2-int: declare LTM-int!
		response: LTM-init mp-lshd2-int
	--assert response = LTM-OKAY
		mp-lshd2-int/used: 4
		mp-lshd2-int/mp-digit/1: as LTM-digit! 124
		mp-lshd2-int/mp-digit/2: as LTM-digit! 125
		mp-lshd2-int/mp-digit/3: as LTM-digit! 126
		mp-lshd2-int/mp-digit/4: as LTM-digit! 127
		response: LTM-lshd mp-lshd2-int 0
	--assert response = LTM-OKAY
	--assert mp-lshd2-int/used = 4
	--assert mp-lshd2-int/mp-digit/1 = as LTM-digit! 124
	--assert mp-lshd2-int/mp-digit/2 = as LTM-digit! 125
	--assert mp-lshd2-int/mp-digit/3 = as LTM-digit! 126
	--assert mp-lshd2-int/mp-digit/4 = as LTM-digit! 127
	
===end-group===

===start-group=== "right shift digits"
	
	--test-- "mp-rshd1"
		mp-rshd1-int: declare LTM-int!
		response: LTM-init mp-rshd1-int
	--assert response = LTM-OKAY
		mp-rshd1-int/used: 5
		mp-rshd1-int/mp-digit/1: as LTM-digit! 123
		mp-rshd1-int/mp-digit/2: as LTM-digit! 124
		mp-rshd1-int/mp-digit/3: as LTM-digit! 125
		mp-rshd1-int/mp-digit/4: as LTM-digit! 126
		mp-rshd1-int/mp-digit/5: as LTM-digit! 127
		response: LTM-rshd mp-rshd1-int 1
	--assert response = LTM-OKAY
	--assert mp-rshd1-int/used = 4
	--assert mp-rshd1-int/mp-digit/1 = as LTM-digit! 124
	--assert mp-rshd1-int/mp-digit/2 = as LTM-digit! 125
	--assert mp-rshd1-int/mp-digit/3 = as LTM-digit! 126
	--assert mp-rshd1-int/mp-digit/4 = as LTM-digit! 127
	
	--test-- "mp-rshd2"
		mp-rshd2-int: declare LTM-int!
		response: LTM-init mp-rshd2-int
	--assert response = LTM-OKAY
		mp-rshd2-int/used: 4
		mp-rshd2-int/mp-digit/1: as LTM-digit! 124
		mp-rshd2-int/mp-digit/2: as LTM-digit! 125
		mp-rshd2-int/mp-digit/3: as LTM-digit! 126
		mp-rshd2-int/mp-digit/4: as LTM-digit! 127
		response: LTM-rshd mp-rshd2-int 0
	--assert response = LTM-OKAY
	--assert mp-rshd2-int/used = 4
	--assert mp-rshd2-int/mp-digit/1 = as LTM-digit! 124
	--assert mp-rshd2-int/mp-digit/2 = as LTM-digit! 125
	--assert mp-rshd2-int/mp-digit/3 = as LTM-digit! 126
	--assert mp-rshd2-int/mp-digit/4 = as LTM-digit! 127
	
===end-group===

===start-group=== "left shift bits - multiply by power of 2"
	
	--test-- "mp-lshb1"
		mp-lshb1-int: declare LTM-int!
		response: LTM-init mp-lshb1-int
	--assert response = LTM-OKAY
		mp-lshb1-int/used: 4
		mp-lshb1-int/mp-digit/1: as LTM-digit! 4
		mp-lshb1-int/mp-digit/2: as LTM-digit! 8
		mp-lshb1-int/mp-digit/3: as LTM-digit! 16
		mp-lshb1-int/mp-digit/4: as LTM-digit! 2
		mp-lshb1-int2: declare LTM-int!
		response: LTM-mul-2d mp-lshb1-int 3 mp-lshb1-int2
	--assert response = LTM-OKAY
	--assert mp-lshb1-int2/used = 4
	--assert mp-lshb1-int2/mp-digit/1 = as LTM-digit! 32
	--assert mp-lshb1-int2/mp-digit/2 = as LTM-digit! 64
	--assert mp-lshb1-int2/mp-digit/3 = as LTM-digit! 0
	--assert mp-lshb1-int2/mp-digit/4 = as LTM-digit! 17
	
	--test-- "mp-lshb2"
		mp-lshb2-int: declare LTM-int!
		response: LTM-init mp-lshb2-int
	--assert response = LTM-OKAY
		mp-lshb2-int/used: 0
		mp-lshb2-int2: declare LTM-int!
		response: LTM-mul-2d mp-lshb2-int 3 mp-lshb2-int2
	--assert response = LTM-OKAY
	--assert mp-lshb2-int2/used = 0
	
	--test-- "mp-lshb3"
		mp-lshb3-int: declare LTM-int!
		response: LTM-init mp-lshb3-int
	--assert response = LTM-OKAY
		mp-lshb3-int/used: 4
		mp-lshb3-int/mp-digit/1: as LTM-digit! 4
		mp-lshb3-int/mp-digit/2: as LTM-digit! 8
		mp-lshb3-int/mp-digit/3: as LTM-digit! 16
		mp-lshb3-int/mp-digit/4: as LTM-digit! 2
		response: LTM-mul-2d mp-lshb3-int 3 mp-lshb3-int
	--assert response = LTM-OKAY
	--assert mp-lshb3-int/used = 4
	--assert mp-lshb3-int/mp-digit/1 = as LTM-digit! 32
	--assert mp-lshb3-int/mp-digit/2 = as LTM-digit! 64
	--assert mp-lshb3-int/mp-digit/3 = as LTM-digit! 0
	--assert mp-lshb3-int/mp-digit/4 = as LTM-digit! 17
	
	--test-- "mp-lshb4"
		mp-lshb4-int: declare LTM-int!
		response: LTM-init mp-lshb4-int
	--assert response = LTM-OKAY
		mp-lshb4-int/used: 4
		mp-lshb4-int/mp-digit/1: as LTM-digit! 4
		mp-lshb4-int/mp-digit/2: as LTM-digit! 8
		mp-lshb4-int/mp-digit/3: as LTM-digit! 16
		mp-lshb4-int/mp-digit/4: as LTM-digit! 127
		response: LTM-mul-2d mp-lshb4-int 3 mp-lshb4-int
	--assert response = LTM-OKAY
	--assert mp-lshb4-int/used = 5
	--assert mp-lshb4-int/mp-digit/1 = as LTM-digit! 32
	--assert mp-lshb4-int/mp-digit/2 = as LTM-digit! 64
	--assert mp-lshb4-int/mp-digit/3 = as LTM-digit! 0
	--assert mp-lshb4-int/mp-digit/4 = as LTM-digit! 121
	--assert mp-lshb4-int/mp-digit/5 = as LTM-digit! 7

===end-group===

===start-group=== "mp-set-int"
	
	--test-- "mpsetint1"
		mpsetint1-mp-int: declare LTM-int!
		response: LTM-init mpsetint1-mp-int
	--assert response = LTM-OKAY
		response: LTM-set-int mpsetint1-mp-int 12698633
	--assert response = LTM-OKAY
	--assert mpsetint1-mp-int/used = 4
	--assert mpsetint1-mp-int/mp-digit/1 = as LTM-digit! 9
	--assert mpsetint1-mp-int/mp-digit/2 = as LTM-digit! 8
	--assert mpsetint1-mp-int/mp-digit/3 = as LTM-digit! 7
	--assert mpsetint1-mp-int/mp-digit/4 = as LTM-digit! 6
	 
	--test-- "mpsetint2"
		mpsetint2-mp-int: declare LTM-int!
		response: LTM-init mpsetint2-mp-int
	--assert response = LTM-OKAY
		response: LTM-set-int mpsetint2-mp-int 2097023
	--assert response = LTM-OKAY
	--assert mpsetint2-mp-int/used = 3
	--assert mpsetint2-mp-int/mp-digit/1 = as LTM-digit! 127
	--assert mpsetint2-mp-int/mp-digit/2 = as LTM-digit! 126
	--assert mpsetint2-mp-int/mp-digit/3 = as LTM-digit! 127

===end-group===

===start-group=== "mp-div2d"

	--test-- "mpdiv2d1"
		mpdiv2d1-mp-int1: declare LTM-int!
		response: LTM-init mpdiv2d1-mp-int1
	--assert response = LTM-OKAY
		response: LTM-set-int mpdiv2d1-mp-int1 2
	--assert response = LTM-OKAY
		mpdiv2d1-mp-int2: declare LTM-int!
		response: LTM-init mpdiv2d1-mp-int2
	--assert response = LTM-OKAY
		mpdiv2d1-mp-int3: declare LTM-int!
		response: LTM-init mpdiv2d1-mp-int3
	--assert response = LTM-OKAY
		response: LTM-div-2d mpdiv2d1-mp-int1 2 mpdiv2d1-mp-int2 mpdiv2d1-mp-int3
	--assert response = LTM-OKAY
	--assert mpdiv2d1-mp-int2/mp-digit/value = 1
	--assert mpdiv2d1-mp-int2/used = 1
	--assert mpdiv2d1-mp-int2/sign = LTM-ZPOS
	--assert mpdiv2d1-mp-int3/mp-digit/value = 0
	--assert mpdiv2d1-mp-int3/sign = LTM-ZPOS
	--assert mpdiv2d1-mp-int2/used = 1

===end-group===

===start-group=== "s-mul-digs"

	--test-- "smpmuld1"
		smuld1-mp-int1: declare LTM-int!
		response: LTM-init smuld1-mp-int1
	--assert response = LTM-OKAY
		response: LTM-set-int mpsetint1-mp-int 12698633
	--assert response = LTM-OKAY
		smuld1-mp-int2: declare LTM-int!
		response: LTM-init smuld1-mp-int2
	--assert response = LTM-OKAY
		smuld1-mp-int2/mp-digit/1: as LTM-digit! 3
		smuld1-mp-int3: declare LTM-int!
		response: LTM-init smuld1-mp-int3
	--assert response = LTM-OKAY
		response: LTM-s-mul-digs smuld1-mp-int1 smuld1-mp-int2 smuld1-mp-int3 5
	--assert response = LTM-OKAY
	--assert smuld1-mp-int3/mp-digit/1 = as LTM-digit! 27
	--assert smuld1-mp-int3/mp-digit/2 = as LTM-digit! 24
	--assert smuld1-mp-int3/mp-digit/3 = as LTM-digit! 21
	--assert smuld1-mp-int3/mp-digit/4 = as LTM-digit! 18

===end-group===

~~~end-file~~~

