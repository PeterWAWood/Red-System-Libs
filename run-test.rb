#!/usr/bin/ruby

# builds and runs Red/System Libs tests
# it must be run from the dir which contains the testfile

puts ARGV[0]

source_file = ARGV[0]
pgm_name = source_file[0, source_file.index('.')]
current_dir = Dir.getwd
puts current_dir
runnable_dir = current_dir + '/Runnable/'
pgm = runnable_dir + pgm_name
compiler_dir = IO.read("../../path-to-Red.txt").chomp + 'red-system/'

# make runnable directory if needed
if !File.directory? runnable_dir then
  Dir.mkdir runnable_dir
end

# change current to red/system compiler directory
Dir.chdir(compiler_dir)

# compile, relocate execuatble and run

if system('rebol rsc.r %' + current_dir + '/' + source_file) then
  File.rename(compiler_dir + "builds/" + pgm_name, pgm)
  system(pgm)
end


