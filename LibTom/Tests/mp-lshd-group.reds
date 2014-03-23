Red/System []

===start-group=== "left shift digits"
	
	--test-- "mp-lshd1"
		mp-lshd1-int: declare LTM-int!
		response: LTM-init mp-lshd1-int
	--assert response = LTM-OKAY
		mp-lshd1-int/used: 4
		mp-lshd1-int/mp-digit/1: as LTM-digit! 124
		mp-lshd1-int/mp-digit/2: as LTM-digit! 125
		mp-lshd1-int/mp-digit/3: as LTM-digit! 126
		mp-lshd1-int/mp-digit/4: as LTM-digit! 127
		response: LTM-lshd mp-lshd1-int 1
	--assert response = LTM-OKAY
	--assert mp-lshd1-int/used = 5
	--assert mp-lshd1-int/mp-digit/1 = as LTM-digit! 0
	--assert mp-lshd1-int/mp-digit/2 = as LTM-digit! 124
	--assert mp-lshd1-int/mp-digit/3 = as LTM-digit! 125
	--assert mp-lshd1-int/mp-digit/4 = as LTM-digit! 126
	--assert mp-lshd1-int/mp-digit/5 = as LTM-digit! 127
	
	--test-- "mp-lshd2"
		mp-lshd2-int: declare LTM-int!
		response: LTM-init mp-lshd2-int
	--assert response = LTM-OKAY
		mp-lshd2-int/used: 4
		mp-lshd2-int/mp-digit/1: as LTM-digit! 124
		mp-lshd2-int/mp-digit/2: as LTM-digit! 125
		mp-lshd2-int/mp-digit/3: as LTM-digit! 126
		mp-lshd2-int/mp-digit/4: as LTM-digit! 127
		response: LTM-lshd mp-lshd2-int 0
	--assert response = LTM-OKAY
	--assert mp-lshd2-int/used = 4
	--assert mp-lshd2-int/mp-digit/1 = as LTM-digit! 124
	--assert mp-lshd2-int/mp-digit/2 = as LTM-digit! 125
	--assert mp-lshd2-int/mp-digit/3 = as LTM-digit! 126
	--assert mp-lshd2-int/mp-digit/4 = as LTM-digit! 127
	
===end-group===
