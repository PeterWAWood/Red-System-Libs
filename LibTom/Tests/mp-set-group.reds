Red/System []

===start-group=== "mp-set"
	
	--test-- "mpset1"
		mpset1-mp-int: declare LTM-int!
		response: LTM-init mpset1-mp-int
	--assert response = LTM-OKAY
		response: LTM-set mpset1-mp-int as LTM-digit! 1
	--assert response = LTM-OKAY
	--assert mpset1-mp-int/used = 1
	--assert mpset1-mp-int/mp-digit/value = as LTM-digit! 1
	
	--test-- "mpset2"
		mpset2-mp-int: declare LTM-int!
		response: LTM-init mpset2-mp-int
	--assert response = LTM-OKAY
		response: LTM-set mpset2-mp-int as LTM-digit! 127
	--assert response = LTM-OKAY
	--assert mpset2-mp-int/used = 1
	--assert mpset2-mp-int/mp-digit/value = as LTM-digit! 127
		
===end-group===
