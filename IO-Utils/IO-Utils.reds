Red/System [
  Purpose     A basic IO library
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3        
              (https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt)
]

#import [
  "/Users/peter/Code/Red-System/Red-System-Libs/IO-Utils/libIOUtils.dylib" cdecl [                    ;; replace ###lib_path### with
                                              ;;  the absolute path to IOUtils
                                              ;;  library
    readlnstdin: "readlnstdin" [
      len     [integer!]
      str     [c-string!]
    ]
  ]
]

PWAW-IO-read-ln-stdin: func [
                                              ;; reads a line from stdin
                                              ;;  the carriage return is
                                              ;;  excluded
  
  max-len [integer!]                          ;; max length of string required
                                              ;;  excluding null terminator
  
  str [c-string!]                             ;; string for result
][
  readlnstdin max-len str
]