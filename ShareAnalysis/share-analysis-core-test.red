red [
	Title:		"Share Analysis"
	Author:  	"Peter W A Wood"
	File: 	 	%share-analysis.red
	Purpose:	"Tests of share analysis calculator" 	
	Tabs:	 	4
	Rights:  "Copyright (C) 2016 Peter W A Wood. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}

]

unless value? 'qt-run-tests [do %../../../../Red/red/quick-test/quick-test.red]
do %share-analysis-core.red

~~~start-file~~~ "share analysis core test"

===start-group=== "natural?" 

	--test-- "n1"		--assert sa/natural? 1.00
 	--test-- "n2"		--assert sa/natural? -123456789.12334
 	--test-- "n3"		--assert not sa/natural? 1.#NaN
 	--test-- "n4"		--assert not sa/natural? 1.#INF
 	--test-- "n5"		--assert not sa/natural? -1.#INF

===end-group===

===start-group=== "export-float"
	
	--test-- "ef1"		--assert "0.00" == sa/export-float 0.00
	--test-- "ef2"		--assert "0.00" == sa/export-float 0.0
	--test-- "ef3"		--assert "1.00" == sa/export-float 1.0
	--test-- "ef4"		--assert "1.00" == sa/export-float 1.004
	--test-- "ef5"		--assert "12,345.67" == sa/export-float 12345.674
	--test-- "ef6"		--assert "∞" == sa/export-float 1.#INF
	--test-- "ef7"		--assert "-∞" == sa/export-float -1.#INF
	--test-- "ef8"		--assert "-" == sa/export-float 1.#NaN
	--test-- "ef9"		--assert "(1.00)" = sa/export-float -1.00
	--test-- "ef10"		
		--assert "(234,567,890.00)" = sa/export-float -234567890.00
	
===end-group===

===start-group=== "export-percent"
	
	--test-- "ep1"		--assert "0.00%" == sa/export-percent 0.00
	--test-- "ep2"		--assert "0.00%" == sa/export-percent 0.0
	--test-- "ep3"		--assert "100.00%" == sa/export-percent 1.0
	--test-- "ep4"		--assert "100.40%" == sa/export-percent 1.004
	--test-- "ep5"		--assert "1,234,567.40%" == sa/export-percent 12345.674
	--test-- "ep6"		--assert "-" == sa/export-percent 1.#INF
	--test-- "ep7"		--assert "-" == sa/export-percent -1.#INF
	--test-- "ep8"		--assert "-" == sa/export-percent 1.#NaN
	--test-- "ep9"		--assert "(100.00%)" = sa/export-percent -1.00
	--test-- "ep10"		--assert "(2,345,600.00%)" = sa/export-percent -23456.00
	
===end-group===

===start-group=== "import-float"
	
	--test-- "if1"		--assert 0.0 == sa/import-float ""
	--test-- "if2"		--assert 123.45 == sa/import-float "123.45"
	--test-- "if3"		--assert 123456.78 == sa/import-float "123,456.78"
	--test-- "if4"		--assert -123.45 == sa/import-float "-123.45"
	--test-- "if5"		--assert -123456.78 == sa/import-float "-123,456.78"
	--test-- "if6"		--assert 0.0 == sa/import-float none
	--test-- "if7"		--assert 0.0 == sa/import-float/default "" 0.0
	--test-- "if8"		--assert 1.0 == sa/import-float/default "" 1.0
	--test-- "if9"		--assert 0.0 == sa/import-float/default "abcd" 0.0
	--test-- "if10"		--assert 1.0 == sa/import-float/default "dcba" 1.0
	--test-- "if11"		--assert 0.0 == sa/import-float/default none 0.0
	--test-- "if12"		--assert 1.0 == sa/import-float/default none 1.0
	--test-- "if13"		--assert 1.0 == sa/import-float "1"
	--test-- "if14"		--assert 9535000000.00 == sa/import-float "9,535,000,000"
	--test-- "if15"		--assert -238000000.00 == sa/import-float "(238,000,000)"
	--test-- "if16"		--assert 1.0 == sa/import-float/default "" 1.0
	--test-- "if17"		--assert 1.0 = sa/import-float/default none 1.0
	
===end-group===


===start-group=== "calc-pe"

	--test-- "pe1"		
		--assert "-" == sa/calc-pe "" "" "" "" ""
	
	--test-- "pe2"		
		--assert "0.00" == sa/calc-pe "1.0" "1.0" "0.0" "1.0" "1.0"
	
	--test-- "pe3"
		--assert "1.00" == sa/calc-pe "1.0" "1.0" "1.0" "1.0" "1.0"
		
	--test-- "pe4"
		--assert "2.00" == sa/calc-pe "1.0" "1.0" "2.00" "1.0" "1.0"
	
	--test-- "pe5"
		--assert "10.00" == sa/calc-pe "1.0" "12345" "123450" "1.0" "1.0"
		
	--test-- "pe6"
		--assert "5.00" == sa/calc-pe "2.0" "12345" "123450" "4.0" "1.0"
	
	--test-- "pe7"
		--assert "24.27" == sa/calc-pe "1.51" "9,535,000,000" "849,000,000" "1.51" "272.60"
		
	--test-- "pe8"
		--assert "-" == sa/calc-pe "1" "(238,000,000)" "2,335,041,736" "1" "1.73"

===end-group=== 

===start-group=== "yield"

	--test-- "y1"		--assert "10.00%" == sa/calc-yield "10" "1" "100" "1"
	--test-- "y2"		--assert "5.26%" == sa/calc-yield "0.04" "1" "0.76" "1"
	--test-- "y3"		--assert "5.35%" == sa/calc-yield "0.04" "1.52" "0.4921" "1"
	--test-- "y4"		--assert "2.89%" == sa/calc-yield "2.6" "1.51" "89.90" "1.51"
	--test-- "y5"		--assert "0.00%" == sa/calc-yield "0.00" "1" "1.513" "1"
	
===end-group===

===start-group=== "roe"

	--test-- "roe1"		
		--assert "24.54%" == sa/calc-roe "19,035,000" "55,923,000" "72,816,000"
										 "40,479,000" "10,690,000" "1.0"
		
	--test-- "roe2"
		--assert "(5.06%)" == sa/calc-roe	"(238,000,000)" "9,299,000,000"
											"1,443,000,000" "2,873,000,000"
											"3,164,000,000" "1.0"										
	--test-- "roe3"
		--assert "(0.01%)" == sa/calc-roe "(1)" "20,000" "0" "0" "0" "1"
		
	--test-- "roe4"
		--assert "(10.01%)" == sa/calc-roe "(2,001)" "20,000" "0" "0" "0" "1"

===end-group===

===start-group=== "div cover"

	--test-- "dc1"
		--assert "(1.06)" == sa/calc-div-cover "(238,000,000)" "2,335,041,736" "0.096" "1.00" "1.00"
		
	--test-- "dc2"
		--assert "(1.06)" == sa/calc-div-cover "(238,000,000)" "2,335,041,736" "0.096" "" ""

===end-group===

===start-group=== "int cover"
	
	--test-- "ic1"
		--assert "2.51" == sa/calc-int-cover "336,000,000" "134,000,000" "1.52" "1.52"
		
===end-group===

===start-group=== "debt to total assets"

	--test-- "dta1"
		--assert "13.70%" == sa/calc-debt-total-assets "65,195,000" "138,871,000" "23,691,000" "4,271,000" "1.0"
	
===end-group===		

===start-group=== "debt to market cap"

	--test-- "dmc1"
		--assert "54.42%" == sa/calc-debt-market-cap "13,295,000,000" "22,420,000,000" "4,865,000,000" "13.49" "1.0" "1.0"

===end-group===

===start-group=== "price to book"

	--test-- "pb1"
		--assert "0.86" == sa/calc-price-book "2,335,041,736" "1.73" "9,299,000,000" "1,430,000,000" "2,873,000,000" "3,164,000,000" "1.0" "1.0"

===end-group===

===start-group=== "price to tangible book"

	--test-- "pt1"
		--assert "0.95" == sa/calc-price-book/tangible "2,335,041,736" "1.73" "9,299,000,000" "1,430,000,000" "2,873,000,000" "3,164,000,000" "1.0" "1.0" "458,000,000"

===end-group===

===start-group=== "price to sales"
	
	--test-- "ps1"
		--assert "0.23" == sa/calc-price-sales "2,335,041,736" "1.73" "17,680,000,000" "1.0" "1.0"
		
===end-group===

===start-group=== "EV to EBITDA"
	
	--test-- "ee1"
		--assert "14.53" == sa/calc-ev-ebitda "2,706,193,000" "89.90" "37,561,000,000" "26,973,000,000" "27,570,000" "8,275,000,000" "16,702,000,000" "1.53" "1.52"
		
===end-group===

===start-group=== "free cash flow"
	
	--test-- "fcf1"
		--assert "1.37" == sa/calc-free-cash-dividend "118,300,000" "65,600,000" "85,062,847" "0.4515" "1.0" "1.0"
		
===end-group===



~~~end-file~~~


print ""