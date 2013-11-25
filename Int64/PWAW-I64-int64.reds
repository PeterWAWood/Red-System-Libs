Red/System [
  Purpose:     int64! arithmetic library
  Author:      Peter W A Wood
  Version:     0.2.1
  Rights:      "Copyright © 2012-2013 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64.def
#include %PWAW-I64-greater.reds

comment {

PWAW-I64-sub: func [
  ;; subtracts the 2nd argument from the 1st and places the answer in the 3rd
  ;; returns integer!:
  ;;    0 - success
	i                 [PWAW-I64-int64!] 
	j                 [PWAW-I64-int64!]
	k                 [PWAW-I64-int64!]
	return:           [integer!]
	/local
	  carry           [integer!]
][
  either j/high > i/high [
    
  ][

  ]
  0
]

PWAW-I64-div: func [
  ;; divides the 1st argument by the 2nd and places the answer in the 3rd
  ;; performs an integer divide with no rounding
  ;; returns integer!:
  ;;    0 - success
  ;;    1 - zero divide - answer is set to zero
	i                 [PWAW-I64-int64!] 
	j                 [PWAW-I64-int64!]
	k                 [PWAW-I64-int64!]
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

}
