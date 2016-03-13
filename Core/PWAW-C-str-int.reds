Red/System [
	Purpose:     {Checks that a string contains a literal representation of an
				  integer."}
  Author:      "Peter W A Wood"
  Version:     0.2.0
  Rights:      "Copyright © 2012-2103 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-str-int?: func [
	;; checks a string is a correct literal representation of an integer
	;; this is initial versions only handles decimal literal
	;; returns logic! :
	;;    true  - string contains an integer
	;;    false - string does not contain an integer
	;; the function expects a c-string as the first argument
	s				[c-string!]
	return:			[logic!]
	/local
	  end			[integer!]
	  len			[integer!]
	  neg?			[logic!]
	  pos			[integer!]
	  sign?			[logic!]
	  start			[integer!]
][
	neg?: false
	sign?: false
	len: length? s
	
	start: 1
	end: len
	len: end - start + 1
	pos: start
	
	either any [
		s/1 = #"-" 
		s/1 = #"+"  
	][
		sign?: true	
		if any [
			len = 1
			len > 11
		][
			return false
		]
		if s/1 = #"-" [neg?: true]
		s: s + 1
	][
		if len > 10 [return false] 
	]
	until [
		if any [
			s/1 < #"0"
			s/1 > #"9"      
		][return false]
		s: s + 1
		s/1 = null-byte
	]
	;; now check for max-size
	s: s - len                        	;; go back to start of string
	if sign? [
		s: s + 1
		len: len - 1
	]
	if len = 10 [
		if s/1 > #"2" [return false]
		if s/1 < #"2" [return true]
		if s/2 > #"1" [return false]
		if s/2 < #"1" [return true]
		if s/3 > #"4" [return false]
		if s/3 < #"4" [return true]
		if s/4 > #"7" [return false]
		if s/4 < #"7" [return true]
		if s/5 > #"4" [return false]
		if s/5 < #"4" [return true]
		if s/6 > #"8" [return false]
		if s/6 < #"8" [return true]
		if s/7 > #"3" [return false]
		if s/7 < #"3" [return true]
		if s/8 > #"6" [return false]
		if s/8 < #"6" [return true]
		if s/9 > #"4" [return false]
		if s/9 < #"4" [return true]
		either neg? [
			if s/10 > #"8" [return false]
		][
			if s/10 > #"7" [return false]
		]
	]
	true
]



