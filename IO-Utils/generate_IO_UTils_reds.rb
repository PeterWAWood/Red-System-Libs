#!/usr/bin/ruby

=begin 
  Purpose     Generates IO_Utils.reds from IO_Utils.src
               inserting the full path to the library
  Author      Peter W A Wood
  Version     0.0.2
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt

=end

## get source director, assemble path to lib
lib_dir = File.expand_path(File.dirname(__FILE__))
# work out the name of IOUtils library, default to libIOUtils.so
lib_name = case
  when RUBY_PLATFORM.match(/darwin/): '/libIOUtils.dylib'
  when RUBY_PLATFORM.match(/mswin/): '/IOUtils.dll'
  else '/libIOUtils.so'
end
lib_path = lib_dir + lib_name

## make the substition
source = IO.read(lib_dir + '/IO-Utils-src.reds')
source.sub!(/###lib_path###/, lib_path)
out_file = File.new(lib_dir + '/IO-Utils.reds', 'w')
out_file.write(source)
out_file.close