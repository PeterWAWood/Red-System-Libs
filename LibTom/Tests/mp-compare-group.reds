Red/System []

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

