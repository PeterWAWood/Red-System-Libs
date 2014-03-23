Red/System [
	Purpose:     "Date Time Structure Definition"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-DT-date!: alias struct! [
	year				[integer!]
	month				[integer!]
	day					[integer!]
	hour				[integer!]
	minutes				[integer!]
	seconds				[integer!]
	microseconds		[integer!]
	tz-hours			[integer!]
	tz-minutes			[integer!]
]

#define PWAW-DT-ZERO-DATE(d) [
	d/year: 			0
	d/month: 			0
	d/hour: 			0
	d/minutes: 			0
	d/seconds:			0
	d/microseconds:		0
	d/tz-hours:			0
	d/tz-minutes:		0	
]
