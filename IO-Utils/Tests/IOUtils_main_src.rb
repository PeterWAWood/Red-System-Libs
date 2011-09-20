#!/usr/bin/ruby

=begin 
  Purpose     A test harness for IOUtils lib
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt
=end

require 'ffi'

## specify the interface
module IO_Utils
  extend FFI::Library
  ffi_lib '###lib_path###'
  attach_function 'readlnstdin', [ :int, :pointer], :void
end

## Process the command line arguments and call relevant method

case ARGV[0] 
  when "readlnstdin"
    len = ARGV[1].to_i
    str = ARGV[2]
    IO_Utils.readlnstdin(len, str)
    puts str.slice(0, str.index(0))     # print only up to and including
                                        # the null terminator
  else
    puts "no such function"
end