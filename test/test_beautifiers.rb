require_relative 'helper_test'

class TestBeautifiers <  Test::Unit::TestCase
  def test_html_output_monospace_rule
    assert_equal("<pre>monospace</pre>", Txt2Tags.new("``monospace``").html5)
  end

  def test_html_output_bold_rule
    assert_equal("<strong>bold</strong>", Txt2Tags.new("**bold**").html5)
  end

  def test_html_output_italic_rule
    assert_equal("<em>italic</em>", Txt2Tags.new("//italic//").html5)
  end

  def test_html_output_underline_rule
    assert_equal("<span style=\"text-decoration: underline;\">underline</span>", Txt2Tags.new("__underline__").html5)
  end

  def test_html_output_strike_rule
    assert_equal("<span style=\"text-decoration: line-through;\">strike</span>", Txt2Tags.new("--strike--").html5)
  end
end
