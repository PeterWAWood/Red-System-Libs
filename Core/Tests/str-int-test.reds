Red/System [
	Title:   "Red/System core library - str-int? test script"
	Author:  "Peter W A Wood"
	File: 	 %str-int-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../core.reds

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
	--assert PWAW-C-str-int? ["abcde1234567890abcde" 6 15]
	
	--test-- "si-11"
	--assert not PWAW-C-str-int? 123
	
	--test-- "si-12"
	--assert not PWAW-C-str-int? ["1234567890" 2]
	
	--test-- "si-13"
	--assert not PWAW-C-str-int? ["12345b7890" 5 7]
	
	--test-- "si-14"
	--assert not PWAW-C-str-int? ["1234567890" -1 2]
	
	--test-- "si-15"
	--assert not PWAW-C-str-int? ["1234567890" 3 2]
	
	--test-- "si-16"
	--assert not PWAW-C-str-int? ["1234567890" 11 9]
	
	--test-- "si-17"
	--assert not PWAW-C-str-int? ["1234567890" 9 11]
	
	--test-- "si-18"
	--assert not PWAW-C-str-int? ["1234567890" "a" 11]
	
	--test-- "si-19"
	--assert not PWAW-C-str-int? ["1234567890" 1 "c"]
	
	--test-- "si-20"
	--assert PWAW-C-str-int? "2147483647"
	
	--test-- "si-21"
	--assert PWAW-C-str-int? "-2147483648"
	
	--test-- "si-22"
	--assert not PWAW-C-str-int? "2147483648"
	
	--test-- "si-23"
	--assert not PWAW-C-str-int? "-2147483649"
	
	--test-- "si-24"
	--assert not PWAW-C-str-int? "2147483657"
	
	--test-- "si-25"
	--assert PWAW-C-str-int? "+1"
	
	--test-- "si-26"
	--assert not PWAW-C-str-int? "+"
	
~~~end-file~~~

