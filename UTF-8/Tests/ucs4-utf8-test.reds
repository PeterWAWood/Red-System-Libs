Red/System [
	Title:   "ucs-4 to utf-8 unit tests"
	Author:  "Peter W A Wood"
	File: 	 %ucs4-utf8-test.reds
	Version: 0.0.1
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
]

#include %/Users/peter/VMShare/Code/Red-System/Red-System-Libs/UTF-8/ucs4-utf8.reds
#include %/Users/peter/VMShare/Languages/Red/quick-test/quick-test.reds

~~~start-file~~~ "ucs4-utf8"

		
	--test-- "ucs4-utf8-1"
		utf8: PWAW-ucs4-utf8 0
	--assert (as byte! 0) = utf8/1
	--assert (as byte! 0) = utf8/2
	--assert (as byte! 0) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-2"
		utf8: PWAW-ucs4-utf8 10
	--assert (as byte! 10) = utf8/1
	--assert (as byte! 0) = utf8/2
	--assert (as byte! 0) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-3"
		utf8: PWAW-ucs4-utf8 100
	--assert (as byte! 100) = utf8/1
	--assert (as byte! 0) = utf8/2
	--assert (as byte! 0) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-4"
		utf8: PWAW-ucs4-utf8 255
	--assert (as byte! 255) = utf8/1
	--assert (as byte! 0) = utf8/2
	--assert (as byte! 0) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-5"
		utf8: PWAW-ucs4-utf8 256
	--assert (as byte! C4h) = utf8/1
	--assert (as byte! 80h) = utf8/2
	--assert (as byte! 0) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-6"
		utf8: PWAW-ucs4-utf8 07FFh
	--assert (as byte! DFh) = utf8/1
	--assert (as byte! BFh) = utf8/2
	--assert (as byte! 0) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-7"
		utf8: PWAW-ucs4-utf8 0800h
	--assert (as byte! E0h) = utf8/1
	--assert (as byte! A0h) = utf8/2
	--assert (as byte! 80h) = utf8/3
	--assert (as byte! 0) = utf8/4
	
	--test-- "ucs4-utf8-8"
		utf8: PWAW-ucs4-utf8 7FFFh
	--assert (as byte! E7h) = utf8/1
	--assert (as byte! BFh) = utf8/2
	--assert (as byte! BFh) = utf8/3
	--assert (as byte! 0) = utf8/4
      
~~~end-file~~~
