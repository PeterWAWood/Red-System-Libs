Red/System [
	Purpose:     "Compares two date time structures"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2014 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-DT-UTC.reds

PWAW-DT-equal?: func [
	d1					[PWAW-DT-date!]
	d2					[PWAW-DT-date!]
	return:				[logic!]
	/local
	utc-d1				[PWAW-DT-date!]
	utc-d2				[PWAW-DT-date!]
	
][
	utc-d1: declare PWAW-DT-date!
	utc-d2: declare PWAW-DT-date!
	if 0 <> PWAW-DT-UTC d1 utc-d1 [return false]
	if 0 <> PWAW-DT-UTC d2 utc-d2 [return false]

	either all [
		utc-d1/year = utc-d2/year
		utc-d1/month = utc-d2/month
		utc-d1/day = utc-d2/day
		utc-d1/hour = utc-d2/hour
		utc-d1/minutes = utc-d2/minutes
		utc-d1/seconds = utc-d2/seconds
		utc-d1/microseconds = utc-d2/microseconds
		
	][
		true	
	][
		false
	]

]
