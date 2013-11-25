Red/System [
  Purpose:     "Compares two 64-bit integers"
  Author:      "Peter W A Wood"
  Version:     0.2.1
  Rights:      "Copyright © 2012-2013 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-I64-greater?: func [
	"returns true if the first integer is larger than the second"
	i			[PWAW-I64-int64!] 
	j           [PWAW-I64-int64!]
	return:     [logic!]
][
	if i/high > j/high [return true]
	if j/low > i/low [return false]
	either i/low > j/low [
		true
	][
		false
	]
]
