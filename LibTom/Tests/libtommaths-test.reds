Red/System [
	Title:   "Red/System Lib Tom aths tests"
	Author:  "Peter W A Wood"
	File: 	 %libtommaths-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../../../../Languages/Red/quick-test/quick-test.reds
#include %../libtommaths.reds

print-digits: func [
	mp-int				[LTM-int!]
	/local
	bp					[LTM-digit-ptr!]
	i					  [integer!]
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

~~~start-file~~~ "lib tom maths"

#include %mp-abs-group.reds
#include %mp-add-group.reds
#include %mp-clamp-group.reds
#include %mp-clear-group.reds
#include %mp-cmp-mag-group.reds
#include %mp-compare-group.reds
#include %mp-copy-group.reds
#include %mp-copy-init-group.reds
#include %mp-div-2-group.reds
#include %mp-grow-group.reds
#include %mp-init-group.reds
#include %mp-init-multi-group.reds
#include %mp-init-size-group.reds
#include %mp-lshb-group.reds
#include %mp-lshd-group.reds
#include %mp-mul-2-group.reds
#include %mp-neg-group.reds
#include %mp-rshd-group.reds
#include %mp-set-group.reds
#include %mp-set-int-group.reds
#include %mp-sub-group.reds
#include %mp-s-add-group.reds
#include %mp-s-sub-group.reds
#include %mp-zero-group.reds

~~~end-file~~~

