Red/System [
  Purpose:     "subtracts one positive 64-bit integer from another"
  Author:      "Peter W A Wood"
  Version:     0.2.1
  Rights:      "Copyright © 2012-2013 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-I64-base-subtract: func [
	{subtracts one positive 64-bit integer from another
		returns:
			0 - success
			1 - an negative argument was supplied
	}
	i			[PWAW-I64-int64!] 		
	j           [PWAW-I64-int64!]
	k			[PWAW-I64-int64!]					"i - j"
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
	
	k/high: i/high - j/high
	k/low: i/low - j/low
	if k/low > i/low [
		k/high: k/high - 1
		k/low: k/low + (as PWAW-I64-uint32! FFFFFFFFh)
		k/low: k/low + (as PWAW-I64-uint32! 1)
	]

	0
]
