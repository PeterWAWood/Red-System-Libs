Red/System [
  Purpose:    "Test harness for IOUtils/readlnstdin"
  Author:     "Peter W A Wood"
  Version:    0.0.1
  Rights:     "Copyright © 2011 Peter W A Wood. All rights reserved."
  License:    "BSD-3"        
  See:        "(https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt)"
]


###include###

args: system/args-list
args: args + 1
len-str: args/item
i: 1
len: 0
until [
  len: len * 10
  len: len + as-integer len-str/i - 48
  i: i + 1
  len-str/i = null-byte
]
args: args + 1
str: args/item
###call_name### len str
print str