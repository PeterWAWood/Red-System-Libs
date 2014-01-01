Red/System [
	Title:   "Red/System date-time library - store-int test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2012-2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "store-int"

	--test-- "si-1"
		i: 0	
	--assert 0 = PWAW-DT-store-int "1" :i
	--assert i = 1

~~~end-file~~~
