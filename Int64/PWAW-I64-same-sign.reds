Red/System [
  Purpose:     "Checks if two 64-bit integers have the same sign"
  Author:      "Peter W A Wood"
  Version:     0.2.1
  Rights:      "Copyright © 2012-2013 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-I64-same-sign?: func [
	"returns true if the two integers have the same sign"
	i			[PWAW-I64-int64!] 
	j           [PWAW-I64-int64!]
	return:     [logic!]
][
	either any [
		all [
			i/high >= 0
			j/high >= 0
		]
		all [
			i/high < 0
			j/high < 0
		]
	][
		true
	][
		false
	]
	
]
