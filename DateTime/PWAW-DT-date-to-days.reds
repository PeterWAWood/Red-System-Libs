Red/System [
	Purpose:     "A date to days conversion function "
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]


#include %PWAW-DT-date.def
#include %PWAW-DT-days-in-year-todate.reds
#include %PWAW-DT-year-as-days.reds

PWAW-DT-date-to-days: func [
	{
		Converts a date to a number of days since 31/12/1 BC (effectively 31/12/0)
		The first acceptable date is 1/1/1
	} 
	d					[PWAW-DT-Date!]			{a date to be converted}	
	days				[pointer! [integer!]]	{number of days}
	return:				[integer!]				{returns:
	
		0  - Success
		1  - Year must be 1 or more
		2  - Error in year-as-days
		3  - Error in days-in-year-to-date
	}
	/local
		years-in-days 	[integer!]
		days-in-year	[integer!]
	
][
	days-in-year: 0
	years-in-days: 0
	
	if d/year < 1 [
		return 1	
	]
	
	if 0 <> PWAW-DT-year-as-days (d/year - 1) :years-in-days [
		return 2	
	]
	days-in-year: 0
	
	if 0 <> PWAW-DT-days-in-year-todate d :days-in-year [
		return 2
	]
	days-in-year: days-in-year + 1				;; include the end day	

	days/value: years-in-days + days-in-year
	0
]

