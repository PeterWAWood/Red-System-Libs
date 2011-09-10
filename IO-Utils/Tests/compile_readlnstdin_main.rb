#!/usr/bin/ruby

=begin 
  Purpose     Compiles both readlnstdin_main & readlnstdin-main
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt

  Notes       Requires access to the file path-to-Red.txt.
=end

## constants
LIBRARY = true
INCLUDE = false

## source substitution definitiions
@@lib_def = <<END_LIB_DEF
#import [
  "###lib_path###" cdecl [
    readlnstdin: "readlnstdin" [
      len     [integer!]
      str     [c-string!]
    ]
  ]
]
END_LIB_DEF

@@inc_def = <<END_INC_DEF
#include %"###inc_path###"
END_INC_DEF

# work out the name of IOUtils library, default to libIOUtils.so
@@lib_name = case
  when RUBY_PLATFORM.match(/darwin/): 'libIOUtils.dylib'
  when RUBY_PLATFORM.match(/mswin/): 'IOUtils.dll'
  else 'libIOUtils.so'
end

## method to generate source and compile it
def compile(library)
  # make substitutions
  source = IO.read(@@tests_dir + '/readlnstdin_main.reds')
  if library then
    source.sub!(/###import###/, @@lib_def)
    source.sub!(/###include###/, '')
    source.sub!(/###lib_path###/, @@lib_path)
    source.sub!(/###call_name###/, 'readlnstdin')
    out_file = File.new(@@auto_dir + '/readlnstdin_main.reds', 'w')
    out_file.write(source)
    out_file.close
  else
    source.sub!(/###import###/, '')
    source.sub!(/###include###/, @@inc_def)
    source.sub!(/###inc_path###/, @@inc_path)
    source.sub!(/###call_name###/, 'PWAW-IO-read-ln-stdin')
    out_file = File.new(@@auto_dir + '/readlnstdin_main.reds', 'w')
    out_file.write(source)
    out_file.close
  end
  exec_name = case
    when library: '/readlnstdin_main'
    else '/readlnstdin-main'
  end
  puts exec_name
  if system('rebol -q rsc.r %' + @@auto_dir + '/readlnstdin_main.reds') then
    File.rename(@@compiler_dir + 'builds/readlnstdin_main', @@auto_dir + exec_name)
  end
end

## work out where everything is
@@tests_dir = File.expand_path(File.dirname(__FILE__))
@@red_system_libs_dir = @@tests_dir.sub(/IO-Utils\/Tests/, '')
@@lib_path = @@red_system_libs_dir + 'IO-Utils/' + @@lib_name
@@inc_path = @@red_system_libs_dir + 'IO-Utils/IO-Utils.reds'
@@compiler_dir = IO.read(@@red_system_libs_dir + "path-to-Red.txt").chomp + 'red-system/'
@@auto_dir = @@tests_dir + '/Auto'
if !File.directory? @@auto_dir then
  Dir.mkdir @@auto_dir
end

# change current to red/system compiler directory
#   required by the compiler
Dir.chdir(@@compiler_dir)

# compile and relocate executable
compile(LIBRARY)
compile(INCLUDE)
