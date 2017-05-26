red []

unless value? 'qt-run-tests [do %../../../../Red/red/quick-test/quick-test.red]
do %share-analysis-core.red
do %share-analysis-view.red


~~~start-file~~~ "share analysis view test"

	cw: view/no-wait co-win	
===start-group=== "init company window"

	--test-- "icw1"
		company-name/text: "company"
		turnover/text: "1"
		op-profit/text: "1"
		net-interest/text: "1"
		pre-tax/text: "1"
		earnings/text: "1"
		ebitda/text: "1"
		fixed-assets/text: "1"
		intangibles/text: "1"
		current-assets/text: "1"
		current-liabilities/text: "1"
		long-term-liabilities/text: "1"
		inventory/text: "1"
		op-cash-flow/text: "1"
		capex/text: "1"
		shares-in-issue/text: "1"
		dividend/text: "1"
		fin-date/text: "21-Mar-2016"
		fin-curr/text: "USD"
		div-curr/text: "CHF"
		share-curr/text: "GBP"
		fin-ex-rate/text: "1"
		div-ex-rate/text: "1"
		share-ex-rate/text: "1"
		share-price/text: "1"
		mkt-date/text: "22-Mar-2016"
		per/text: "150"
		yield/text: "3.9%"
		roe/text: "123.45"
		div-cover/text: "0.00"
		int-cover/text: "200"
		debt-total-assets/text: "11"
		debt-market-cap/text: "2"
		price-book/text: "2"
		price-tangible/text: "3"
		price-sales/text: "4"
		ev-ebitda/text: "4"
		free-cash-flow-dividend/text: "1.50"
		init-company-window
		--assert company-name/text == ""
		--assert turnover/text == "0"
		--assert op-profit/text == "0"
		--assert net-interest/text == "0"
		--assert pre-tax/text == "0"
		--assert earnings/text == "0"
		--assert ebitda/text == "0"
		--assert fixed-assets/text == "0"
		--assert intangibles/text == "0"
		--assert current-assets/text == "0"
		--assert current-liabilities/text == "0"
		--assert long-term-liabilities/text == "0"
		--assert inventory/text == "0"
		--assert op-cash-flow/text == "0"
		--assert capex/text == "0"
		--assert shares-in-issue/text == "0"
		--assert dividend/text == "0"
		--assert fin-date/text == ""
		--assert fin-curr/text == ""
		--assert div-curr/text == ""
		--assert share-curr/text == ""
		--assert fin-ex-rate/text == "1"
		--assert div-ex-rate/text == "1"
		--assert share-ex-rate/text == "1"
		--assert share-price/text == "0"
		--assert mkt-date/text == ""
		--assert per/text == ""
		--assert yield/text == ""
		--assert roe/text == ""
		--assert div-cover/text == ""
		--assert int-cover/text == ""
		--assert debt-total-assets/text == ""
		--assert debt-market-cap/text == ""
		--assert price-book/text == ""
		--assert price-tangible/text == ""
		--assert price-sales/text == ""
		--assert ev-ebitda/text == ""
		--assert free-cash-flow-dividend/text == ""
		
===end-group===

===start-group=== "price earnings ratio"
	
	--test-- "per1"
		init-company-window
		earnings/text: "1"
		shares-in-issue/text: "1"
		fin-ex-rate/text: "1"
		share-ex-rate/text: "1"
		share-price/text: "1"
		--assert "1.00" == per/text 
		
	--test-- "per2"
		init-company-window
		earnings/text: "9,535,000,000"
		shares-in-issue/text: "849,000,000"
		fin-ex-rate/text: "1.51"
		share-ex-rate/text: "1.51"
		share-price/text: "272.60"
		--assert "24.27" == per/text
			
	--test-- "per3"
		init-company-window
		earnings/text: "19,035,000"
		shares-in-issue/text: "7,200,000"
		share-price/text: "21.56"
		--assert "8.16" == per/text
		
	--test-- "per4"
		init-company-window
		earnings/text: "(238,000,000)"
		shares-in-issue/text: "2,335,041,736"
		share-price/text: "1.73"
		--assert "-" == per/text
	
===end-group===

===start-group=== "yield"

	--test-- "y1"
		init-company-window
		dividend/text: "2.60"
		div-ex-rate/text: "1.51"
		share-ex-rate/text: "1.51"
		share-price/text: "89.90"
		--assert "2.89%" == yield/text
		
	--test-- "y2"
		init-company-window
		dividend/text: "0.04"
		div-ex-rate/text: "1.52"
		share-price/text: "0.4921"
		--assert "5.35%" == yield/text

	--test-- "y3"
		init-company-window
		dividend/text: "0.04"
		share-price/text: "0.76"
		--assert "5.26%" == yield/text
		
	--test-- "y4"
		init-company-window
		dividend/text: "0.00"
		share-price/text: "1.513"
		--assert "0.00%" == yield/text

===end-group===

===start-group=== "return on earnings"

	--test-- "roe1"
		init-company-window
		earnings/text: "19,035,000"
		fixed-assets/text: "55,923,000"
		current-assets/text: "72,816,000"
		current-liabilities/text:"40,479,000"
		long-term-liabilities/text: "10,690,000"
		--assert "24.54%" == roe/text
		
	--test-- "roe2"
		init-company-window
		earnings/text: "(238,000,000)"
		fixed-assets/text: "9,299,000,000"
		current-assets/text: "1,443,000,000"
		current-liabilities/text:"2,873,000,000"
		long-term-liabilities/text: "3,164,000,000"
		--assert "(5.06%)" == roe/text
		
	--test-- "roe3"
		init-company-window
		earnings/text: "10,727,000,000"
		fixed-assets/text: "87,826,000,000"
		current-assets/text: "37,561,000,000"
		current-liabilities/text:"26,973,000,000"
		long-term-liabilities/text: "27,570,000"
		fin-ex-rate/text: "1.52"
		--assert "10.90%" == roe/text

===end-group===

===start-group=== "dividend cover"

	--test-- "dc1"
		init-company-window
		earnings/text: "(238,000,000)"
		shares-in-issue/text: "2,335,041,736"
		dividend/text: "0.096"
		fin-ex-rate/text: ""
		div-ex-rate/text: ""
		--assert "(1.06)" = div-cover/text
		
	--test-- "dc2"
		init-company-window
		earnings/text: "10,727,000,000"
		shares-in-issue/text: "2,706,193,000"
		dividend/text: "2.60"
		fin-ex-rate/text: "1.52"
		div-ex-rate/text: "1.51"
		--assert "1.51" = div-cover/text
		
	--test-- "dc3"
		init-company-window
		earnings/text: "10,727,000,000"
		shares-in-issue/text: "2,706,193,000"
		dividend/text: "2.60"
		fin-ex-rate/text: "1.52"
		div-ex-rate/text: "1.51"
		--assert "1.51" = div-cover/text
		
===end-group===

===start-group=== "net to total debt"

	--test-- "nta1"
		init-company-window
		fixed-assets/text: "65,195,000"
		current-assets/text: "138,871,000"
		current-liabilities/text: "23,691,000"
		long-term-liabilities/text: "4,271,000"
		fin-ex-rate/text: "1.0"
		--assert "13.70%" == debt-total-assets/text	
		
	--test-- "nta2"
		init-company-window
		fixed-assets/text: "87,826,000,000"
		current-assets/text: "37,561,000,000"
		current-liabilities/text: "26,973,000,000"
		long-term-liabilities/text: "27,570,000"
		fin-ex-rate/text: "1.52"
		--assert "21.53%" == debt-total-assets/text	

	--test-- "nta3"
		init-company-window
		fixed-assets/text: "25,973,000,000"
		current-assets/text: "14,678,000,000"
		current-liabilities/text: "13,295,000,000"
		long-term-liabilities/text: "22,420,000,000"
		fin-ex-rate/text: "1.00"
		--assert "87.86%" == debt-total-assets/text	

===end-group===

===start-group=== "net to market cap"

	--test-- "nmc1"
		init-company-window
		current-liabilities/text: "13,295,000,000"
		long-term-liabilities/text: "22,420,000,000"
		shares-in-issue/text: "4,865,000,000"
		share-price/text: "13.49"
		fin-ex-rate/text: "1.0"
		share-ex-rate/text: "1.0"
		--assert "54.42%" == debt-market-cap/text
		
	--test-- "nmc2"
		init-company-window
		current-liabilities/text: "2,873,000,000"
		long-term-liabilities/text: "3,164,000,000"
		shares-in-issue/text: "2,335,041,736"
		share-price/text: "1.73"
		fin-ex-rate/text: "1.0"
		share-ex-rate/text: "1.0"
		--assert "149.44%" == debt-market-cap/text
		
	--test-- "nmc3"
		init-company-window
		current-liabilities/text: "26,973,000,000"
		long-term-liabilities/text: "27,570,000"
		shares-in-issue/text: "2,706,193,000"
		share-price/text: "89.90"
		fin-ex-rate/text: "1.52"
		share-ex-rate/text: "1.51"
		--assert "11.03%" == debt-market-cap/text

===end-group===

===start-group=== "price to book"

	--test-- "pb1"
		init-company-window
		shares-in-issue/text: "2,335,041,736" 
		share-price/text: "1.73"
		fixed-assets/text: "9,299,000,000"
		current-assets/text: "1,430,000,000"
		current-liabilities/text: "2,873,000,000"
		long-term-liabilities/text: "3,164,000,000"
		fin-ex-rate/text: "1.0"
		share-ex-rate/text: "1.0"
		--assert "0.86" == price-book/text

===end-group===

===start-group=== "price to tangible book"

	--test-- "pt1"
		init-company-window
		shares-in-issue/text: "2,335,041,736"
		share-price/text: "1.73"
		fixed-assets/text: "9,299,000,000"
		current-assets/text: "1,430,000,000"
		current-liabilities/text: "2,873,000,000"
		long-term-liabilities/text: "3,164,000,000"
		fin-ex-rate/text: "1.0"
		share-ex-rate/text: "1.0"
		intangibles/text: "458,000,000"
		--assert "0.95" == price-tangible/text

===end-group===

===start-group=== "price to sales"
	
	--test-- "ps1"
		init-company-window
		shares-in-issue/text: "2,335,041,736"
		share-price/text: "1.73"
		turnover/text: "17,680,000,000"
		fin-ex-rate/text: "1.0"
		share-ex-rate/text: "1.0"
		--assert "0.23" == price-sales/text 
		
===end-group===

===start-group=== "EV to EBITDA"
	
	--test-- "ee1"
		init-company-window
		shares-in-issue/text: "2,706,193,000"
		share-price/text: "89.90"
		current-assets/text: "37,561,000,000"
		current-liabilities/text: "26,973,000,000"
		long-term-liabilities/text: "27,570,000"
		inventory/text: "8,275,000,000"
		ebitda/text: "16,702,000,000"
		fin-ex-rate/text: "1.53"
		share-ex-rate/text: "1.52"
		--assert "14.53" == ev-ebitda/text 
		
	--test-- "ee2"
		init-company-window
		shares-in-issue/text: "85,062,847"
		share-price/text: "14.10"
		current-assets/text: "171,500,000"
		current-liabilities/text: "37,300,000"
		long-term-liabilities/text: "25,600,000"
		inventory/text: "44,200,000"
		ebitda/text: "112,200,000"
		fin-ex-rate/text: "1.00"
		share-ex-rate/text: "1.00"
		--assert "10.12" == ev-ebitda/text 
		
===end-group===

===start-group=== "free cash flow"
	
	--test-- "fcf1"
		init-company-window
		op-cash-flow/text: "118,300,000"
		capex/text: "65,600,000"
		shares-in-issue/text: "85,062,847"
		dividend/text: "0.4515"
		fin-ex-rate/text: "1.0"
		div-ex-rate/text: "1.0"
		
		--assert "1.37" == free-cash-flow-dividend/text 
		
	--test-- "fcf2"
		init-company-window
		op-cash-flow/text: "722,000,000"
		capex/text: "1,052,000,000"
		shares-in-issue/text: "2,335,041,736"
		dividend/text: "0.096"
		--assert "(1.47)" == free-cash-flow-dividend/text
		
===end-group===

===start-group=== "all calcs"
	
	--test-- "all1"
		company-name/text: "Novartis"
		turnover/text: "52,419,000,000"
		op-profit/text: "12,976,000,000"
		net-interest/text: "704,000,000"
		pre-tax/text: "12,272,000,000"
		earnings/text: "10,727,000,000"
		ebitda/text: "16,702,000,000"
		fixed-assets/text: "87,826,000,000"
		intangibles/text: "53,143,000,000"
		current-assets/text: "37,561,000,000"
		current-liabilities/text: "26,973,000,000"
		long-term-liabilities/text: "27,570,000"
		inventory/text: "8,275,000,000"
		op-cash-flow/text: "13,897,000,000"
		capex/text: "2,847,000,000"
		shares-in-issue/text: "2,706,193,000"
		dividend/text: "2.6"
		fin-date/text: "31-Dec-2014"
		fin-curr/text: "USD"
		div-curr/text: "CHF"
		share-curr/text: "CHF"
		fin-ex-rate/text: "1.52"
		div-ex-rate/text: "1.51"
		share-ex-rate/text: "1.51"
		share-price/text: "89.90"
		mkt-date/text: "6-Nov-2015"
		--assert company-name/text == "Novartis"
		--assert fin-date/text == "31-Dec-2014"
		--assert mkt-date/text == "6-Nov-2015"
		--assert per/text == "22.83"
		--assert yield/text == "2.89%"
		--assert roe/text == "10.90%"
		--assert div-cover/text == "1.51"
		--assert int-cover/text == "18.43"
		--assert debt-total-assets/text == "21.53%"
		--assert debt-market-cap/text == "11.03%"
		--assert price-book/text == "2.49"
		--assert price-tangible/text == "5.41"
		--assert price-sales/text == "4.67"
		--assert ev-ebitda/text == "14.53"
		--assert free-cash-flow-dividend/text == "1.56"

===end-group===

~~~end-file~~~

unview
print ""