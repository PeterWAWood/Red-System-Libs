Red/System [
	Purpose:     "A basic date-time library"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-date-def.reds
#include %PWAW-DT-duration-def.reds

#switch OS [
	Windows  [#include %PWAW-DT-date-time-win32.reds]
	#default [#include %PWAW-DT-date-time-libc.reds]
]

#include %PWAW-DT-date-difference.reds
#include %PWAW-DT-date-to-days.reds
#include %PWAW-DT-days-in-year-todate.reds
#include %PWAW-DT-days-to-date.reds
#include %PWAW-DT-duration-difference.reds
#include %PWAW-DT-equal.reds
#include %PWAW-DT-later.reds
#include %PWAW-DT-leapyear.reds
#include %PWAW-DT-load-date.reds
#include %PWAW-DT-mold-date.reds
#include %PWAW-DT-push-month.reds
#include %PWAW-DT-push-two-digits.reds
#include %PWAW-DT-store-int.reds
#include %PWAW-DT-UTC.reds
#include %PWAW-DT-year-as-days.reds
