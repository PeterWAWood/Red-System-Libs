Red [
	Title:   "string-c-string unit tests"
	Author:  "Peter W A Wood"
	File: 	 %string-c-string-test.red
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
]

#include %/Users/peter/VMShare/Languages/Red/quick-test/quick-test.red

~~~start-file~~~ "string to c-string"
	
	--test-- "scs1"
		scs1-r: routine: [
			str					[string!]
			return:				[logic!]
			/local
				c-str			[c-string!]
				ret-value		[logic!]
		][
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/Core/core.reds
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/UTF-8/string-c-string.reds
			c-str: PWAW-string-c-string str
			ret-value: PWAW-C-compare-strings "hello world" c-str
			free as byte-ptr! c-str
			ret-value
		]
	--assert scs1-r "hello world"
	
	--test-- "scs2"
		scs2-r: routine: [
			str			[string!]
			return:		[logic!]
			/local
				c-str			[c-string!]
				ret-value		[logic!]
		][
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/Core/core.reds
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/UTF-8/string-c-string.reds
			c-str: PWAW-string-c-string str
			ret-value: PWAW-C-compare-strings {EspañolРусскийSlovenščina} c-str
			free as byte-ptr! c-str
			ret-value
		]
			
	--assert scs2-r {EspañolРусскийSlovenščina}
	  
~~~end-file~~~
