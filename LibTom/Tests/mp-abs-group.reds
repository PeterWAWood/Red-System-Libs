Red/System []

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
