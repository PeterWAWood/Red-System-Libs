#!/usr/bin/ruby

=begin 
  Purpose     Creates a ruby script for testing IOUtils directly
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt
=end

# work out the name of IOUtils library, default to libIOUtils.so
lib_name = case
  when RUBY_PLATFORM.match(/darwin/): 'libIOUtils.dylib'
  when RUBY_PLATFORM.match(/mswin/): 'IOUtils.dll'
  else 'libIOUtils.so'
end

## work out where everything is
tests_dir = File.expand_path(File.dirname(__FILE__))
red_system_libs_dir = tests_dir.sub(/IO-Utils\/Tests/, '')
lib_path = red_system_libs_dir + 'IO-Utils/' + lib_name
auto_dir = tests_dir + '/Auto'
if !File.directory? auto_dir then
  Dir.mkdir auto_dir
end

## generate source and save it in Auto dir
source = IO.read(tests_dir + '/IOUtils_main_src.rb')
source.sub!(/###lib_path###/, lib_path)
out_file = File.new(auto_dir + '/IOUtils_main.rb', 'w')
out_file.write(source)
out_file.close
