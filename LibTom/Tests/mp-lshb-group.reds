Red/System []

===start-group=== "left shift bits - multiply by power of 2"
	
	--test-- "mp-lshb1"
		mp-lshb1-int: declare LTM-int!
		response: LTM-init mp-lshb1-int
	--assert response = LTM-OKAY
		mp-lshb1-int/used: 4
		mp-lshb1-int/mp-digit/1: as LTM-digit! 4
		mp-lshb1-int/mp-digit/2: as LTM-digit! 8
		mp-lshb1-int/mp-digit/3: as LTM-digit! 16
		mp-lshb1-int/mp-digit/4: as LTM-digit! 2
		mp-lshb1-int2: declare LTM-int!
		response: LTM-mul-2d mp-lshb1-int 3 mp-lshb1-int2
	--assert response = LTM-OKAY
	--assert mp-lshb1-int2/used = 4
	--assert mp-lshb1-int2/mp-digit/1 = as LTM-digit! 32
	--assert mp-lshb1-int2/mp-digit/2 = as LTM-digit! 64
	--assert mp-lshb1-int2/mp-digit/3 = as LTM-digit! 0
	--assert mp-lshb1-int2/mp-digit/4 = as LTM-digit! 17
	
	--test-- "mp-lshb2"
		mp-lshb2-int: declare LTM-int!
		response: LTM-init mp-lshb2-int
	--assert response = LTM-OKAY
		mp-lshb2-int/used: 0
		mp-lshb2-int2: declare LTM-int!
		response: LTM-mul-2d mp-lshb2-int 3 mp-lshb2-int2
	--assert response = LTM-OKAY
	--assert mp-lshb2-int2/used = 0
	
	--test-- "mp-lshb3"
		mp-lshb3-int: declare LTM-int!
		response: LTM-init mp-lshb3-int
	--assert response = LTM-OKAY
		mp-lshb3-int/used: 4
		mp-lshb3-int/mp-digit/1: as LTM-digit! 4
		mp-lshb3-int/mp-digit/2: as LTM-digit! 8
		mp-lshb3-int/mp-digit/3: as LTM-digit! 16
		mp-lshb3-int/mp-digit/4: as LTM-digit! 2
		response: LTM-mul-2d mp-lshb3-int 3 mp-lshb3-int
	--assert response = LTM-OKAY
	--assert mp-lshb3-int/used = 4
	--assert mp-lshb3-int/mp-digit/1 = as LTM-digit! 32
	--assert mp-lshb3-int/mp-digit/2 = as LTM-digit! 64
	--assert mp-lshb3-int/mp-digit/3 = as LTM-digit! 0
	--assert mp-lshb3-int/mp-digit/4 = as LTM-digit! 17
	
	--test-- "mp-lshb4"
		mp-lshb4-int: declare LTM-int!
		response: LTM-init mp-lshb4-int
	--assert response = LTM-OKAY
		mp-lshb4-int/used: 4
		mp-lshb4-int/mp-digit/1: as LTM-digit! 4
		mp-lshb4-int/mp-digit/2: as LTM-digit! 8
		mp-lshb4-int/mp-digit/3: as LTM-digit! 16
		mp-lshb4-int/mp-digit/4: as LTM-digit! 127
		response: LTM-mul-2d mp-lshb4-int 3 mp-lshb4-int
	--assert response = LTM-OKAY
	--assert mp-lshb4-int/used = 5
	--assert mp-lshb4-int/mp-digit/1 = as LTM-digit! 32
	--assert mp-lshb4-int/mp-digit/2 = as LTM-digit! 64
	--assert mp-lshb4-int/mp-digit/3 = as LTM-digit! 0
	--assert mp-lshb4-int/mp-digit/4 = as LTM-digit! 121
	--assert mp-lshb4-int/mp-digit/5 = as LTM-digit! 7

===end-group===
