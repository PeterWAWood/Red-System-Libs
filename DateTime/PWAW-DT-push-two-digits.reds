Red/System [
	Purpose:     "Push number as two digits into string"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011-2013 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

PWAW-DT-push-two-digits: func [
  {private}
  i [integer!]
  s [c-string!]
][
  if i < 10 [
    s/1: #"0"
    s: s + 1
  ]
  PWAW-C-mold-int i s
]

