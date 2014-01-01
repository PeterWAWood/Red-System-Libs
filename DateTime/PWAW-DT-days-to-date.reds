Red/System [
	Purpose:     "A days to date conversion function "
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]


#include %PWAW-DT-date.def
#include %PWAW-DT-leapyear.reds

PWAW-DT-days-to-date: func [
	{
		Converts a number of days since 31/12/1 BC (i.e.1 = 1/1/1) to a date)
	}
	days				[integer!]				{number of days}
	d					[PWAW-DT-Date!]			{a date to be converted}	
	return:				[integer!]				{returns:
	
		0  - Success
		1  - internal error in days-to-date
	}
	/local
		rem				[integer!]
		year			[integer!]
	
][
	year: (days / 365)
	rem: days % 365
	rem: rem - (year / 4) + (year / 100) - (year / 1000)
	if rem < 0 [
		until [
			either PWAW-DT-leapyear? year [
				rem: rem + 366
			][
				rem: rem + 365
			]
			year: year - 1
			rem > -1	
		]
	]	
	d/year: year + 1                    ;; year is the number of completed years
										;; hence add one to get current year
	case [
		rem = 0 [
			d/year: d/year - 1
			d/month: 12
			d/day: 31
		]
		rem < 60 [
			either rem < 32 [
				d/month: 1 
				d/day: rem
			][
				d/month: 2
				d/day: rem - 31
			]
		]
		all [
			rem = 60
			PWAW-DT-leapyear? d/year
		][
			d/month: 2
			d/day: 29
		]
		rem > 59 [
			if PWAW-DT-leapyear? d/year [rem: rem - 1]
			case [
				rem < 91 [
					d/month: 3
					d/day: rem - 59
				]
				rem < 121 [
					d/month: 4
					d/day: rem - 90
				]
				rem < 152 [
					d/month: 5
					d/day: rem - 120
				]
				rem < 182 [
					d/month: 6
					d/day: rem - 151
				]
				rem < 213 [
					d/month: 7
					d/day: rem - 181
				]
				rem < 244 [
					d/month: 8
					d/day: rem - 212
				]
				rem < 274 [
					d/month: 9
					d/day: rem - 243
				]
				rem < 305 [
					d/month: 10
					d/day: rem - 273
				]
				rem < 335 [
					d/month: 11
					d/day: rem - 304
				]
				rem < 366 [
					d/month: 12
					d/day: rem - 334
				]
				true [
					return 1
				]
			]
		]
	]
	
	0
]

