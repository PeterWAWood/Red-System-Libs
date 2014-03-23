Red/System []

===start-group=== "mp-init-size"
	--test-- "mis1"
		mis1-mp-int: declare LTM-int!
		response: LTM-init-size mis1-mp-int 1
	--assert response = LTM-OKAY
	--assert mis1-mp-int/used = 0
	--assert mis1-mp-int/alloc = (2 * LTM-PREC)
	--assert mis1-mp-int/sign =  LTM-ZPOS
	--assert 0 <> as integer! mis1-mp-int/mp-digit
		mis1-i: mis1-mp-int/alloc
		mis1-bp: mis1-mp-int/mp-digit
		until [
			--assert mis1-bp/value = null-byte
				mis1-bp: mis1-bp + 1
				mis1-i: mis1-i - 1
				mis1-i = 0
		]
		response: LTM-clear mis1-mp-int
	--assert response = LTM-OKAY

===end-group===