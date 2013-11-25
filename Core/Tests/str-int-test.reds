Red/System [
	Title:   "Red/System core library - str-int? test script"
	Author:  "Peter W A Wood"
	File: 	 %str-int-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-C-core.reds

~~~start-file~~~ "str-int?"
    
	--test-- "si-1"
	--assert PWAW-C-str-int? "1"
	
	--test-- "si-2"
	--assert not PWAW-C-str-int? "a"
	
	--test-- "si-3"
	--assert PWAW-C-str-int? "-1"
	
	--test-- "si-4"
	--assert not PWAW-C-str-int? "-"
	
	--test-- "si-5"
	--assert PWAW-C-str-int? "1234567890"
	
	--test-- "si-6"
	--assert PWAW-C-str-int? "-1234567890"
	
	--test-- "si-7"
	--assert not PWAW-C-str-int? "123456789O"
	
	--test-- "si-8"
	--assert not PWAW-C-str-int? "!234567890"
	
	--test-- "si-9"
	--assert not PWAW-C-str-int? "123cd67890"
	
	--test-- "si-10"
	--assert PWAW-C-str-int? "2147483647"
	
	--test-- "si-11"
	--assert PWAW-C-str-int? "+2147483647"
	
	--test-- "si-12"
	--assert PWAW-C-str-int? "-2147483648"
	
	--test-- "si-13"
	--assert not PWAW-C-str-int? "2147483648"
	
	--test-- "si-14"
	--assert not PWAW-C-str-int? "-2147483649"
	
	--test-- "si-15"
	--assert not PWAW-C-str-int? "2147483657"
	
	--test-- "si-16"
	--assert PWAW-C-str-int? "+1"
	
	--test-- "si-17"
	--assert not PWAW-C-str-int? "+"
	
~~~end-file~~~

