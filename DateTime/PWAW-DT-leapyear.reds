Red/System [
	Purpose:     "Worksout if a year is a leap year"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]


PWAW-DT-leapyear?: func [
	year				[integer!]
	return:				[logic!]
	/local
		leapyear		[logic!]
][
	leapyear: false
	if 0 = (year % 4) [
		leapyear: true
		if 0 = (year % 100) [
			leapyear: false
			if 0 = (year % 1000) [leapyear: true]
		]
	]
	leapyear
]
