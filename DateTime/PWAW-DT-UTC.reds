Red/System [
	Purpose:     "Converts a date to UTC time"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]


#include %PWAW-DT-date-def.reds
#include %PWAW-DT-date-to-days.reds
#include %PWAW-DT-days-to-date.reds

PWAW-DT-UTC: func [
	{
		Converts a date to UTC time
	}
	d					[PWAW-DT-Date!]			{a date to be converted}
	u					[PWAW-DT-Date!]			{the date at UTC time}	
	return:				[integer!]				{returns:
	
		0  - Success
		1  - Cannot convert date to days
		2  - Cannot convert days to date

	}
	/local
		days			[integer!]
		tempdate		[PWAW-DT-Date!]
		carry-hour		[integer!]
][
	tempdate: declare PWAW-DT-Date!
	PWAW-DT-ZERO-DATE(tempdate)
	days: 0
	carry-hour: 0
	u/year: d/year
	u/month: d/month
	u/day: d/day
	u/seconds: d/seconds
	u/microseconds: d/microseconds
	u/tz-hours: 0
	u/tz-minutes: 0
	
	either d/tz-hours >= 0 [
		u/minutes: d/minutes - d/tz-minutes
		if u/minutes < 0 [
			carry-hour: 1
			u/minutes: u/minutes + 60
		]
		u/hour: d/hour - d/tz-hours	- carry-hour
		if u/hour < 0 [
			u/hour: u/hour + 24
			;; need to check round trip date-to-days and back!!!
			if 0 <> PWAW-DT-date-to-days u :days [return 1]

			days: days - 1
			
			if 0 <> PWAW-DT-days-to-date days tempdate [return 2]
			u/year: tempdate/year
			u/month: tempdate/month
			u/day: tempdate/day
		]
	][
		u/minutes: d/minutes + d/tz-minutes
		if u/minutes > 60 [
			u/minutes: u/minutes - 60
			carry-hour: 1
		]
		u/hour: d/hour - d/tz-hours	+ carry-hour		;; tz-hours is negative
		if u/hour > 24 [
			u/hour: u/hour - 24
			if 0 <> PWAW-DT-date-to-days u :days [return 1]
			days: days + 1
			if 0 <> PWAW-DT-days-to-date days tempdate [return 2]
			u/year: tempdate/year
			u/month: tempdate/month
			u/day: tempdate/month	
		]
	]
	
	0
]

