Red/System [
	Purpose:     "Load integer function"
	Author:      "Peter W A Wood"
	Version:     0.1.1
	Rights:      "Copyright © 2012-2103 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-load-int: func [
	;; loads an integer from a string into the supplied integer
	;; it assumes that the string is a valid integer literal
	;; this is initial versions only handles decimal integers
	;; returns integer! :
	;;		1   - invalid integer supplied
	;;
	;; the function expects a c-string as the first argument
	;; and a pointer to the integer to be loaded as its second.
	s     				[c-string!]
	i     				[pointer! [integer!]]
	return: 			[integer!]
	/local
		neg?  			[logic!]
][
	if not PWAW-C-str-int? s [return 1]
	
	neg?: false
	if any [
		s/1 = #"-" 
		s/1 = #"+" 
	][
		if s/1 = #"-" [neg?: true]
		s: s + 1
	]
	
	i/value: 0 
	until [
		i/value: i/value * 10
		i/value: i/value + (s/1 - 48)
		s: s + 1
		s/1 = null-byte
	]
	if neg? [i/value: i/value * -1]
	0
]
