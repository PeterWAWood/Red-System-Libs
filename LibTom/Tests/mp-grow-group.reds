Red/System []

===start-group=== "mp-grow"

	--test-- "mg1"
		mg1-mp-int: declare LTM-int!
		response: LTM-init mg1-mp-int
	--assert response = LTM-OKAY
		mg1-i: mg1-mp-int/mp-digit
		mg1-i/value: #"^(01)"
		mg1-i: mg1-i + 1
		mg1-i/value: #"^(FF)"
		mg1-bp: allocate 8 				;; allocate memory to try to avoid
										;; same memory being allocated.
		response: LTM-grow mg1-mp-int LTM-PREC + 1
	--assert response = LTM-OKAY
	--assert mg1-mp-int/alloc = (3 * LTM-PREC)
		mg1-j: mg1-mp-int/mp-digit
	--assert mg1-j/value = #"^(01)"
		mg1-j: mg1-j + 1
	--assert mg1-j/value = #"^(FF)"
		free mg1-bp
		response: LTM-clear mg1-mp-int
	--assert response = LTM-OKAY
	
	--test-- "mg2"
		mg2-mp-int: declare LTM-int!
		response: LTM-init mg2-mp-int
	--assert response = LTM-OKAY
		response: LTM-grow mg2-mp-int LTM-PREC - 1
	--assert response = LTM-OKAY
	--assert mg2-mp-int/alloc = LTM-PREC
		response: LTM-clear mg2-mp-int
	--assert response = LTM-OKAY

===end-group===
