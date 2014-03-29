Red/System []

===start-group=== "mp-mod-2d"

	--test-- "mpmod2d1"
		mpmod2d1-mp-int1: declare LTM-int!
		response: LTM-init mpmod2d1-mp-int1
		--assert response = LTM-OKAY
		response: LTM-set-int mpmod2d1-mp-int1 2
		--assert response = LTM-OKAY
		mpmod2d1-mp-int2: declare LTM-int!
		response: LTM-init mpmod2d1-mp-int2
		--assert response = LTM-OKAY
		response: LTM-mod-2d mpmod2d1-mp-int1 0 mpmod2d1-mp-int2
		--assert response = LTM-OKAY
		--assert mpmod2d1-mp-int2/mp-digit/1 = (as LTM-digit! 0)
		--assert mpmod2d1-mp-int2/used = 0
		--assert mpmod2d1-mp-int2/sign = LTM-ZPOS
		
	--test-- "mpmod2d2"
		mpmod2d2-mp-int1: declare LTM-int!
		response: LTM-init mpmod2d2-mp-int1
		--assert response = LTM-OKAY
		response: LTM-set-int mpmod2d2-mp-int1 3
		--assert response = LTM-OKAY
		mpmod2d2-mp-int2: declare LTM-int!
		response: LTM-init mpmod2d2-mp-int2
		--assert response = LTM-OKAY
		response: LTM-mod-2d mpmod2d2-mp-int1 2 mpmod2d2-mp-int2
		--assert response = LTM-OKAY
		--assert mpmod2d2-mp-int2/mp-digit/1 = (as LTM-digit! 3)
		--assert mpmod2d2-mp-int2/used = 1
		--assert mpmod2d2-mp-int2/sign = LTM-ZPOS
		
	--test-- "mpmod2d3"
		mpmod2d3-mp-int1: declare LTM-int!
		response: LTM-init mpmod2d3-mp-int1
		--assert response = LTM-OKAY
		response: LTM-set-int mpmod2d3-mp-int1 3
		--assert response = LTM-OKAY
		mpmod2d3-mp-int2: declare LTM-int!
		response: LTM-init mpmod2d3-mp-int2
		--assert response = LTM-OKAY
		response: LTM-mod-2d mpmod2d3-mp-int1 1 mpmod2d3-mp-int2
		--assert response = LTM-OKAY
		--assert mpmod2d3-mp-int2/mp-digit/1 = (as LTM-digit! 1)
		--assert mpmod2d3-mp-int2/used = 1
		--assert mpmod2d3-mp-int2/sign = LTM-ZPOS
		
	--test-- "mpmod2d4"
		mpmod2d4-mp-int1: declare LTM-int!
		response: LTM-init mpmod2d4-mp-int1
		--assert response = LTM-OKAY
		response: LTM-set-int mpmod2d4-mp-int1 3
		--assert response = LTM-OKAY
		mpmod2d4-mp-int2: declare LTM-int!
		response: LTM-init mpmod2d4-mp-int2
		--assert response = LTM-OKAY
		response: LTM-mod-2d mpmod2d4-mp-int1 128 mpmod2d4-mp-int2
		--assert response = LTM-OKAY
		--assert mpmod2d4-mp-int2/mp-digit/1 = (as LTM-digit! 3)
		--assert mpmod2d4-mp-int2/used = 1
		--assert mpmod2d4-mp-int2/sign = LTM-ZPOS

===end-group===