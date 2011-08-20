#!/usr/bin/ruby

# builds and runs Red/System Libs tests
# requires the file path-to-Red.txt to be in the same directory

# extract the program name from the source file and
#  work out where everything is
source_file = ARGV[0]
pgm_name = File.basename(source_file, '.*')
pgm_path = File.expand_path(source_file)
pgm_dir = File.dirname(pgm_path)
runnable_dir = pgm_dir + '/Runnable/'
pgm = runnable_dir + '/' + pgm_name
reds_libs_dir = File.dirname(__FILE__)
compiler_dir = IO.read(reds_libs_dir + "/path-to-Red.txt").chomp + 'red-system/'

# make runnable directory if needed
if !File.directory? runnable_dir then
  Dir.mkdir runnable_dir
end

# change current to red/system compiler directory
Dir.chdir(compiler_dir)

# compile, relocate executable and run
if system('rebol rsc.r %' + pgm_path) then
  File.rename(compiler_dir + "builds/" + pgm_name, pgm)
  system(pgm)
end




