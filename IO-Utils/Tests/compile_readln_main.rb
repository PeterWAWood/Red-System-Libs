#!/usr/bin/ruby

=begin 
  Purpose     Compiles readln-main
  Author      Peter W A Wood
  Version     0.0.2
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt

  Notes       Requires access to the file path-to-Red.txt.
=end

# work out where everything is
tests_dir = File.expand_path(File.dirname(__FILE__))
red_system_libs_dir = tests_dir.sub(/IO-Utils\/Tests/, '')
lib_path = red_system_libs_dir + 'IO-Utils/IO-Utils.reds'
inc_path = red_system_libs_dir + 'IO-Utils/IO-Utils.reds'
compiler_dir = IO.read(red_system_libs_dir + "path-to-Red.txt").chomp + 'red-system/'
auto_dir = tests_dir + '/Auto'
if !File.directory? auto_dir then
  Dir.mkdir auto_dir
end

# insert the correct lib path in the source
source = IO.read(tests_dir + '/readln-main-src.reds')
source.sub!(/###lib-path###/, lib_path)
out_file = File.new(auto_dir + '/readln-main.reds', 'w')
out_file.write(source)
out_file.close

# change current to red/system compiler directory
#   required by the compiler
Dir.chdir(compiler_dir)
  
# compile and move the executable to the Tests/Auto dir  
if system('rebol -q rsc.r %' + auto_dir + '/readln-main.reds') then
  File.rename(compiler_dir + 'builds/readln-main', auto_dir + '/readln-main')
end
