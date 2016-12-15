require_relative 'helper_test'

# Null format driverr - a template for new drivers
class TestInputParameter < NullFormatHelper
  def test_string
    assert_equal 'string input', output('string input')
  end

  def test_file
    assert_equal 'file input', output(StringIO.new('file input'))
  end
end
