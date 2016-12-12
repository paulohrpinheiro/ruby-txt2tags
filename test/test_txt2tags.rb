require_relative 'helper_test'

class TestInputParameter < Test::Unit::TestCase
  def test_string
    assert_equal("string input", Txt2Tags.new("string input").html5)
  end

  def test_file
    assert_equal("file input", Txt2Tags.new(StringIO.new("file input")).html5)
  end
end
