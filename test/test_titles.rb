require_relative 'helper_test'

class TestTitles  < Test::Unit::TestCase
  def test_html_output_title1_rule
    assert_equal("<h2>Title 1</h2>", Txt2Tags.new("= Title 1 =").html5)
  end

  def test_html_output_title2_rule
    assert_equal("<h3>Title 2</h3>", Txt2Tags.new("== Title 2 ==").html5)
  end

  def test_html_output_title3_rule
    assert_equal("<h4>Title 3</h4>", Txt2Tags.new("=== Title 3 ===").html5)
  end
end
