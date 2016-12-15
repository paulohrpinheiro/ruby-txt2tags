require_relative 'helper_test'

# Test formating titles
class TestTitles < NullFormatHelper
  def test_html_output_title1_rule
    assert_equal 'T1_Title 1_T1', output('= Title 1 =')
  end

  def test_html_output_title2_rule
    assert_equal 'T2_Title 2_T2', output('== Title 2 ==')
  end

  def test_html_output_title3_rule
    assert_equal 'T3_Title 3_T3', output('=== Title 3 ===')
  end
end
