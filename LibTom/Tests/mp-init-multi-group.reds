Red/System []

===start-group=== "mp-init-multi"

	--test-- "mim1"
		mim1-mp-int1: declare LTM-int!
		mim1-mp-int2: declare LTM-int!
		response: LTM-init-multi [mim1-mp-int1 mim1-mp-int2]
	--assert response = LTM-OKAY
	--assert mim1-mp-int1/used = 0
	--assert mim1-mp-int2/used = 0
	--assert mim1-mp-int1/alloc = LTM-PREC
	--assert mim1-mp-int2/alloc = LTM-PREC
	--assert mim1-mp-int1/sign =  LTM-ZPOS
	--assert mim1-mp-int2/sign =  LTM-ZPOS
	--assert 0 <> as integer! mim1-mp-int1/mp-digit
	--assert 0 <> as integer! mim1-mp-int2/mp-digit
		mim1-i: mim1-mp-int1/alloc
		mim1-bp: mim1-mp-int1/mp-digit
		until [
			--assert mim1-bp/value = null-byte
				mim1-bp: mim1-bp + 1
				mim1-i: mim1-i - 1
				mim1-i = 0
		]
		response: LTM-clear mim1-mp-int1
	--assert response = LTM-OKAY
		mim1-i: mim1-mp-int2/alloc
		mim1-bp: mim1-mp-int2/mp-digit
		until [
			--assert mim1-bp/value = null-byte
				mim1-bp: mim1-bp + 1
				mim1-i: mim1-i - 1
				mim1-i = 0
		]
		response: LTM-clear mim1-mp-int2
	--assert response = LTM-OKAY
		
===end-group===
