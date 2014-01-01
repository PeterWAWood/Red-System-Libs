Red/System [
	Purpose:     "Calculates number of days in the year excluding supplied date"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2103 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-date.def

PWAW-DT-days-in-year-todate: func [
  {Calculates the number of days in the year before this date}
  d					[PWAW-DT-date!]				{the date}
  days				[pointer! [integer!]]		{the number of days calculated}   
  return:			[integer!]
  {    
  		0 - successful
  }
  /local 
  acc				[integer!]
][
	acc: 0
	switch d/month [
		1   []
		2	[acc: acc + 31]
		3	[acc: acc + 59]
		4	[acc: acc + 90]
		5	[acc: acc + 120]
		6	[acc: acc + 151]
		7	[acc: acc + 181]
		8	[acc: acc + 212]
		9	[acc: acc + 243]
		10	[acc: acc + 273]
		11	[acc: acc + 304]
		12  [acc: acc + 334]
	]
	
	if d/month > 2 [
		if 0 = (d/year % 4) [acc: acc + 1]
		if 0 = (d/year % 100) [acc: acc - 1]
		if 0 = (d/year % 400) [acc: acc + 1]
	]
	
	acc: acc + d/day - 1
	
	days/value: acc
	0
]
