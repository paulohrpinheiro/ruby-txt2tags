require_relative 'helper_test'

# Test beautifiers formatation
class TestBeautifiers < NullFormatHelper
  def test_html_output_monospace_rule
    assert_equal 'm_monospace_m', output('``monospace``')
  end

  def test_html_output_bold_rule
    assert_equal 'b_bold_b', output('**bold**')
  end

  def test_html_output_italic_rule
    assert_equal 'i_italic_i', output('//italic//')
  end

  def test_html_output_underline_rule
    assert_equal 'u_underline_u', output('__underline__')
  end

  def test_html_output_strike_rule
    assert_equal 's_strike_s', output('--strike--')
  end

  def test_html_output_link_rule
    assert_equal\
      'L_Ruby Site||https://www.ruby-lang.org_L',
      output('[Ruby Site https://www.ruby-lang.org]')
  end

  def test_html_output_image_rule
    assert_equal\
      'I_http://pudim.com.br/pudim.jpg_I',
      output('[http://pudim.com.br/pudim.jpg]')
  end
end
