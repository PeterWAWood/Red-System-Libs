#!/usr/bin/ruby

=begin 
  Purpose     Tests for IOUtils/readlnstdin
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt
=end

require 'test/unit'

# work out absolute file path for red/system executable
tests_dir = File.expand_path(File.dirname(__FILE__))
@@auto_dir = tests_dir + '/Auto'

class TestLib < Test::Unit::TestCase

  @exec_path

  def setup 
    @exec_path = 'arch -i386 ruby ' + @@auto_dir + '/IOUtils_main.rb readlnstdin'
  end

  def exec_func(len, str, input)
    actual = %x{echo #{input} | #{@exec_path} #{len} #{str}}
    assert_equal(0, $?.exitstatus)
    puts actual
    actual
  end
  
  def test_readlnstdin_1
    result = exec_func(5, 'abcde', 'fghij')
    assert_equal(5, result.length)
    assert_equal('fghij', result)
  end
  
  def test_readlnstdin_2
    result = exec_func(0, 'abcde', 'fghij')
    assert_equal(0, result.length)
    assert_equal('', result)
  end
  
  def test_readlnstdin_3
    result = exec_func(5, 'abcde', 'fghijklmno')
    assert_equal(5, result.length)
    assert_equal('fghij', result)
  end
  
  def test_readlnstdin_4
    # NOTE - if length requested is longer than supplied string 
    #      - memory contents will be overwritten
    result = exec_func(10, 'abcde', 'fghijklmno')
    assert_equal(10, result.length)
    assert_equal('fghijklmno', result)
  end
  
end


