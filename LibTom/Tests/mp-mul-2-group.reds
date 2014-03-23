Red/System []

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
