Red/System [
  Purpose     A basic date-time library
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3        
              (https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt)
]

PWAW-DT-date!: alias struct! [
  year              [integer!]
  month             [integer!]
  day               [integer!]
  hour              [integer!]
  minutes           [integer!]
  seconds           [integer!]
  microseconds      [integer!]
  tz-hours          [integer!]
  tz-minutes        [integer!]
  day-of-week       [integer!]
  day-of-year       [integer!]
]

#switch OS [
	#default [#include %date-time-libc.reds]
]

;; These functions are defined in the date-time os modules:
;;
;;  PWAW-DT-now
;;    result        PWAW-DT-date!
;;    return:       integer!
;;  fills the result structure argument with details of the current date/time
;;  returns:
;;        0 - successful
;;        1 - cannot retrieve time from os
;;        2 - cannot convert the machine time


