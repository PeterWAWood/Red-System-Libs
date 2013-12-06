Red/System [
	Purpose:     "Mold a date"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011-2103 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

#include %PWAW-DT-date.def

PWAW-DT-mold-date: func [
  {Provides a string representation of a date}
  d               [PWAW-DT-date!]         {the date}
  md              [c-string!]             
    {a string of at least 26 characters in
     which the molded date will be returned}
  return:         [integer!]
  {    0 - successful
       1 - provided string too short
       2 - invalid month
  }
  /local
  i             [integer!]
  pos           [integer!]
][
  if 26 > length? md [return 1]
  pos: 1
  PWAW-C-mold-int d/day md
  either d/day < 10 [md: md + 1] [md: md + 2]
  md/1: #"-"
  md: md + 1
  switch d/month [
    1       [PWAW-DT-push-month md #"J" #"a" #"n"]
    2       [PWAW-DT-push-month md #"F" #"e" #"b"]
    3       [PWAW-DT-push-month md #"M" #"a" #"r"]
    4       [PWAW-DT-push-month md #"A" #"p" #"r"]
    5       [PWAW-DT-push-month md #"M" #"a" #"y"]
    6       [PWAW-DT-push-month md #"J" #"u" #"n"]
    7       [PWAW-DT-push-month md #"J" #"u" #"l"]
    8       [PWAW-DT-push-month md #"A" #"u" #"g"]
    9       [PWAW-DT-push-month md #"S" #"e" #"p"]
    10      [PWAW-DT-push-month md #"O" #"c" #"t"]
    11      [PWAW-DT-push-month md #"N" #"o" #"v"]
    12      [PWAW-DT-push-month md #"D" #"e" #"c"]
    default [return 2]
  ]
  md: md + 3
  md/1: #"-"
  md: md + 1
  PWAW-C-mold-int d/year md 
  md: md + 4
  md/1: #"/"
  md: md + 1
  PWAW-DT-push-two-digits d/hour md
  md: md + 2
  md/1: #":"
  md: md + 1
  PWAW-DT-push-two-digits d/minutes md
  md: md + 2
  md/1: #":"
  md: md + 1
  PWAW-DT-push-two-digits d/seconds md
  md: md + 2
                                      ;; Note: a time zone with 0 hours and 
                                      ;; negative minutes would be incorrectly
                                      ;; molded. There is currently no such
                                      ;; time zone.
  either d/tz-hours >= 0 [
    md/1: #"+"
    md: md + 1
  ][
    md/1: #"v"                        ;; write over the null-byte added by
                                      ;;  mold-int
  ]
  PWAW-C-mold-int d/tz-hours md
  case [
    d/tz-hours < -9 [md: md + 3]
    d/tz-hours < 0  [md: md + 2]
    d/tz-hours > 10 [md: md + 2]
    true            [md: md + 1]
  ]
  md/1: #":"
  md: md + 1
  PWAW-DT-push-two-digits d/tz-minutes md
  
  0
]
