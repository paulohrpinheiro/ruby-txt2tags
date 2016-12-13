require_relative 'helper_test'

class TestTarget < Test::Unit::TestCase
  def test_has_all_marks
    txt2tags = Txt2Tags.new ''
    all_marks = txt2tags.marks.keys.sort
    txt2tags.targets.keys.each do |t|
      assert_equal(all_marks, txt2tags.targets[t].keys.sort,
       "#{t} does not contain all the marks.")
    end
  end
end
