Red/System [
  Purpose:    "Test harness for IOUtils/readln"
  Author:     "Peter W A Wood"
  Version:    0.0.1
  Rights:     "Copyright © 2011 Peter W A Wood. All rights reserved."
  License:    "BSD-3"        
  See:        "(https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt)"
]

;; Placeholder for the full file path to IO-Utils.reds
#include %###lib-path###

;; crude str-to-int
str-to-int: func [
  str         [c-string!]
  return:     [integer!]
  /local
    i         [integer!]
    int       [integer!]
][
  i: 1
  int: 0
  until [
    int: int * 10
    int: int + as-integer str/1 - 48
    i: i + 1
    str/i = null-byte
  ]
  int
]

args: system/args-list

;; convert the requested length to an integer 
args: args + 1
len: str-to-int args/item

;; get the target string
args: args + 1
str: args/item

;; library call with 2 or 3 arguments
args: args + 1
either args/item = null [
  PWAW-IO-Utils/readln [len str]  
][
  ;; convert file handle
  fh: str-to-int args/item
  PWAW-IO-Utils/readln [len str fh] 
]

print str