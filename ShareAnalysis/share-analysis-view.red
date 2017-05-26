Red [
	Title:		"Share Analysis"
	Author:  	"Peter W A Wood"
	File: 	 	%share-analysis-view.red
	Purpose:	"A simple company analysis calculator layout" 	
	Tabs:	 4
	
	Rights:  "Copyright (C) 2016 Peter W A Wood. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
	Needs: 'View
]

init-company-window: does [
	company-name/text: ""
	turnover/text: "0"
	op-profit/text: "0"
	net-interest/text: "0"
	pre-tax/text: "0"
	earnings/text: "0"
	ebitda/text: "0"
	fixed-assets/text: "0"
	intangibles/text: "0"
	current-assets/text: "0"
	current-liabilities/text: "0"
	long-term-liabilities/text: "0"
	inventory/text: "0"
	op-cash-flow/text: "0"
	capex/text: "0"
	shares-in-issue/text: "0"
	dividend/text: "0"
	fin-date/text: ""
	fin-curr/text: ""
	div-curr/text: ""
	share-curr/text: ""
	fin-ex-rate/text: "1"
	div-ex-rate/text: "1"
	share-ex-rate/text: "1"
	share-price/text: "0"
	mkt-date/text: ""
	per/text: ""
	yield/text: ""
	roe/text: ""
	div-cover/text: ""
	int-cover/text: ""
	debt-total-assets/text: ""
	debt-market-cap/text: ""
	price-book/text: ""
	price-tangible/text: ""
	price-sales/text: ""
	ev-ebitda/text: ""
	free-cash-flow-dividend/text: ""
]

move-focus: func [
	evt				[event!]
	next-face		[object!]
	prior-face		[object!]
][
	if evt/key = tab [
		co-win/selected: either evt/shift? [prior-face][next-face]
	]
]
						
co-win: layout [
	title "Share Analysis"
	size 1150x675
	style normal: text font-name "helvetica" font-size 11 
	style heading: normal font-size 14
	style entry: field font-name "helvetica" font-size 11 
	style text-entry: entry ""
	style date-entry: entry 160 ""
	style num-entry: entry 200 "0"
	style calculated: text "" 160 font-name "helvetica" font-size 11
	heading "Company:"
	company-name: text-entry 500 font-size 14 
		on-enter [co-win/selected: turnover]
		on-key [move-focus event turnover mkt-date]
	do [self/selected: company-name]
	text 400 ""
	button "clear data" font-name "helvetica" font-size 12 
		[
			init-company-window
			co-win/selected: company-name
		]
	return
	group-box 2 [
		heading "Financial Data       "
		heading "" 
		normal "Turnover:" 
		turnover: num-entry
			on-enter [co-win/selected: op-profit]
			on-key [move-focus event op-profit company-name]
		normal "Operating Profit:" 
		op-profit: num-entry
			on-enter [co-win/selected: net-interest]
			on-key [move-focus event net-interest turnover]
		normal "Net Interest:"
		net-interest: num-entry
			on-enter [co-win/selected: pre-tax]
			on-key [move-focus event pre-tax op-profit]
		normal "Pre-Tax Profit:"
		pre-tax: num-entry
			on-enter [co-win/selected: earnings]
			on-key [move-focus event earnings net-interest]
		normal "Earnings:"
		earnings: num-entry
			on-enter [co-win/selected: ebitda]
			on-key [move-focus event ebitda pre-tax]
		normal "EBITDA:"
		ebitda: num-entry
			on-enter [co-win/selected: fixed-assets]
			on-key [move-focus event fixed-assets earnings]
		normal "Fixed Assets:"
		fixed-assets: num-entry
			on-enter [co-win/selected: intangibles]
			on-key [move-focus event intangibles ebitda]
		normal "Intangibles:" 
		intangibles: num-entry
			on-enter [co-win/selected: current-assets]
			on-key [move-focus event current-assets fixed-assets]
		normal "Current Assets:"
		current-assets: num-entry
			on-enter [co-win/selected: current-liabilities]
			on-key [move-focus event current-liabilities intangibles]
		normal "Current Liabilities:"
		current-liabilities: num-entry
			on-enter [co-win/selected: long-term-liabilities]
			on-key [move-focus event long-term-liabilities current-assets]
		normal "Long Term Liabilities:"
		long-term-liabilities: num-entry
			on-enter [co-win/selected: inventory]
			on-key [move-focus event inventory current-liabilities]
		normal "Inventory:"
		inventory: num-entry
			on-enter [co-win/selected: op-cash-flow]
			on-key [move-focus event op-cash-flow long-term-liabilities]
		normal "Operational Cash Flow:"
		op-cash-flow: num-entry
			on-enter [co-win/selected: capex]
			on-key [move-focus event capex inventory]
		normal "Capital Expenditure:"
		capex: num-entry
			on-enter [co-win/selected: shares-in-issue]
			on-key [move-focus event shares-in-issue op-cash-flow]
		normal "Shares in Issue:"
		shares-in-issue: num-entry
			on-enter [co-win/selected: dividend]
			on-key [move-focus event dividend capex]
		normal "Dividend per Share:"
		dividend: num-entry
			on-enter [co-win/selected: fin-date]
			on-key [move-focus event fin-date shares-in-issue]
		normal "Date of Financials:"
		fin-date: date-entry 
			on-enter [co-win/selected: fin-curr]
			on-key [move-focus event fin-curr dividend]
	]
	group-box 2 [
		heading "Market Data           "
		heading ""
		normal "Financial Currency:" 
		fin-curr: text-entry
			on-enter [co-win/selected: div-curr]
			on-key [move-focus event div-curr fin-date]
		normal "Dividend Currency:" 
		div-curr: text-entry
			on-enter [co-win/selected: share-curr]
			on-key [move-focus event share-curr fin-curr]
		normal "Share Currency:" 
		share-curr: text-entry
			on-enter [co-win/selected: fin-ex-rate]
			on-key [move-focus event fin-ex-rate div-curr]
		normal "Financial Exchange Rate:" 
		fin-ex-rate: num-entry "1" 
			on-enter [co-win/selected: div-ex-rate]
			on-key [move-focus event div-ex-rate share-curr]
		normal "Dividend Exchange Rate:" 
		div-ex-rate: num-entry "1"
			on-enter [co-win/selected: share-ex-rate]
			on-key [move-focus event share-ex-rate fin-ex-rate]
		normal "Share Exchange Rate:" 
		share-ex-rate: num-entry "1"
			on-enter [co-win/selected: share-price]
			on-key [move-focus event share-price div-ex-rate]
		normal "Share Price:"
		share-price: num-entry
			on-enter [co-win/selected: mkt-date]
			on-key [move-focus event mkt-date share-ex-rate]
		normal "Date of Market Data:"
		mkt-date: date-entry
			on-enter [co-win/selected: company-name]
			on-key [move-focus event company-name share-price]
	]
	group-box 2 [
		heading "Analysis              "
		heading ""
		normal "Price Earnings Ratio:" 
		per: calculated react [
			face/text: sa/calc-pe	fin-ex-rate/text 
									earnings/text
									shares-in-issue/text
									share-ex-rate/text
									share-price/text
		]
		normal "Dividend Yield:" 
		yield: calculated react [
			face/text: sa/calc-yield	dividend/text
										div-ex-rate/text
										share-price/text
										share-ex-rate/text
		]
		normal "Return on Equity:"
		roe: calculated react [
			face/text: sa/calc-roe	earnings/text
									fixed-assets/text
									current-assets/text
									current-liabilities/text
									long-term-liabilities/text
									fin-ex-rate/text
		]	
		normal "Dividend Cover:"
		div-cover: calculated react [
			face/text: sa/calc-div-cover	earnings/text
											shares-in-issue/text
											dividend/text
											fin-ex-rate/text
											div-ex-rate/text
		]
		normal "Interest Cover:"
		int-cover: calculated react [
			face/text: sa/calc-int-cover	op-profit/text
											net-interest/text
											fin-ex-rate/text
		]
		normal "Debt to Total Assets:"
		debt-total-assets: calculated react [
			face/text: sa/calc-debt-total-assets	fixed-assets/text
													current-assets/text
													current-liabilities/text
													long-term-liabilities/text
													fin-ex-rate/text
		]
		normal "Debt to Market Cap:"
		debt-market-cap: calculated react [
			face/text: sa/calc-debt-market-cap	current-liabilities/text
												long-term-liabilities/text
												shares-in-issue/text
												share-price/text
												fin-ex-rate/text
												share-ex-rate/text
		]
		normal "Price to Book:" 
		price-book: calculated react [
			face/text: sa/calc-price-book	shares-in-issue/text
											share-price/text
											fixed-assets/text
											current-assets/text
											current-liabilities/text
											long-term-liabilities/text
											fin-ex-rate/text
											share-ex-rate/text
		]
		normal "Price to Tangible Book:"
		price-tangible: calculated react [
			face/text: sa/calc-price-tangible	shares-in-issue/text
												share-price/text
												fixed-assets/text
												current-assets/text
												current-liabilities/text
												long-term-liabilities/text
												fin-ex-rate/text
												share-ex-rate/text
												intangibles/text
		]
		normal "Price to Sales:"
		price-sales: calculated react [
			face/text: sa/calc-price-sales	shares-in-issue/text
											share-price/text
											turnover/text
											fin-ex-rate/text
											share-ex-rate/text
		]
		normal "EV/EBITDA:"
		ev-ebitda: calculated react [
			face/text: sa/calc-ev-ebitda	shares-in-issue/text
											share-price/text
											current-assets/text
											current-liabilities/text
											long-term-liabilities/text
											inventory/text
											ebitda/text
											fin-ex-rate/text
											share-ex-rate/text
		]
		normal "Free Cash Flow:"
		free-cash-flow-dividend: calculated react [
			face/text: sa/calc-free-cash-dividend	op-cash-flow/text
													capex/text
													shares-in-issue/text
													dividend/text
													fin-ex-rate/text
													div-ex-rate/text
		]
	]
]