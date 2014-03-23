Red/System [
	Purpose:     "Duration Structure Definition"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-DT-duration!: alias struct! [
	days				[integer!]
	hours				[integer!]
	minutes				[integer!]
	seconds				[integer!]
	microseconds		[integer!]
]

#define PWAW-DT-ZERO-DURATION(dur) [
	dur/days:			0
	dur/hours: 			0
	dur/minutes:		0
	dur/seconds:		0
	dur/microseconds:	0
]
