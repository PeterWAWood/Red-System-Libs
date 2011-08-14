Red/System [
	Title:   "utf-8-utilities"
	Author:  "Peter W A Wood"
	File: 	 %utf-8-utils.reds
	Version: 0.0.1
	Rights:  "Copyright (C) 2011 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
]

PWAW-UU-verify: func [
  str [c-string!]
  return: [integer!]
  /local
  i [integer!]
][
  
  valid-multi-byte?: func [
    b [byte!]
    return: [logic!]
  ][
    not any [b < #"^(80)" b > #"^(BF)"]
  ]
  
  i: 1
  
  until [
    if str/1 > #"^(7F)" [                          ;; not ASCII ?

      ;; invalid characters
      if any [
          #"^(C0)" = str/1
          #"^(C1)" = str/1
          #"^(F4)" < str/1
      ][
          return i
      ]
      ;; two-byte characters
      either str/1 < #"^(E0)" [
        unless valid-multi-byte? str/2 [return i]       
        i: i + 1
        str: str + 1
      ][
      ;; three-byte characters
        either str/1 < #"^(F0)" [
          unless all [
              valid-multi-byte? str/2
              valid-multi-byte? str/3
          ][
              return i
          ]
          i: i + 2
          str: str + 2
        ][
      ;; four-byte-characters
          unless all [
              valid-multi-byte? str/2
              valid-multi-byte? str/3
              valid-multi-byte? str/4
          ][
              return i
          ]
          i: i + 3
          str: str + 3
        ]
      ]   
    ]
    i: i + 1
    str: str + 1
    str/1 = null-byte
  ]
  0
]

