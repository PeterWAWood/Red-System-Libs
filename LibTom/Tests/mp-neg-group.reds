Red/System []

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
