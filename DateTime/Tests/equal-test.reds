Red/System [
	Title:   "Red/System date-time library - equal test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2012-2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "equal"

	dd-date1: declare PWAW-DT-date!
	dd-date2: declare PWAW-DT-date!
	
	--test-- "de-1"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date2
	--assert PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-2"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:15" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-3"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+09:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-4"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:26+08:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-5"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date2
		dd-date1/microseconds: 356
		dd-date2/microseconds: 355
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-6"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:45:27+08:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-7"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/15:46:27+08:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-8"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "12-Jan-2012/16:46:27+08:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-9"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Feb-2012/16:46:27+08:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
	--test-- "de-10"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2013/16:46:27+08:30" dd-date2
	--assert not PWAW-DT-equal? dd-date1 dd-date2
	
~~~end-file~~~

