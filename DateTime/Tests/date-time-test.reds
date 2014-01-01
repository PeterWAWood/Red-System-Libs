Red/System [
	Title:   "Red/System core library - test script"
	Author:  "Peter W A Wood"
	File: 	 %core-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../../Core/PWAW-C-core.reds

***start-run*** "Date Time Tests"
#include %date-difference-test.reds
#include %date-to-days-test.reds
#include %days-in-year-todate-test.reds
#include %days-to-date-test.reds
#include %duration-difference-test.reds
#include %equal-test.reds
#include %later-test.reds
#include %leapyear-test.reds
#include %load-date-test.reds
#include %mold-date-test.reds
#include %now-test.reds
#include %store-int-test.reds
#include %UTC-test.reds
#include %year-as-days-test.reds
***end-run***


