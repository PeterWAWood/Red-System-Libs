Red/System [
  Purpose:     "adds two positive 64-bit integers"
  Author:      "Peter W A Wood"
  Version:     0.2.1
  Rights:      "Copyright © 2012-2013 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-I64-base-add: func [
	{adds two positive 64-bit integers
		returns:
			0 - success
			1 - an negative argument was supplied
	}
	i			[PWAW-I64-int64!] 		
	j           [PWAW-I64-int64!]
	k			[PWAW-I64-int64!]					"the sum of i and j"
	return:     [integer!]
][
	if any [
		i/high < 0
		j/high < 0
	][
		k/high: 0
		k/low: as PWAW-I64-uint32! 0
		return 1
	]
	
	k/high: i/high + j/high
	k/low: i/low + j/low
	if any [
		k/low < i/low
		k/low < j/low
	][
		k/high: k/high + 1
	]

	0
]
