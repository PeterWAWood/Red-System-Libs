Red/System []

===start-group=== "s-mul-digs"

	--test-- "smpmuld1"
		smuld1-mp-int1: declare LTM-int!
		response: LTM-init smuld1-mp-int1
	--assert response = LTM-OKAY
		response: LTM-set-int mpsetint1-mp-int 12698633
	--assert response = LTM-OKAY
		smuld1-mp-int2: declare LTM-int!
		response: LTM-init smuld1-mp-int2
	--assert response = LTM-OKAY
		smuld1-mp-int2/mp-digit/1: as LTM-digit! 3
		smuld1-mp-int3: declare LTM-int!
		response: LTM-init smuld1-mp-int3
	--assert response = LTM-OKAY
		response: LTM-s-mul-digs smuld1-mp-int1 smuld1-mp-int2 smuld1-mp-int3 5
	--assert response = LTM-OKAY
	--assert smuld1-mp-int3/mp-digit/1 = as LTM-digit! 27
	--assert smuld1-mp-int3/mp-digit/2 = as LTM-digit! 24
	--assert smuld1-mp-int3/mp-digit/3 = as LTM-digit! 21
	--assert smuld1-mp-int3/mp-digit/4 = as LTM-digit! 18

===end-group===