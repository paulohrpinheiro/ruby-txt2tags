require_relative 'helper_test'

# Verify if all marks in class are implement in target drivers
class TestTarget < Test::Unit::TestCase
  def test_has_all_marks
    txt2tags = Txt2Tags.new('')

    [:BEAUTIFIERS, :TITLES, :BLOCKS].each do |type|
      must_have = Txt2Tags.const_get(type).keys.sort

      txt2tags.formats.each do |file|
        driver = txt2tags.load_format(file)

        assert_equal must_have, driver.const_get(type).keys.sort,
                     "#{driver} does not contain all the #{type} marks."
      end
    end
  end
end
