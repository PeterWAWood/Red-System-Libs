Red/System []

===start-group=== "mp-div2d"

	--test-- "mpdiv2d1"
		mpdiv2d1-mp-int1: declare LTM-int!
		response: LTM-init mpdiv2d1-mp-int1
	--assert response = LTM-OKAY
		response: LTM-set-int mpdiv2d1-mp-int1 2
	--assert response = LTM-OKAY
		mpdiv2d1-mp-int2: declare LTM-int!
		response: LTM-init mpdiv2d1-mp-int2
	--assert response = LTM-OKAY
		mpdiv2d1-mp-int3: declare LTM-int!
		response: LTM-init mpdiv2d1-mp-int3
	--assert response = LTM-OKAY
		response: LTM-div-2d mpdiv2d1-mp-int1 2 mpdiv2d1-mp-int2 mpdiv2d1-mp-int3
	--assert response = LTM-OKAY
	--assert mpdiv2d1-mp-int2/mp-digit/value = 1
	--assert mpdiv2d1-mp-int2/used = 1
	--assert mpdiv2d1-mp-int2/sign = LTM-ZPOS
	--assert mpdiv2d1-mp-int3/mp-digit/value = 0
	--assert mpdiv2d1-mp-int3/sign = LTM-ZPOS
	--assert mpdiv2d1-mp-int2/used = 1

===end-group===