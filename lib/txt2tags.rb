require 'stringio'

class Txt2Tags
  def initialize(input)
    if input.respond_to?(:read)
      @input = input
    elsif input.respond_to?(:to_s)
      @input = StringIO.new(input.to_s)
    else
      raise 'Cannot read this.'
    end
  end

  def html
    @input.read
  end
end
