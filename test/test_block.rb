require_relative 'helper_test'

# Test formatting blocks
class TestBlocks < NullFormatHelper
  def test_html_output_quote
    assert_equal\
      "BEGIN_QUOTE\nQuote\nEND_QUOTE",
      output("\t\t\t\tQuote\n")
  end

  def test_html_output_verbatim
    assert_equal\
      "BEGIN_VERBATIM\nVERBATIM\nverbatim 1\nverbatim 2\nEND_VERBATIM",
      output("```\nVERBATIM\nverbatim 1\nverbatim 2\n```")
  end
end
