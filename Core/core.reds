Red/System [
  Purpose:     Core support functions library
  Author:      Peter W A Wood
  Version:     0.0.1
  Rights:      Copyright © 2012 Peter W A Wood. All rights reserved.
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-C-int64!: alias struct! [
  low             [integer!]
  high            [integer!]
]

PWAW-C-compare-strings: func [
  ;; compares two strings byte by byte
  ;; returns logic! :
  ;;    true  - strings match
  ;;    false - strings do not match
  
  s1              [c-string!]
  s2              [c-string!]
  return:         [logic!]
  /local
  i               [integer!]
  size-s1         [integer!]
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

PWAW-C-diff64: func [
  ;; This function is based on code kindly supplied by copyright Nenad Rakocevic
  ;; copyright 2012 Nenad Rakocevic & Peter W A Wood
  ;; calculates the difference between 2 positive 64-bit little endian integers
  ;; the first must be larger than the second
  ;; the difference is returned via the third argument
  ;; returns integer!:
  ;;    0 - success
  ;;    1 - one of the arguments is negative
  ;;    2 - the second argument is bigger than the first
	a                 [PWAW-C-int64!] 
	b                 [PWAW-C-int64!]
	diff              [PWAW-C-int64!]
	return:           [integer!]
	/local  
	    offset        [integer!]
	    a-neg?        [logic!]
	    b-neg?        [logic!]
][
  a-neg?: false
  b-neg?: false
  
  ;; reject neagative numbers
	if any [
	  a/high < 0
	  b/high < 0
	][
	  return 1
	]
	
	;; check a is greater or equal to b
	if a/low < 0 [
	  a-neg?: true
	  a/low: a/low xor 80000000h
	]
	
	if b/low < 0 [
	  b-neg?: true
	  b/low: b/low xor 80000000h
	]
	  
	if any [
	  b/high > a/high
	  all [
	    b/high = a/high
	    any [
	      all [
	        b-neg?
	        not a-neg?
	      ]
	      all [
	        b-neg?
	        a-neg?
	        b/low > a/low
	      ]
	      all [
	        not a-neg?
	        not b-neg?
	        b/low > a/low
	      ]
	    ]
	  ]
	][
	  return 2
	]
	
	;; calculate the difference  
	diff/high: a/high - b/high
	diff/low: a/low - b/low
	offset: diff/low
	if negative? offset [offset: negate offset]
	if a/low < offset [diff/high: diff/high - 1]
	if all [
	  a-neg?
	  (not b-neg?)
	][
	  diff/low: diff/low or 80000000h
	]
	0
]

PWAW-C-load-int: func [
  ;; loads an integer from a string into the supplied integer
  ;; it assumes that the string is a valid integer literal
  ;; this is initial versions only handles decimal integers
  ;; returns integer! :
  ;;    0   - succesfully loaded
  ;;    1   - 1st argument not a c-string!
  ;;    2   - 2nd argument not a int-pointer!
  ;;    3   - 3rd argument not an integer!
  ;;    4   - 3rd argument not valid
  ;;    5   - 4th argument not an integer!
  ;;    6   - 4th argument not valid
  ;;    7   - Incorrect number of arguments supplied
  ;;    8   - only a sign input
  ;;
  ;; the function expects a c-string as the first argument
  ;; and an integer as it second.
  ;; optionally start and end positions can be specified as integers
  [typed]
  count           [integer!]
  list            [typed-value!]
  return:         [integer!]
  /local
    s             [c-string!]
    start         [integer!]
    end           [integer!]
    pos           [integer!]
    len           [integer!]
    i             [pointer! [integer!]]
    neg?          [logic!]
][
  if list/type <> type-c-string! [return 1]
  s: as c-string! list/value
  len: length? s
  
  list: list + 1
  if list/type <> type-int-ptr! [return 2]
  i: as pointer! [integer!] list/value
  
  switch count [
    2 [
      start: 1
      end: len
    ]
    4 [
      list: list + 1                            ;; ie 3rd argument
      if list/type <> type-integer! [return 3]
      start: list/value
      if any [
        start > len
        start < 1
      ][
        return 4
      ]
      list: list + 1
      if list/type <> type-integer! [return 5]
      end: list/value
      if any [
        end < start
        end > len
      ][
        return 6
      ]
    ]
    default [return 7]
  ]
  
  pos: start
  neg?: false
  if any [
    s/pos = #"-" 
    s/pos = #"+" 
  ][
    if pos = end [return 8]
    if s/pos = #"-" [neg?: true]
    pos: pos + 1
  ]
  i/value: 0 
  until [
    i/value: i/value * 10
    i/value: i/value + s/pos - 48
    pos: pos + 1
    pos > end
  ]
  if neg? [i/value: i/value * -1]
  0
]

PWAW-C-mold-int: func [
  ;; provides a literal representation of an integer in the supplied string
    
  i               [integer!]
  s               [c-string!]
  return:         [integer!]
  ;; returns:
  ;;      0 - successful conversion
  ;;      1 - supplied string too short

  /local
  digit           [integer!]
  digit-printed?  [logic!]
  divisor         [integer!]
  len             [integer!]
  pos             [integer!]
  rem             [integer!]
][
  len: length? s
  divisor: 1000000000
  digit-printed?: false
  
  if i = 0 [
      if len < 1 [return 1]
      s/1: #"0"
      s/2: null-byte
      return 0
  ]
  if i = -2147483648 [
    if len < 11 [return 1]
     s/1:  #"-"
     s/2:  #"2"
     s/3:  #"1"
     s/4:  #"4"
     s/5:  #"7"
     s/6:  #"4"
     s/7:  #"8"
     s/8:  #"3"
     s/9:  #"6"
     s/10: #"4"
     s/11: #"8"
     s/12: null-byte
     return 0
  ]
  rem: i
  pos: 1
  if rem < 0 [
    s/pos: #"-"
    pos: pos + 1
    rem: -1 * rem
  ]
  until [
    digit: rem / divisor
    either digit-printed? [
      s/pos: as byte! (digit + 48)
      pos: pos + 1
    ][
      if digit <> 0 [
        s/pos: as byte! (digit + 48)
         pos: pos + 1
        digit-printed?: true
      ]
    ]
    if pos > len [return 1]
    rem: rem - (digit * divisor)
    divisor: divisor / 10
    divisor = 0
  ]
  s/pos: null-byte
  0
]

PWAW-C-str-copy: func [
  ;; copies a  string
  in              [c-string!]
  out             [c-string!]
  return:         [integer!]
  ;; returns:
  ;;      0 - successful copy
  ;;      1 - supplied string too short
  /local
  i             [integer!]
][
  if in/1 = null-byte [
    out/1: null-byte
    return 0
  ]
  i: 1
  until [
    if out/i = null-byte [return 1]
    out/i: in/i
    i: i + 1
    in/i = null-byte
  ]
  out/i: null-byte
  0
]

PWAW-C-str-int?: func [
  ;; checks a string is a correct literal representation of an integer
  ;; this is initial versions only handles decimal literal
  ;; returns logic! :
  ;;    true  - string contains an integer
  ;;    false - string does not contain an integer
  ;; the function expects a c-string as the first argument
  ;; optionally start and end positions can be specified as integers
  [typed]
  count           [integer!]
  list            [typed-value!]
  return:         [logic!]
  /local
    s             [c-string!]
    start         [integer!]
    end           [integer!]
    pos           [integer!]
    len           [integer!]
    neg?          [logic!]
][
  neg?: false
  if list/type <> type-c-string! [return false]
  s: as c-string! list/value
  len: length? s
  
  switch count [
    1 [
      start: 1
      end: len
    ]
    3 [
      list: list + 1
      if list/type <> type-integer! [return false]
      start: list/value
      if any [
        start > len
        start < 1
      ][
        return false
      ]
      list: list + 1
      if list/type <> type-integer! [return false]
      end: list/value
      if any [
        end <= start
        end > len
      ][
        return false
      ]
    ]
    default [return false]
  ]
  len: end - start + 1
  pos: start
  either any [
    s/pos = #"-" 
    s/pos = #"+"  
  ][
    if any [
      pos = end
      len > 11
    ][
      return false
    ]
    if s/pos = #"-" [neg?: true]
    pos: pos + 1
  ][
    if len > 10 [return false] 
  ]
  until [
    if any [
      s/pos < #"0"
      s/pos > #"9"      
    ][return false]
    pos: pos + 1
    pos > end
  ]
  ;; now check for max-size
  s: s + start - 1                        ;; adjust the start of the string
  if neg? [
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


