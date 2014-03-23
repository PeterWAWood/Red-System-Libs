Red/System []

===start-group=== "right shift digits"
	
	--test-- "mp-rshd1"
		mp-rshd1-int: declare LTM-int!
		response: LTM-init mp-rshd1-int
	--assert response = LTM-OKAY
		mp-rshd1-int/used: 5
		mp-rshd1-int/mp-digit/1: as LTM-digit! 123
		mp-rshd1-int/mp-digit/2: as LTM-digit! 124
		mp-rshd1-int/mp-digit/3: as LTM-digit! 125
		mp-rshd1-int/mp-digit/4: as LTM-digit! 126
		mp-rshd1-int/mp-digit/5: as LTM-digit! 127
		response: LTM-rshd mp-rshd1-int 1
	--assert response = LTM-OKAY
	--assert mp-rshd1-int/used = 4
	--assert mp-rshd1-int/mp-digit/1 = as LTM-digit! 124
	--assert mp-rshd1-int/mp-digit/2 = as LTM-digit! 125
	--assert mp-rshd1-int/mp-digit/3 = as LTM-digit! 126
	--assert mp-rshd1-int/mp-digit/4 = as LTM-digit! 127
	
	--test-- "mp-rshd2"
		mp-rshd2-int: declare LTM-int!
		response: LTM-init mp-rshd2-int
	--assert response = LTM-OKAY
		mp-rshd2-int/used: 4
		mp-rshd2-int/mp-digit/1: as LTM-digit! 124
		mp-rshd2-int/mp-digit/2: as LTM-digit! 125
		mp-rshd2-int/mp-digit/3: as LTM-digit! 126
		mp-rshd2-int/mp-digit/4: as LTM-digit! 127
		response: LTM-rshd mp-rshd2-int 0
	--assert response = LTM-OKAY
	--assert mp-rshd2-int/used = 4
	--assert mp-rshd2-int/mp-digit/1 = as LTM-digit! 124
	--assert mp-rshd2-int/mp-digit/2 = as LTM-digit! 125
	--assert mp-rshd2-int/mp-digit/3 = as LTM-digit! 126
	--assert mp-rshd2-int/mp-digit/4 = as LTM-digit! 127
	
===end-group===
