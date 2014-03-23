Red/System []

===start-group=== "mp-zero"

	--test-- "mz1"
		mz1-mp-int1: declare LTM-int!
		response: LTM-init mz1-mp-int1
	--assert response = LTM-OKAY
		mz1-mp-int1/mp-digit/value: #"^(21)"
		mz1-mp-int1/sign: LTM-NEG
		response: LTM-zero mz1-mp-int1
	--assert response = LTM-OKAY
	--assert mz1-mp-int1/used = 0	
	--assert mz1-mp-int1/sign = LTM-ZPOS
	--assert mz1-mp-int1/alloc = LTM-PREC
	--assert mz1-mp-int1/mp-digit/value = #"^(00)"
	
===end-group===
