require_relative '../lib/txt2tags'
require 'test/unit'
require 'stringio'

class TestInputParameter < Test::Unit::TestCase
  def test_string
    assert_equal("string input", Txt2Tags.new("string input").html5)
  end

  def test_file
    assert_equal("file input", Txt2Tags.new(StringIO.new("file input")).html5)
  end
end

class TestRuleComments < Test::Unit::TestCase
  def test_remove_comment
    assert_equal(
      "Without comment\nNo comments...",
      Txt2Tags.new("Without comment\n%Comment!\nNo comments...").html5
    )
  end

  def test_mantain_line_with_percente_simbol_not_in_line_begin
    assert_equal(
      "Without comment\n %This isnt a Comment!\nNo comments...",
      Txt2Tags.new("Without comment\n %This isnt a Comment!\nNo comments...").html5
    )
  end

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
