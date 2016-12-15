require_relative 'helper_test'

# Test if comments are proprerly processed
class TestComments < NullFormatHelper
  def test_remove_comment
    assert_equal\
      "Without comment\nNo comments...",
      output("Without comment\n%Comment!\nNo comments...")
  end

  def test_mantain_line_with_percente_simbol_not_in_line_begin
    assert_equal\
      "Without comment\nThis % isnt a Comment!\nNo comments...",
      output("Without comment\nThis % isnt a Comment!\nNo comments...")
  end
end
