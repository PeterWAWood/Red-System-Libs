Red/System [
	Purpose:	"Compares two strings, byte by byte"
	Author:		"Peter W A Wood"
	Version:	0.1.1
	Rights:		"Copyright © 2012-2103 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-str-equal?: func [
	;; compares two strings byte by byte
	;; returns logic! :
	;;		true  - strings match
	;;		false - strings do not match
	
	s1				[c-string!]
	s2				[c-string!]
	return:			[logic!]
	/local
	i				[integer!]
	size-s1			[integer!]
][
	i: 1
	size-s1: size? s1
	if (size-s1) <> (size? s2) [return false]
	if 1 = size-s1 [return true]
	until [
	  if s1/i <> s2/i [return false]
	  i: i + 1
	  s1/i = null-byte    
	]
	true
]

