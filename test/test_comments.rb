require_relative 'helper_test'

class TestComments < Test::Unit::TestCase
  def test_remove_comment
    assert_equal(
      "Without comment\nNo comments...",
      Txt2Tags.new("Without comment\n%Comment!\nNo comments...").html5
    )
  end

  def test_mantain_line_with_percente_simbol_not_in_line_begin
    assert_equal(
      "Without comment\nThis % isnt a Comment!\nNo comments...",
      Txt2Tags.new("Without comment\nThis % isnt a Comment!\nNo comments...").html5
    )
  end
end
