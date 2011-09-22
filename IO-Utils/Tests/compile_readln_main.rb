#!/usr/bin/ruby

=begin 
  Purpose     Compiles readln-main
  Author      Peter W A Wood
  Version     0.0.3
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt

  Notes       Requires access to the file path-to-Red.txt.
=end

## work out where everything is
tests_dir = File.expand_path(File.dirname(__FILE__))
red_system_libs_dir = tests_dir.sub(/IO-Utils\/Tests/, '')
# create a string of the path to the absolute path to the library in POSIX format
lib_path = File.join(red_system_libs_dir, 'IO-Utils', 'IO-Utils.reds').to_s
if RUBY_PLATFORM.match(/mingw32/) then                      
  lib_path.sub!(/[cC]:/, '/C')
  lib_path.gsub!(/\\/, '//')
end
compiler_dir = IO.read(File.join(red_system_libs_dir, 'path-to-red-system.txt'))
runnable_dir = File.join(red_system_libs_dir, 'Runnable')
auto_dir = File.join(tests_dir, 'Auto')
if !File.directory? runnable_dir then
  Dir.mkdir runnable_dir
end

## insert the correct lib path in the source
source = IO.read(File.join(tests_dir, 'readln-main-src.reds'))
source.sub!(/###lib-path###/, lib_path)
out_file = File.new(File.join(auto_dir, 'readln-main.reds'), 'w')
out_file.write(source)
out_file.close

## change current to red/system compiler directory
#   required by the compiler
current_dir = Dir.getwd
Dir.chdir(compiler_dir)
  
## compile and move the executable to the Runnable dir
src_path = File.join(auto_dir, 'readln-main.reds').to_s
built_path = File.join(compiler_dir, 'builds', 'readln-main')
runnable_path = File.join(runnable_dir, 'readln-main')
if RUBY_PLATFORM.match(/mingw32/) then           
  src_path.sub!(/[cC]:/, '/c')                  # ensure POSIX format
  src_path.gsub!(/\\/, '//')
  built_path += '.exe'                          # add winodws file extensions
  runnable_path += '.exe'
end
File.delete(runnable_path) if File.exists?(runnable_path) 
if system('rebol -q rsc.r %' + src_path) then
  File.rename(built_path, runnable_path)
end

## go back to the original working directory
Dir.chdir(current_dir)
