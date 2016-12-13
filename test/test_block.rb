require_relative 'helper_test'

class TestBlocks  < Test::Unit::TestCase
  def test_html_output_quote
    assert_equal("<blockquote>\n Quote\n</blockquote>\n", Txt2Tags.new(" Quote\n").html5)
  end

  def test_html_output_verbatim
    assert_equal("<pre>\nVERBATIM\nverbatim 1\nverbatim 2\n</pre>\n", Txt2Tags.new("```\nVERBATIM\nverbatim 1\nverbatim 2\n```\n").html5)
  end
end
