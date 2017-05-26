Red [
	Title:   	"Share Analysis"
	Author: 	 "Peter W A Wood"
	File: 	 	%share-analysis-core.red
	Purpose:	"share analysis calculations"
	Tabs:	 	4
	Rights:  	"Copyright (C) 2016 Peter W A Wood. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

sa: make object! [
	
	calc-debt-market-cap: func [
		current-liabilities
		long-term-liabilities
		shares-in-issue
		share-price
		fin-ex-rate
		share-ex-rate
		/local debt cap ffx sfx
	][
		ffx:	import-float/default fin-ex-rate 1.0
		sfx:	import-float/default share-ex-rate 1.0
		debt:	add import-float current-liabilities 
				import-float long-term-liabilities
		cap:	multiply import-float shares-in-issue 
				import-float share-price
				
		export-percent ratio debt ffx cap sfx
	]
	
	calc-debt-total-assets: func [
		fixed-assets
		current-assets
		current-liabilities
		long-term-liabilities
		fin-ex-rate
		/local debt assets fx
	][
		fx:		import-float/default fin-ex-rate 1.0
		debt:	add import-float current-liabilities 
				import-float long-term-liabilities
		assets:	add import-float fixed-assets 
				import-float current-assets
				
		export-percent ratio debt fx assets fx
	]
	
	calc-div-cover: func [
		earnings
		shares-in-issue
		dividend
		fin-ex-rate
		div-ex-rate
		/local eps
	][
		eps: ratio 	import-float earnings
					import-float/default fin-ex-rate 1.0 
					import-float shares-in-issue
					1.0
		export-float ratio	eps
							1.0 
							import-float dividend 
							import-float/default div-ex-rate 1.0
	]
	
	calc-ev-ebitda: func [
		shares-in-issue
		share-price
		current-assets
		current-liabilities
		long-term-liabilities
		inventory
		ebitda
		fin-ex-rate
		share-ex-rate
		/local cap ca cl ltl inv na ev ffx
	][
		cap: multiply 	import-float shares-in-issue
						import-float share-price
		cap: sa/div cap import-float/default share-ex-rate 1.0
		ca: import-float current-assets
		cl: import-float current-liabilities
		ltl: import-float long-term-liabilities
		inv: import-float inventory
		ffx: import-float/default fin-ex-rate 1.0
		na: cl + ltl + inv - ca
		na: sa/div na ffx
		ev: cap + na
		export-float ratio	ev 1.0
							import-float ebitda ffx
	]
	
	calc-free-cash-dividend: func [
		op-cash-flow
		capex
		shares-in-issues
		dividend
		fin-ex-rate
		div-ex-rate
		/local div fcf
	][
		tdiv: multiply	import-float shares-in-issues 
						import-float dividend
		fcf: subtract	import-float op-cash-flow
						import-float capex
		export-float ratio	fcf import-float/default fin-ex-rate 1.0
							tdiv import-float/default div-ex-rate 1.0
	]
	
	calc-int-cover: func [
		op-profit
		net-interest
		fin-ex-rate
	][
		export-float ratio	import-float op-profit
							import-float/default fin-ex-rate 1.0
							import-float net-interest
							import-float/default fin-ex-rate 1.0
	]
	
	calc-pe: func [
		fin-ex-rate
		earnings
		shares-in-issue
		share-ex-rate
		share-price
		/local eps pe
	][
		eps: ratio 	import-float earnings 
					import-float/default fin-ex-rate 1.0 
					import-float shares-in-issue 
					1.0
		pe: ratio 	import-float share-price
					import-float/default share-ex-rate 1.0
					eps
					1.0
		either pe < 0 ["-"][export-float pe]
	]
	
	calc-price-book: func [
		shares-in-issue
		share-price
		fixed-assets
		current-assets
		current-liabilities
		long-term-liabilities
		fin-ex-rate
		share-ex-rate
		/tangible
			intangibles
		/local fa ca cl ltl na cap
	][
		fa: import-float fixed-assets
		ca: import-float current-assets
		cl: import-float current-liabilities
		ltl: import-float long-term-liabilities
		na: fa + ca - cl - ltl
		if tangible [
			na: na - import-float intangibles
		]
		cap: multiply	import-float shares-in-issue
						import-float share-price
		export-float ratio	cap import-float/default share-ex-rate 1.0
							na import-float/default fin-ex-rate 1.0
	]
	
	calc-price-sales: func [
		shares-in-issue
		share-price
		turnover
		fin-ex-rate
		share-ex-rate
		/local
			cap
	][
		
		cap: multiply	import-float shares-in-issue
						import-float share-price
		export-float ratio	cap import-float/default share-ex-rate 1.0
							import-float turnover import-float/default fin-ex-rate 1.0
	]
	
	calc-price-tangible: func [
		"Needed to overcome issue calling function with refinement in react block"
		shares-in-issue
		share-price
		fixed-assets
		current-assets
		current-liabilities
		long-term-liabilities
		fin-ex-rate
		share-ex-rate
		intangibles
	][
		calc-price-book/tangible	shares-in-issue
									share-price
									fixed-assets
									current-assets
									current-liabilities
									long-term-liabilities
									fin-ex-rate
									share-ex-rate
									intangibles
	]
	
	calc-roe: func [
		earnings
		fixed-assets
		current-assets
		current-liabilities
		long-term-liabilities
		fin-ex-rate
		/local fa ca cl ltl na 
	][
		ea: import-float earnings
		fa: import-float fixed-assets
		ca: import-float current-assets
		cl: import-float current-liabilities
		ltl: import-float long-term-liabilities
		na: fa + ca - cl - ltl
		export-percent ratio	import-float earnings
								import-float/default fin-ex-rate 1.0
								na 
								import-float/default fin-ex-rate 1.0
	]
	
	calc-yield: func [
		dividend
		div-ex-rate
		share-price
		share-ex-rate
		/local y 
	][
		y: ratio 	import-float dividend 
					import-float/default div-ex-rate 1.0
					import-float share-price
					import-float/default share-ex-rate 1.0
		either all [
			natural? y
			y >= 0.00
		][
			export-percent y
		][
			"-"
		]
	]
	
	div: func [
		dividend			[float!]
		divisor				[float!]
	][
		either divisor <> 0 [
			dividend / divisor
		][
			1.#INF * dividend
		]
	]
	
	export-float: func [
		f					[float!]
		/local r round 
	][
		either natural? f [
			round: either f < 0 [-0.005] [0.005]
			r: form f + round
			r: copy/part r 2 + index? find r #"."
			if #"-" = first r [r: next r]
			r: next r
			while [5 < length? r] [
				if 0 = ((length? r) % 3) [
					insert r #","
					r: next r
				]
				r: next r
			]
			r: head r
			if f < 0 [
				r/1: #"("
				append r #")"
			]
			r
		][
			case [
				f == 1.#INF		["∞"]
				f == -1.#INF	["-∞"]
				true			["-"]
			]
 		]
	]
	
	export-percent: func [
		f					[float!]
		/local p
	][
		either natural? f [
			p: export-float f * 100
			either f >= 0 [
				append p #"%"
			][
				head insert back tail p #"%"
			]
		][
			"-"
		]
	]
	
	import-float: func [
		sn					[string! none! float!]
		/default
			def				[float!]
		/local n c
	][
		if float! = type? sn [return sn]
		unless string! = type? sn [
			return either default [def] [0.0]
		]
		n: make string! 100
		clear n
		foreach  c sn [unless c = #"," [append n c]]
		if all [
			#"(" = first n
			#")" = last n
		][
			n/1: #"-"
			n: head remove back tail n
		]
		if all [
			none = find n "." 
			"" <> n
		][
			append n ".00"
		]
		
		either float! <> attempt [type? load n] [
			either default [def] [0.0]
		][
			load n
		]
	]
				
	natural?: func [n [float!]] [
		 not any [
			NaN? n
			n = 1.#INF
			n = -1.#INF
		]
	]
	
	ratio: func [
		"calculates a simple ratio in the base currency"
		a				[float!]
		a-rate			[float!]
		b				[float!]
		b-rate			[float!]	
		/local abc bbc
	][
		abc: div a a-rate
		bbc: div b b-rate
		div abc bbc
	]
		
]
		