#!/usr/bin/ruby

=begin 
  Purpose     Builds and runs Red/System Library Core tests
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2012 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt
=end

def run_test src
  system("../../run-test.rb " + src)
end

run_test "compare-strings-test.reds"
run_test "diff64-test.reds"
run_test "load-int-test.reds"
run_test "mold-int-test.reds"
run_test "str-copy-test.reds"
run_test "str-int-test.reds"



