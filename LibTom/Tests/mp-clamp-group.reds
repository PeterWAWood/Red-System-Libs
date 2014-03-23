Red/System []

===start-group=== "mp-clamp"
	--test-- "mcl1"
		mcl1-mp-int: declare LTM-int!
		response: LTM-init mcl1-mp-int
	--assert response = LTM-OKAY
		mcl1-mp-int/used: 4
		mcl1-mp-int/sign: LTM-NEG
		response: LTM-clamp mcl1-mp-int
	--assert response = LTM-OKAY
	--assert mcl1-mp-int/used = 0
	--assert mcl1-mp-int/alloc = LTM-PREC
	--assert mcl1-mp-int/sign = LTM-ZPOS
	--assert mcl1-mp-int/mp-digit <> as byte-ptr! 0
		response: LTM-clear mcl1-mp-int
	--assert response = LTM-OKAY
	
	--test-- "mcl2"
		mcl2-mp-int: declare LTM-int!
		response: LTM-init mcl2-mp-int
	--assert response = LTM-OKAY
		mcl2-mp-int/used: 4
		mcl2-mp-int/sign: LTM-ZPOS
		mcl2-mp-int/mp-digit/value: #"^(01)"
		response: LTM-clamp mcl2-mp-int
	--assert response = LTM-OKAY
	--assert mcl2-mp-int/used = 1
	--assert mcl2-mp-int/sign = LTM-ZPOS
	--assert mcl2-mp-int/alloc = LTM-PREC
	--assert mcl2-mp-int/mp-digit/value = #"^(01)"
		response: LTM-clear mcl2-mp-int
	--assert response = LTM-OKAY
	
	--test-- "mcl3"
		mcl3-mp-int: declare LTM-int!
		response: LTM-init mcl3-mp-int
	--assert response = LTM-OKAY
		mcl3-mp-int/used: 1
		mcl3-mp-int/sign: LTM-ZPOS
		mcl3-mp-int/mp-digit/value: #"^(0F)"
		response: LTM-clamp mcl3-mp-int
	--assert response = LTM-OKAY
	--assert mcl3-mp-int/used = 1
	--assert mcl3-mp-int/sign = LTM-ZPOS
	--assert mcl3-mp-int/alloc = LTM-PREC
	--assert mcl3-mp-int/mp-digit/value = #"^(0F)"
		response: LTM-clear mcl3-mp-int
	--assert response = LTM-OKAY

===end-group===
