Red/System [
	Title:   "Red/System byte! datatype test script"
	Author:  "Peter W A Wood"
	File: 	 %byte-test.reds
	Rights:  "Copyright (C) 2011 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../date-time.reds

~~~start-file~~~ "date-time"

===start-group=== "now"
    n-now: declare PWAW-DT-date!
    
	--test-- "tv-1"
	--assert 0 = PWAW-DT-now n-now
	--assert n-now/year > 2010
	--assert n-now/month > 0
	--assert n-now/month < 13
	--assert n-now/day > 0
	--assert n-now/day < 32
	
===end-group===	
	
~~~end-file~~~

