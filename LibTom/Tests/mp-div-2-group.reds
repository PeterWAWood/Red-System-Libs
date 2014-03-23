Red/System []

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