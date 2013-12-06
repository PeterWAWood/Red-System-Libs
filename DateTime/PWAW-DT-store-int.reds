Red/System [
	Purpose:     "Check and load an integer"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Core/PWAW-C-core.reds

PWAW-DT-store-int: func [
  {private}
  s           [c-string!]
  pi          [pointer! [integer!]]
  return:     [integer!]     
][
  either any [
    not PWAW-C-str-int? s 
    0 <> PWAW-C-load-int s pi
  ][1][0]
]
