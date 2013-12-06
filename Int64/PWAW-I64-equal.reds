Red/System [
  Purpose:     "Checks if two 64-bit integers are equal"
  Author:      "Peter W A Wood"
  Version:     0.2.1
  Rights:      "Copyright © 2012-2013 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-I64-equal?: func [
	"returns true if the two integers are equal"
	i			[PWAW-I64-int64!] 
	j           [PWAW-I64-int64!]
	return:     [logic!]
][
	if i/high <> j/high [return false]
	if j/low <> i/low [return false]
	true
]
