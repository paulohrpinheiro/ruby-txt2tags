require_relative 'helper_test'

class TestTarget < Test::Unit::TestCase
  def test_has_all_marks
    all_marks = Txt2Tags::marks_content.keys.sort
    Txt2Tags::targets_content.keys.each do |t|
      assert_equal(all_marks, Txt2Tags::targets_content[t].keys.sort,
       "#{t} does not contain all the marks.")
    end
  end
end
