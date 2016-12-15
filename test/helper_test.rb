require_relative '../lib/txt2tags'
require_relative '../lib/txt2tags/null'

require 'test/unit'
require 'stringio'

# Simplify tests
class NullFormatHelper < Test::Unit::TestCase
  private

  def output(text)
    txt2tags = Txt2Tags.new(text)
    result = txt2tags.output(Null)
    result.to_a.join("\n")
  end
end
