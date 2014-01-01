Red/System [
	Purpose:     "Returns a year as a number of days since 0/1/1"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-DT-year-as-days: func [
	{
		Returns a year as a number of days since 0/1/1
	} 
	y					[integer!]				{a year}	
	days				[pointer! [integer!]]	{number of days}
	return:				[integer!]				{returns:
	
		0  - Success
		1  - Year must not be negative
	}
][
	if y < 0 [
		return 1	
	]
	
	days/value: (y * 365) + (y / 4) - (y / 100) + (y / 1000)
	0
]

