Red/System [
  Purpose:     "Copies a string"
  Author:      "Peter W A Wood"
  Version:     0.1.1
  Rights:      "Copyright © 2012-2103 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-str-copy: func [
	;; copies a  string
	in              [c-string!]
	out             [c-string!]
	return:         [integer!]
	;; returns:
	;;      0 - successful copy
	;;      1 - supplied string too short
][
	if in/1 = null-byte [
		out/1: null-byte
		return 0
	]
	until [
		if out/1 = null-byte [return 1]
		out/1: in/1
		in: in + 1
		out: out + 1
		in/1 = null-byte
	]
	out/1: null-byte
	0
]
