#!/usr/bin/ruby

=begin 
  Purpose     Compiles IOUtils.pas
  Author      Peter W A Wood
  Version     0.0.2
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt

  Notes       Assumes stored in source dir and FPC is in path
=end

# get source directory
lib_dir = File.expand_path(File.dirname(__FILE__))

# use -k-no_order_limits on OS X until I move to XCode 4
compile_command = case
  when RUBY_PLATFORM.match(/darwin/): 'fpc -k-no_order_inits'
  else 'fpc'
end

# compile, relocate executable and run
system(compile_command + ' ' + lib_dir + '/IOUtils.pas') 
