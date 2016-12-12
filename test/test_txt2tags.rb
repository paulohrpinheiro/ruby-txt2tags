require_relative '../lib/txt2tags'
require 'test/unit'
require 'stringio'

class TestInputParameter < Test::Unit::TestCase
  def test_string
    assert_equal('string input', Txt2Tags.new('string input').html)
  end

  def test_file
    assert_equal('file input', Txt2Tags.new(StringIO.new('file input')).html)
  end
end
