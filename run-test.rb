#!/usr/bin/ruby

=begin 
  Purpose     Builds and runs Red/System Library tests
  Author      Peter W A Wood
  Version     0.0.4
  Rights      Copyright © 2011-2013 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt
  Notes       Requires the file path-to-red.txt to be in the same directory.
=end

# extract the program name from the source file and
#  work out where everything is
source_file = ARGV[0]
pgm_name = File.basename(source_file, '.*')
pgm_path = File.expand_path(source_file)
pgm_dir = File.dirname(pgm_path)
runnable_dir = File.join(File.expand_path(File.dirname(__FILE__)),'Runnable')
pgm = File.join(runnable_dir, pgm_name)
reds_libs_dir = File.dirname(__FILE__)
compiler_dir = IO.read(File.join(reds_libs_dir, 'path-to-red.txt'))

# make runnable directory if needed
if !File.directory? runnable_dir then
  Dir.mkdir runnable_dir
end

# compile, relocate executable and run
if system('rebol -qs '+ compiler_dir + 'red.r -o ' + pgm + ' ' + pgm_path) then
  system(pgm)
end
