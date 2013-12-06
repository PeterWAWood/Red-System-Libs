Red/System [
	Purpose:     "Pushes three characters onto string"
	Author:      "Peter W A Wood"
	Version:     0.2.0
	Rights:      "Copyright © 2011-2103 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-DT-push-month: func [
  {private}
  s [c-string!]
  a [byte!]
  b [byte!]
  c [byte!]
][
  s/1: a
  s/2: b
  s/3: c
]

