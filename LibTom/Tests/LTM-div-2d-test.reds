Red/System [
	Title:   "Red/System Lib Tom Maths div-2d tests"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../../../../Languages/Red/quick-test/quick-test.reds
#include %../libtommaths.def
#include %../LTM-init.reds
#include %../LTM-set-int.reds
#include %../LTM-div-2d.reds

print-digits: func [
	mp-int				[LTM-int!]
	/local
	bp					[LTM-digit-ptr!]
	i					[integer!]
][
	print ["The digits (least significant first) are:" lf]	
	bp: mp-int/mp-digit
	i: 0
	while [i < mp-int/used][
		print [as integer! bp/value lf]
		i: i + 1
		bp: bp + 1
	]
]

~~~start-file~~~ "LTM div-2d"
#include %mp-div-2d-group.reds
~~~end-file~~~

