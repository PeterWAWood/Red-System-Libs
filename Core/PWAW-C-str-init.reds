Red/System [
	Purpose:	"Initialise a string"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2103 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-str-init: func [
	{ initialise a string}
	string			[c-string!]					"string to be initialised"
	num				[integer!]					"number of chars to init"
	char			[byte!]						"the initialisation value"
	return:			[integer!]					{returns
		0	successful
	}
	/local
		i			[integer!]
][
	i: 1
	until [
		string/i: char
		i: i + 1
		i > num
	]
	string/i: null-byte
	
	0
]

