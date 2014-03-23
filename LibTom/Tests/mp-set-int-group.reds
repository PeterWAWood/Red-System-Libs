Red/System []

===start-group=== "mp-set-int"
	
	--test-- "mpsetint1"
		mpsetint1-mp-int: declare LTM-int!
		response: LTM-init mpsetint1-mp-int
	--assert response = LTM-OKAY
		response: LTM-set-int mpsetint1-mp-int 12698633
	--assert response = LTM-OKAY
	--assert mpsetint1-mp-int/used = 4
	--assert mpsetint1-mp-int/mp-digit/1 = as LTM-digit! 9
	--assert mpsetint1-mp-int/mp-digit/2 = as LTM-digit! 8
	--assert mpsetint1-mp-int/mp-digit/3 = as LTM-digit! 7
	--assert mpsetint1-mp-int/mp-digit/4 = as LTM-digit! 6
	 
	--test-- "mpsetint2"
		mpsetint2-mp-int: declare LTM-int!
		response: LTM-init mpsetint2-mp-int
	--assert response = LTM-OKAY
		response: LTM-set-int mpsetint2-mp-int 2097023
	--assert response = LTM-OKAY
	--assert mpsetint2-mp-int/used = 3
	--assert mpsetint2-mp-int/mp-digit/1 = as LTM-digit! 127
	--assert mpsetint2-mp-int/mp-digit/2 = as LTM-digit! 126
	--assert mpsetint2-mp-int/mp-digit/3 = as LTM-digit! 127

===end-group===
