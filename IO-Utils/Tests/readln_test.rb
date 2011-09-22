#!/usr/bin/ruby

=begin 
  Purpose     Tests for IOUtils/readlnstdin
  Author      Peter W A Wood
  Version     0.0.3
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt
=end

require 'test/unit'

# work out absolute file path for red/system executable
tests_dir = File.expand_path(File.dirname(__FILE__))
red_system_libs_dir = tests_dir.sub(/IO-Utils\/Tests/, '')
@@runnable_dir = File.join(red_system_libs_dir, 'Runnable')

class TestLib < Test::Unit::TestCase

  @exec_path

  def setup 
    @exec_path = File.join(@@runnable_dir, 'readln-main')
    @exec_path.gsub!(/\//,"\\") if RUBY_PLATFORM.match(/mingw32/)
  end

  def exec_func(len, str, input)
    actual = %x{echo #{input} | #{@exec_path} #{len} #{str}}
    assert_equal(0, $?.exitstatus)
    actual.split('||')
  end
  
  def test_dummy
  end
  
end

class TestCons < TestLib

  def test_readlnstdin_1
    result = exec_func(5, 'abcde', 'fghij')
    assert_equal("0", result[0])
    assert_equal('fghij', result[1])
  end
  
  def test_readlnstdin_2
    result = exec_func(0, 'abcde', 'fghij')
    assert_equal("0", result[0])
    assert_equal(nil, result[1])      # The string is empty so the split method
                                      #  does not create an entry
  end
  
  def test_readlnstdin_3
    result = exec_func(5, 'abcde', 'fghijklmno')
    assert_equal("0", result[0])
    assert_equal('fghij', result[1])
  end
  
  def test_readlnstdin_4
    # NOTE - if length requested is longer than supplied string 
    #      - memory contents will be overwritten
    result = exec_func(10, 'abcde', 'fghijklmno')
    assert_equal("0", result[0])
    assert_match(/fghijklmno/, result[1])
  end
  
end

class TestFile < TestLib
  
  def setup
    super
    test_file = File.new('stdin.txt', 'w')
    test_file.write("abcde\nfghijkl\nqwerty\n")
    test_file.close
  end
  
  def teardown
    File.delete('stdin.txt') if File.exists?('stdin.txt') 
  end

  def exec_file(len, str, l1, s1, l2, s2)
    actual = %x{#{@exec_path} #{len} #{str}  #{l1} #{s1} #{l2} #{s2} < stdin.txt}
    assert_equal(0, $?.exitstatus)
    actual.split('||')
  end
  
  def test_readln_pipe1
    result = exec_file(5, '12345', '', '', '', '')
    assert_equal("1", result[0])
    assert_equal('abcde', result[1])
  end
  
  def test_readln_pipe2
    result = exec_file(5, '12345', 7, '1234567', '', '')
    assert_equal("1", result[0])
    assert_equal('fghijkl', result[1])
  end
  
  def test_readln_pipe2
    result = exec_file(5, '12345', 7, '1234567', '6', '123456')
    assert_equal("0", result[0])
    assert_equal('qwerty', result[1])
  end
  
end


