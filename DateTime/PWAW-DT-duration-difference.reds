Red/System [
	Purpose:     {
		Subtracts a shorter duration from a longer one
	}				
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-duration-def.reds

PWAW-DT-duration-difference: func [
	{Subtracts a shorter duration from a longer one}
	d1				[PWAW-DT-duration!]			{the longer duration}
	d2				[PWAW-DT-duration!]			{the shorter duration}
	dur				[PWAW-DT-duration!]			{the difference}   
	return:			[integer!]
	{    
  		0 - successful
  		1 - the first duration must be longer than the second
  	}
  
][
	PWAW-DT-ZERO-DURATION(dur)
	
	if any [
		d2/days > d1/days
		all [
			d2/days = d1/days
			d2/hours > d1/hours
		]
		all [
			d2/days = d1/days
			d2/hours = d1/hours
			d2/minutes > d1/minutes
		]
		all [
			d2/days = d1/days
			d2/hours = d1/hours
			d2/minutes = d1/minutes
			d2/seconds > d1/seconds
		]
		all [
			d2/days = d1/days
			d2/hours = d1/hours
			d2/minutes = d1/minutes
			d2/seconds = d1/seconds
			d2/microseconds > d1/microseconds
		]
	][
		return 1	
	]
	
	dur/days: d1/days - d2/days
	dur/hours: d1/hours - d2/hours
	dur/minutes: d1/minutes - d2/minutes
	dur/seconds: d1/seconds - d2/seconds
	dur/microseconds: d1/microseconds - d2/microseconds
	if dur/microseconds < 0 [
		dur/microseconds: dur/microseconds + 1000
		dur/seconds: dur/seconds - 1
	]
	if dur/seconds < 0 [
		dur/seconds: dur/seconds + 60
		dur/minutes: dur/minutes - 1
	]
	if dur/minutes < 0 [
		dur/minutes: dur/minutes + 60
		dur/hours: dur/hours - 1
	]
	if dur/hours < 0 [
		dur/hours: dur/hours + 24
		dur/days: dur/days - 1
	] 
			
	0
]
