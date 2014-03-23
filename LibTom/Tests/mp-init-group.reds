Red/System []

===start-group=== "mp-init"
	--test-- "mi1"
		mi1-mp-int: declare LTM-int!
		response: LTM-init mi1-mp-int
	--assert response = LTM-OKAY
	--assert mi1-mp-int/used = 0
	--assert mi1-mp-int/alloc = LTM-PREC
	--assert mi1-mp-int/sign =  LTM-ZPOS
	--assert 0 <> as integer! mi1-mp-int/mp-digit
		mi1-i: mi1-mp-int/alloc
		until [
			--assert mi1-mp-int/mp-digit/value = null-byte
				mi1-mp-int/mp-digit: mi1-mp-int/mp-digit + 1
				mi1-i: mi1-i - 1
				mi1-i = 0
		]
===end-group===
