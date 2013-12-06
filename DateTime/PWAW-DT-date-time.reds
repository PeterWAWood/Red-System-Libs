Red/System [
	Purpose:     "A basic date-time library"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-date.def
#include %PWAW-DT-time.def

#switch OS [
	Windows  [#include %PWAW-DT-date-time-win32.reds]
	#default [#include %PWAW-DT-date-time-libc.reds]
]

#include %PWAW-DT-date-to-days.reds
#include %PWAW-DT-load-date.reds
#include %PWAW-DT-mold-date.reds
#include %PWAW-DT-push-month.reds
#include %PWAW-DT-push-two-digits.reds
#include %PWAW-DT-store-int.reds

