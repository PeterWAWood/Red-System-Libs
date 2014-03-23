Red/System []

===start-group=== "mp-copy-init"

	--test-- "mcpyi1"
		mcpyi1-mp-int1: declare LTM-int!
		response: LTM-init mcpyi1-mp-int1
	--assert response = LTM-OKAY
		mcpyi1-mp-int1/used: 1
		mcpyi1-mp-int1/mp-digit/value: #"^(11)"
		mcpi1-mp-int2: declare LTM-int!
		mcpyi1-mp-int1/sign: LTM-NEG
		mcpyi1-mp-int2: declare LTM-int!
		response: LTM-copy-init mcpyi1-mp-int2 mcpyi1-mp-int1
	--assert response = LTM-OKAY
	--assert mcpyi1-mp-int2/used = 1
	--assert mcpyi1-mp-int2/sign = LTM-NEG
	--assert mcpyi1-mp-int2/alloc = LTM-PREC
	--assert mcpyi1-mp-int2/mp-digit/value = #"^(11)"
		
	--test-- "mcpyi2"
		mcpyi2-mp-int1: declare LTM-int!
		response: LTM-init mcpyi2-mp-int1
	--assert response = LTM-OKAY
		mcpyi2-mp-int1/used: LTM-PREC + 1
		mcpyi2-mp-int1/mp-digit/value: #"^(21)"
			response: LTM-grow mcpyi2-mp-int1 LTM-PREC + 1
	--assert response = LTM-OKAY
		mcpyi2-mp-int2: declare LTM-int!
		response: LTM-copy-init mcpyi2-mp-int2 mcpyi2-mp-int1
	--assert response = LTM-OKAY	
	--assert mcpyi2-mp-int2/used = 33				;; mp-copy doesn't clamp
	--assert mcpyi2-mp-int2/sign = LTM-ZPOS
	--assert mcpyi2-mp-int2/alloc = (3 * LTM-PREC)
	--assert mcpyi2-mp-int2/mp-digit/value = #"^(21)"

===end-group===
