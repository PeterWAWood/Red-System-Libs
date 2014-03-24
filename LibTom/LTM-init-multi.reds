Red/System [
  Purpose:	"Initalises multiple new mp-ints"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-init-multi: func [
	"Initalises multiple new mp-ints"
	[typed]
	count                 [integer!]
	list                  [typed-value!]				;; list of mp-ints 
	return:               [integer!]
	/local
		i			              [integer!]
		j			              [integer!]
		tmp-list	          [typed-value!]		
][
	
	;; check that type of the mp-ints to be initalised
	;;  Red/System version 1 only allows checking that it is an alias
	i: 0
	tmp-list: list
	until [
		i: i + 1
		if not alias? tmp-list/type [return LTM-INVALID-ARGS]
		tmp-list: tmp-list + 1

		i = count
	]

	;; initialise the mp-ints, if a failure is encountered clear any 
	;;  previously initialised mp-ints
	i: 0
	tmp-list: list
	until [
		i: i + 1
		if LTM-OKAY <> LTM-init as LTM-int! tmp-list/value [
			;; clear any mp-ints that were successfully initalised
			if i > 1 [
				j: 1
				until [
					LTM-clear as LTM-int! list/value
					list: list + 1
					j: j + 1
					j = i	
				]
			]
			return LTM-MEM
		]
		
		tmp-list: tmp-list + 1
		i = count
	]
	
	LTM-OKAY
]