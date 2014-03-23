Red/System [
	Purpose:     "Checks a date & time is later than another"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2014 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-DT-date-def.reds
#include %PWAW-DT-UTC.reds

PWAW-DT-later?: func [
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

	if utc-d1/year > utc-d2/year [return true]
	if utc-d1/year < utc-d2/year [return false]
	if utc-d1/month > utc-d2/month [return true]
	if utc-d1/month < utc-d2/month [return false]
	if utc-d1/day > utc-d2/day [return true]
	if utc-d1/day < utc-d2/day [return false]
	if utc-d1/hour > utc-d2/hour [return true]
	if utc-d1/hour < utc-d2/hour [return false]
	if utc-d1/minutes > utc-d2/minutes [return true]
	if utc-d1/minutes < utc-d2/minutes [return false]
	if utc-d1/seconds > utc-d2/seconds [return true]
	if utc-d1/seconds < utc-d2/seconds [return false]
	either utc-d1/microseconds > utc-d2/microseconds [
		true	
	][
		false
	]

]
