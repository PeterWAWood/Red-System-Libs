Red/System [
	Purpose:	"Return a sub-sting from a string"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2103 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-substr: func [
	{ returns a sub-string of a string}
	string			[c-string!]					"original string"
	index			[integer!]					{start of sub-string,one-based}
	length			[integer!]					{length of sub-string}
	substr			[c-string!]					{the substing}
	return:			[integer!]					{returns
		0	successful
		1   provided string too short
		2   invalid substring start or length
	}
	/local
		i			[integer!]
		j			[integer!]
][
	if length > length? substr [return 1]
	
	if any [
		index < 1 
		index > length? string
		(length? string) < (index + length - 1)
	][
		return 2
	]
	
	i: index
	J: 1
	until [
		substr/j: string/i
		i: i + 1
		j: j + 1
		j > length
	]
	substr/j: null-byte
	
	0
]

