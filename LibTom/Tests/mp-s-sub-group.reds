Red/System []

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
