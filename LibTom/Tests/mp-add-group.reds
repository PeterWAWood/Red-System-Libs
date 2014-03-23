Red/System []

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
