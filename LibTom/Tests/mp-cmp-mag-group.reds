Red/System []

===start-group=== "compare magnitude"

	--test-- "mp-cmp-mag1"
		mp-cmp-mag1-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag1-mp-int1
	--assert response = LTM-OKAY
		mp-cmp-mag1-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag1-mp-int2
	--assert response = LTM-OKAY
		response: LTM-cmp-mag mp-cmp-mag1-mp-int1 mp-cmp-mag1-mp-int2
	--assert response = LTM-EQ
	
	--test-- "mp-cmp-mag2"
		mp-cmp-mag2-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag2-mp-int1
		mp-cmp-mag2-mp-int1/used: 1
		mp-cmp-mag2-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp-mag2-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag2-mp-int2
	--assert response = LTM-OKAY
		response: LTM-cmp-mag mp-cmp-mag2-mp-int1 mp-cmp-mag2-mp-int2
	--assert response = LTM-GT
	
	--test-- "mp-cmp-mag3"
		mp-cmp-mag3-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag3-mp-int1
		mp-cmp-mag3-mp-int1/used: 1
		mp-cmp-mag3-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp-mag3-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag3-mp-int2
		mp-cmp-mag3-mp-int2/used: 2
		mp-cmp-mag3-bp: mp-cmp-mag3-mp-int2/mp-digit
		mp-cmp-mag3-bp: mp-cmp-mag3-bp + 1
		mp-cmp-mag3-bp/value: #"^(7F)"
	--assert response = LTM-OKAY
		response: LTM-cmp-mag mp-cmp-mag3-mp-int1 mp-cmp-mag3-mp-int2
	--assert response = LTM-LT
	
	--test-- "mp-cmp-mag4"
		mp-cmp-mag4-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag4-mp-int1
		mp-cmp-mag4-mp-int1/used: 1
		mp-cmp-mag4-mp-int1/mp-digit/value: #"^(7F)"
	--assert response = LTM-OKAY
		mp-cmp-mag4-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag4-mp-int2
	--assert response = LTM-OKAY
		mp-cmp-mag4-mp-int2/used: 1
		mp-cmp-mag4-mp-int2/mp-digit/value: #"^(7F)"
		response: LTM-cmp-mag mp-cmp-mag4-mp-int1 mp-cmp-mag4-mp-int2
	--assert response = LTM-EQ
	
	--test-- "mp-cmp-mag5"
		mp-cmp-mag5-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int1
		mp-cmp-mag5-mp-int1/used: 1
		mp-cmp-mag5-mp-int1/mp-digit/value: #"^(7F)"
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int2
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2/used: 1
		mp-cmp-mag5-mp-int2/mp-digit/value: #"^(7E)"
		response: LTM-cmp-mag mp-cmp-mag5-mp-int1 mp-cmp-mag5-mp-int2
	--assert response = LTM-GT
	
	--test-- "mp-cmp-mag5"
		mp-cmp-mag5-mp-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int1
		mp-cmp-mag5-mp-int1/used: 1
		mp-cmp-mag5-mp-int1/mp-digit/value: #"^(01)"
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag5-mp-int2
	--assert response = LTM-OKAY
		mp-cmp-mag5-mp-int2/used: 1
		mp-cmp-mag5-mp-int2/mp-digit/value: #"^(02)"
		response: LTM-cmp-mag mp-cmp-mag5-mp-int1 mp-cmp-mag5-mp-int2
	--assert response = LTM-LT
	
	--test-- "mp-cmp-mag6"
		mp-cmp-mag6-int1: declare LTM-int!
		response: LTM-init mp-cmp-mag6-int1
	--assert response = LTM-OKAY
		mp-cmp-mag6-int1/mp-digit/value: as LTM-digit! 1
		mp-cmp-mag6-int1/used: 1
		mp-cmp-mag6-int2: declare LTM-int!
		response: LTM-init mp-cmp-mag6-int2
	--assert response = LTM-OKAY
		mp-cmp-mag6-int2/used: 2
		mp-cmp-mag6-bp: mp-cmp-mag6-int2/mp-digit
		mp-cmp-mag6-bp/value: as LTM-digit! 1
		mp-cmp-mag6-bp: mp-cmp-mag6-bp + 1
		mp-cmp-mag6-bp/value: as LTM-digit! 2
		response: LTM-cmp-mag mp-cmp-mag6-int1 mp-cmp-mag6-int2
	--assert response = LTM-LT
	
===end-group===
