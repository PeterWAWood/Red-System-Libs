Red/System []

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
