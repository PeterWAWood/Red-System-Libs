Red/System [
  Purpose:     "Mold an integer"
  Author:      "Peter W A Wood"
  Version:     0.1.1
  Rights:      "Copyright © 2012-2103 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-mold-int: func [
	;; provides a literal representation of an integer in the supplied string
	  
	i				[integer!]
	s				[c-string!]
	return:			[integer!]
	;; returns:
	;;		0 - successful conversion
	;;		1 - supplied string too short
	
	/local
	digit			[integer!]
	digit-printed?	[logic!]
	divisor			[integer!]
	len				[integer!]
	pos				[integer!]
	rem				[integer!]
][
	len: length? s
	divisor: 1000000000
	digit-printed?: false
	
	if i = 0 [
		if len < 1 [return 1]
		s/1: #"0"
		s/2: null-byte
		return 0
	]
	if i = -2147483648 [
		if len < 11 [return 1]
			s/1:  #"-"
			s/2:  #"2"
			s/3:  #"1"
			s/4:  #"4"
			s/5:  #"7"
			s/6:  #"4"
			s/7:  #"8"
			s/8:  #"3"
			s/9:  #"6"
			s/10: #"4"
			s/11: #"8"
			s/12: null-byte
			return 0
	]
	rem: i
	pos: 1
	if rem < 0 [
		s/pos: #"-"
		pos: pos + 1
		rem: -1 * rem
	]
	until [
		digit: rem / divisor
		either digit-printed? [
			s/pos: as byte! (digit + 48)
			pos: pos + 1
		][
			if digit <> 0 [
				s/pos: as byte! (digit + 48)
				pos: pos + 1
				digit-printed?: true
			]
		]
		if pos > len [return 1]
		rem: rem - (digit * divisor)
		divisor: divisor / 10
		divisor = 0
	]
	s/pos: null-byte
	0
]

