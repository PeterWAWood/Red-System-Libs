Red/System [
	Purpose:     "Function to load a date from a string"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011-2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-date.def

PWAW-DT-load-date: func [
	{Loads the supplied date structure from a string}
	s					[c-string!]        {"dd-mmm-yyyy/hh:mm:ss+hh:mm"}
	d					[PWAW-DT-date!]    {an initialised PWAW-DT-date! struct 
                        	                in which the date value will be 
                        	                placed}
	return:				[integer!]         {

		0 - successful
		1 - invalid day
		2 - invalid month
		3 - invalid year
		4 - invalid hour
		5 - invalid minutes
		6 - invalid seconds
		7 - invalid time zone
		8 - non-existant date
	}
   
	/local
		b			[byte-ptr!]
		mth			[c-string!]
		i			[integer!]
		ss			[c-string!]
][
 
	mth: "   "
	i: 0
	b: allocate 5
	ss: as c-string! b

	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 1 2 ss
		0 <> PWAW-DT-store-int ss :i
		i < 1                          
		i > 31
	][
		return 1
	]
	d/day: i
	
	mth/1: s/4
	mth/2: s/5
	mth/3: s/6
	case [    
		any [
			PWAW-C-str-equal? mth "Jan"
			PWAW-C-str-equal? mth "jan"
		][
			d/month: 1
		]
		any [
			PWAW-C-str-equal? mth "Feb"
			PWAW-C-str-equal? mth "feb"
		][
			d/month: 2
		]
		any [
			PWAW-C-str-equal? mth "Mar"
			PWAW-C-str-equal? mth "mar"
		][
			d/month: 3
		]
		any [
			PWAW-C-str-equal? mth "Apr"
			PWAW-C-str-equal? mth "apr"
		][
			d/month: 4
		]
		any [
			PWAW-C-str-equal? mth "May"
			PWAW-C-str-equal? mth "may"
		][
			d/month: 5
		]
		any [
			PWAW-C-str-equal? mth "Jun"
			PWAW-C-str-equal? mth "jun"
		][
			d/month: 6
		]
		any [
			PWAW-C-str-equal? mth "Jul"
			PWAW-C-str-equal? mth "jul"
		][
			d/month: 7
		]
		any [
			PWAW-C-str-equal? mth "Aug"
			PWAW-C-str-equal? mth "aug"
		][
			d/month: 8
		]
		any [
			PWAW-C-str-equal? mth "Sep"
			PWAW-C-str-equal? mth "sep"
		][
			d/month: 9
		]
		any [
			PWAW-C-str-equal? mth "Oct"
			PWAW-C-str-equal? mth "oct"
		][
			d/month: 10
		]
		any [
			PWAW-C-str-equal? mth "Nov"
			PWAW-C-str-equal? mth "nov"
		][
			d/month: 11
		]
		any [
			PWAW-C-str-equal? mth "Dec"
			PWAW-C-str-equal? mth "dec"
		][
			d/month: 12
		]
		true [return 2]
	]
	
	;; check correct number of days in month
	switch d/month [
		2 [
			if d/day > 29 [return 8]
		]
		4 6 9 11 [
			if d/day > 30 [return 8]
		]
		default [
			true
		]
	]
	
	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 8 4 ss
		0 <> PWAW-DT-store-int ss :i
		i < 0
	][	
		
		return 3
	]
	d/year: i
	
	;; leap year checking
	if d/month = 2 [
		if any [
			0 <> (d/year % 4)
			all [
				0 =  (d/year % 100)
				0 <> (d/year % 1000)
			]
		][
			if d/day > 28 [return 8]
		]
	]
	  
	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 13 2 ss
		0 <> PWAW-DT-store-int ss :i
		i > 23
		i < 0
	][
		return 4
	]
	d/hour: i
	
	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 16 2 ss
		0 <> PWAW-DT-store-int ss :i
		i > 59
		i < 0
	][
		return 5
	]
	d/minutes: i
	
	ss: "    "
	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 19 2 ss
		0 <> PWAW-DT-store-int ss :i
		i > 59
		i < 0
	][
		return 6
	]
	d/seconds: i
	  
	ss: "    "
	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 21 3 ss
		0 <> PWAW-DT-store-int ss :i
		i > 18
		i < -15
	][
		return 7
	]
	d/tz-hours: i
	
	ss: "    "
	if any [
		0 <> PWAW-C-str-init ss 4 #" "
		0 <> PWAW-C-substr s 25 2 ss
		0 <> PWAW-DT-store-int ss :i
		all [
			i <> 0
			i <> 15
			i <> 30
			i <> 45
		]
	][
		return 7
	]
	d/tz-minutes: i
	
	free b
	0
]
