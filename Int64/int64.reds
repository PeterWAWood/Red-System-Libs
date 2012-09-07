Red/System [
  Purpose:     Temporary int64! arithmeticlibrary
  Author:      Peter W A Wood
  Version:     0.1.0
  Rights:      Copyright © 2012 Peter W A Wood. All rights reserved.
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/core.reds

#switch OS [
	Windows  [
	  #define INT64-FILE	"c:\Users\Peter\Code\Red-System\Red-System-Libs\Int64\i64.dll"
	]
	MacOSX	 [
	  #define INT64-FILE	"/Users/peter/Code/Red-System/Red-System-Libs/Int64/libi64.dylib"
	]
	#default [
		#define INT64-FILE	"/home/peter/Code/Red-System-Libs/Int64/libi64.so"
	]
]

#import [
	INT64-FILE cdecl [
	  PWAW-I64-subtract: "subtract" [
	    i           [PWAW-C-int64!]
	    j           [PWAW-C-int64!]
	    k           [PWAW-C-int64!]
	    return:     [integer!]
	  ]
	  PWAW-I64-divide: "divide" [
	    i           [PWAW-C-int64!]
	    j           [PWAW-C-int64!]
	    k           [PWAW-C-int64!]
	    return:     [integer!]
	  ]
	]
]


PWAW-I64-sub: func [
  ;; subtracts the 2nd argument from the 1st and places the answer in the 3rd
  ;; returns integer!:
  ;;    0 - success
	i                 [PWAW-C-int64!] 
	j                 [PWAW-C-int64!]
	k                 [PWAW-C-int64!]
	return:           [integer!]
][
  PWAW-I64-subtract i j k
  0
]

PWAW-I64-div: func [
  ;; divides the 1st argument by the 2nd and places the answer in the 3rd
  ;; performs an integer divide with no rounding
  ;; returns integer!:
  ;;    0 - success
  ;;    1 - zero divide - answer is set to zero
	i                 [PWAW-C-int64!] 
	j                 [PWAW-C-int64!]
	k                 [PWAW-C-int64!]
	return:           [integer!]
][
  either all [
    j/low = 0
    j/high = 0
  ][
    k/low: 0
    k/high: 0 
    1
  ][
    PWAW-I64-divide i j k
    0
  ]
]
