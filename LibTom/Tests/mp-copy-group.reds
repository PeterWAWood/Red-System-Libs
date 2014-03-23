Red/System []

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
