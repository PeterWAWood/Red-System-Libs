Red/System [
	Title:   "Red/System core library - year-as-days-test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "year as days"
	--test-- "yad-1"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 0 :i
	--assert 0 = i
	
	--test-- "yad-2"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 1 :i
	--assert 365 = i
	
	--test-- "yad-3"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 3 :i
	--assert 1095 = i 
	
	--test-- "yad-4"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 4 :i
	--assert 1461 = i
	
	--test-- "yad-5"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 100 :i
	--assert 36524 = i
	
	--test-- "yad-6"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 2000 :i
	--assert 730482 = i
	
	--test-- "yad-7"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 2001 :i
	--assert 730847 = i
	
	--test-- "yad-8"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 2012 :i
	--assert 734865 = i
	
	--test-- "yad-9"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 2013 :i
	--assert 735230 = i
	
	--test-- "yad-10"
		i: 0
	--assert 0 = PWAW-DT-year-as-days 2014 :i
	--assert 735595 = i
	
~~~end-file~~~

