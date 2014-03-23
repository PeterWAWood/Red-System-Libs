Red/System []

===start-group=== "s-add"						;; low level addition

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