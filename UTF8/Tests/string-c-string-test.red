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
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/Core/PWAW-C-core.reds
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/UTF8/string-c-string.reds
			c-str: PWAW-string-c-string str
			ret-value: PWAW-C-str-equal? "hello world" c-str
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
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/Core/PWAW-C-core.reds
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/UTF8/string-c-string.reds
			c-str: PWAW-string-c-string str
			ret-value: PWAW-C-str-equal? {EspañolРусскийSlovenščina} c-str
			free as byte-ptr! c-str
			ret-value
		]
			
	--assert scs2-r {EspañolРусскийSlovenščina}
	
	--test-- "scs3"
		scs3-r: routine: [
			str			[string!]
			return:		[logic!]
			/local
				c-str			[c-string!]
				ret-value		[logic!]
		][
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/Core/PWAW-C-core.reds
			#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/UTF8/string-c-string.reds
			c-str: PWAW-string-c-string str
			print [length? c-str lf]
			print [length? {^(F0)^(9D)^(84)^(A2)} lf]
			ret-value: PWAW-C-str-equal? {^(F0)^(9D)^(84)^(A2)} c-str
			print [as integer! c-str/1 lf]
			print [as integer! c-str/2 lf]
			print [as integer! c-str/3 lf]
			print [as integer! c-str/4 lf]
			print [as integer! c-str/5 lf]
			free as byte-ptr! c-str
			ret-value
		]
		
		--assert scs3-r "^(01D122)"
	  
~~~end-file~~~
