Red/System [
	Purpose:     "A date to days conversion function "
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds
#include %PWAW-DT-date.def
#include %PWAW-DT-time.def

PWAW-DT-date-to-days: func [
	{Converts a date to a number of days since 31/12/1 BC (0/0/0)} 
	d					[PWAW-DT-Date!]			{a date to be converted}	
	days				[pointer! [integer!]]	{number of days} 
][
	
]

