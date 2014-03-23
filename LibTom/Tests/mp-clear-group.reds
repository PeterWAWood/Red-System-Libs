Red/System []

===start-group=== "mp-clear"
	--test-- "mc1"
		mc1-mp-int: declare LTM-int!
		response: LTM-init mc1-mp-int
	--assert response = LTM-OKAY
		mc1-mp-int/used: 1
		mc1-mp-int/sign: LTM-NEG
		response: LTM-clear mc1-mp-int
	--assert response = LTM-OKAY
	--assert mc1-mp-int/used = 0
	--assert mc1-mp-int/alloc = 0
	--assert mc1-mp-int/sign = LTM-ZPOS
	--assert mc1-mp-int/mp-digit = as byte-ptr! 0
	
	--test-- "mc2"
		mc2-mp-int: declare LTM-int!
		response: LTM-init mc2-mp-int
	--assert response = LTM-OKAY
		response: LTM-clear mc2-mp-int
	--assert response = LTM-OKAY
		mc2-mp-int/used: 1
		response: LTM-clear mc2-mp-int
	--assert response = LTM-INVALID	
	--assert mc2-mp-int/used = 1
===end-group===
