Red/System [
	Title:   "string to c-string"
	Author:  "Peter W A Wood"
	File: 	 %string-c-string.reds
	Version: 0.0.1
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %ucs4-utf8.reds
	
PWAW-string-c-string: func [
	str	    	[red-string!]
	return: 	[c-string!]
	/local
		b		[byte!]
		s		[series!]
		cp		[integer!]
		p		[byte-ptr!]
		p4		[int-ptr!]
		unit	[integer!]
		utf8	[c-string!]
		utf8p	[integer!]
		utf8ch	[c-string!]
		utf8chp	[integer!]
][
	#include %ucs4-utf8.reds

	p: as byte-ptr! 0
	p4: as int-ptr! 0
	b: as byte! 0
	p: string/rs-head str
	tail: string/rs-tail str
	utf8p: 1
	utf8ch: ""
	utf8chp: 1
	utf8: as c-string! alloc-bytes (((as integer! tail) - (as integer! p)) / 4)
	s: GET_BUFFER(str)
	unit: GET_UNIT(s)
	while [p < tail][
		cp: switch unit [
			Latin1 [as-integer p/value]
			UCS-2  [(as-integer p/2) << 8 + p/1]
			UCS-4  [p4: as int-ptr! p p4/value]
		]
		utf8ch: PWAW-ucs4-utf8 cp
		utf8chp: 1
		until [
			utf8/utf8p: utf8ch/utf8chp
			utf8p: utf8p + 1
			utf8chp: utf8chp + 1
			null-byte = utf8ch/utf8chp
		]
		p: p + unit
	]
	utf8/utf8p: null-byte						;; end the c-string
	
	utf8
]

