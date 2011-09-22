Red/System [
  Purpose     A basic IO library
  Author      Peter W A Wood
  Version     0.0.3
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3        
              (https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt)
]

#import [
  "/users/peter/Code/Red-System/Red-System-Libs/IO-Utils/libIOUtils.dylib" cdecl [                    
                                    ;; replace ###lib_path### with the absolute
                                    ;;  path to IOUtils library
    readlnstdin: "readlnstdin" [
      len       [integer!]
      str       [c-string!]
      return:   [integer!]
    ]
  ]
]

#define PWAW-IO-EOF 0
#define PWAW-IO-OK  1

PWAW-IO-readln: func [
                                              ;; reads a line from stdin
                                              ;;  the carriage return is
                                              ;;  excluded
  
  max-len       [integer!]                    ;; max length of string required
                                              ;;  excluding null terminator
  
  str           [c-string!]                   ;; string for result
  return:       [integer!]
][
  readlnstdin max-len str
]