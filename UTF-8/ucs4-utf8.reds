Red/System [
	Title:   "ucs-4 to utf-8"
	Author:  "Peter W A Wood"
	File: 	 %ucs4-utf8.reds
	Version: 0.0.1
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]
	
PWAW-ucs4-utf8: func [
	ucs4 				[integer!]
	return: 			[c-string!]
	/local
		b				[byte!]
		utf8			[struct! [
							byte1 [byte!]
							byte2 [byte!]
							byte3 [byte!]
							byte4 [byte!]
							byte5 [byte!]
		]]
][
	
	utf8: declare struct! [
		byte1 [byte!]
		byte2 [byte!]
		byte3 [byte!]
		byte4 [byte!]
		byte5 [byte!]
	]
	
	utf8/byte1: null-byte
	utf8/byte2: null-byte
	utf8/byte3: null-byte
	utf8/byte4: null-byte
	utf8/byte5: null-byte
	
	either ucs4 < 128 [
		utf8/byte1: as byte! ucs4
	][
		either ucs4 < 00010000h [                  ;; BMP
			either ucs4 < 0800h [
				b: as byte! (ucs4 >>> 6)
				utf8/byte1: (as byte! C0h) or b
				b: as byte! (ucs4 and 3Fh)
				utf8/byte2: (as byte! 80h) or b
			][
				b: as byte! (ucs4 >>> 12)
				utf8/byte1: (as byte! E0h) or b
				b: as byte! ((ucs4 >>> 6) and 3Fh)
				utf8/byte2: (as byte! 80h) or b
				b: as byte! (ucs4 and 3Fh)
				utf8/byte3: (as byte! 80h) or b
			]
		][										;; only handle BMP for now
			utf8/byte1: as byte! 0
		]
	]
	
	as c-string! utf8
]

