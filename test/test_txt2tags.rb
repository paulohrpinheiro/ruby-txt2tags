require_relative '../lib/txt2tags'
require 'test/unit'
require 'stringio'

class TestInputParameter < Test::Unit::TestCase
  def test_string
    assert_equal("string input", Txt2Tags.new("string input").html)
  end

  def test_file
    assert_equal("file input", Txt2Tags.new(StringIO.new("file input")).html)
  end
end

class TestRuleComments < Test::Unit::TestCase
  def test_remove_comment
    assert_equal(
      "Without comment\nNo comments...",
      Txt2Tags.new("Without comment\n%Comment!\nNo comments...").html
    )
  end

  def test_mantain_line_with_percente_simbol_not_in_line_begin
    assert_equal(
      "Without comment\n %This isnt a Comment!\nNo comments...",
      Txt2Tags.new("Without comment\n %This isnt a Comment!\nNo comments...").html
    )
  end
end
