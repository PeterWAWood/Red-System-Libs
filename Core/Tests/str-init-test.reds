Red/System [
	Title:   "Red/System core library - str-init test script"
	Author:  "Peter W A Wood"
	File: 	 %substr-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-C-core.reds

~~~start-file~~~ "str-init"

	--test-- "si1"
		si1-str: as c-string! allocate 6
	--assert 0 = PWAW-C-str-init si1-str 5 #" "
	--assert #" " = si1-str/1
	--assert #" " = si1-str/2
	--assert #" " = si1-str/3
	--assert #" " = si1-str/4
	--assert #" " = si1-str/5
	--assert null-byte = si1-str/6
		free as byte-ptr! si1-str
    
~~~end-file~~~

