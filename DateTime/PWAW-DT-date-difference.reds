Red/System [
	Purpose:     {
		Calculates the difference between to dates in days, hours, minutes,
		seconds and milliseconds
	}				
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-date.def
#include %PWAW-DT-duration.def
#include %PWAW-DT-date-to-days.reds
#include %PWAW-DT-days-in-year-todate.reds
#include %PWAW-DT-duration-difference.reds
#include %PWAW-DT-equal.reds
#include %PWAW-DT-later.reds

PWAW-DT-date-difference: func [
	{Calculates the between two dates}
	d1				[PWAW-DT-date!]				{the first date}
	d2				[PWAW-DT-date!]				{second date}
	dur				[PWAW-DT-duration!]			{for the calculated duration}   
	return:			[integer!]
	{    
  		0 - successful
  		1 - error converting to UTC
  		2 - error converting date to days
  		3 - error getting days to-date in current year
  		4 - error calculating difference in durations since 0/1/1
  	}
  	/local
  		dur1		[PWAW-DT-duration!]
  		dur2		[PWAW-DT-duration!]
  		i			[integer!]
  		utc-d1		[PWAW-DT-date!]
  		utc-d2		[PWAW-DT-date!]
 
  
][
	PWAW-DT-ZERO-DURATION(dur)
	dur1: declare PWAW-DT-duration!
	PWAW-DT-ZERO-DURATION(dur1)
	dur2: declare PWAW-DT-duration!
	PWAW-DT-ZERO-DURATION(dur2)
	utc-d1: declare PWAW-DT-date!
	utc-d2: declare PWAW-DT-date!
	i: 0
	
	if PWAW-DT-equal? d1 d2 [
		PWAW-DT-ZERO-DURATION(dur)
		return 0
	]
	
	either PWAW-DT-later? d1 d2 [
		if 0 <> PWAW-DT-UTC d1 utc-d1 [return 1]
		if 0 <> PWAW-DT-UTC d2 utc-d2 [return 1]
	][
		if 0 <> PWAW-DT-UTC d2 utc-d1 [return 1]
		if 0 <> PWAW-DT-UTC d1 utc-d2 [return 1]
	]
	
	if 0 <> PWAW-DT-date-to-days utc-d1 :i [return 2]
	dur1/days: i
	dur1/hours: utc-d1/hour
	dur1/minutes: utc-d1/minutes
	dur1/seconds: utc-d1/seconds
	dur1/microseconds: utc-d1/microseconds
	if 0 <> PWAW-DT-date-to-days utc-d2 :i [return 2]
	dur2/days: i
	dur2/hours: utc-d2/hour
	dur2/minutes: utc-d2/minutes
	dur2/seconds: utc-d2/seconds
	dur2/microseconds: utc-d2/microseconds

	if 0 <> PWAW-DT-duration-difference dur1 dur2 dur [
		PWAW-DT-ZERO-DURATION(dur)
		return 4
	]
	
	0
]
