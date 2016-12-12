require 'stringio'

class Txt2Tags
  @@marks = {
    :monospace => '``(.*?)``',
    :bold => '\*\*(.*?)\*\*',
    :italic => '//(.*?)//',
    :underline => '__(.*?)__',
    :strike => '--(.*?)--',
  }

  @@targets = {
    :html5 => {
      :monospace => '<pre>\1</pre>',
      :bold => '<strong>\1</strong>',
      :italic => '<em>\1</em>',
      :underline => '<span style="text-decoration: underline;">\1</span>',
      :strike => '<span style="text-decoration: line-through;">\1</span>',
    }
  }

  @@compiled = false

  def initialize(input)
    if input.respond_to?(:read)
      @input = input
    elsif input.respond_to?(:to_s)
      @input = StringIO.new(input.to_s)
    else
      raise 'Cannot read this.'
    end

    if not @@compiled
      @@marks.keys.each do |m|
        @@marks[m] = Regexp.new @@marks[m]
      end

      @@compiled = true
    end
  end

  def html5
    self.apply_rules(:html5, self.sanitize).join
  end

  def sanitize
    @input.readlines.select { |l| not l.start_with?('%') }
  end

  def apply_rules(format, lines)
    lines.each do |line|
      @@marks.keys.each do |m|
        line.gsub!(@@marks[m], @@targets[format][m])
      end

      yield line if block_given?
    end
  end
end
