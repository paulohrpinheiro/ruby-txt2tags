require 'stringio'

# TXT2Tags - Converts t2t files to another formats
class Txt2Tags
  attr_reader :BEAUTIFIERS, :TITLES, :BLOCKS

  # The basic transformations
  #
  # One regexp by mark, the content must be in a group: (.*?)
  BEAUTIFIERS = {
    monospace: Regexp.new('``(.*?)``'),
    bold: Regexp.new('\*\*(.*?)\*\*'),
    italic: Regexp.new('//(.*?)//'),
    underline: Regexp.new('__(.*?)__'),
    strike: Regexp.new('--(.*?)--')
  }.freeze

  # Only one linners transformations
  #
  # One regexp by mark, the content must be in a group: (.*?)
  TITLES = {
    title1: Regexp.new('\A= (.*?) ='),
    title2: Regexp.new('\A== (.*?) =='),
    title3: Regexp.new('\A=== (.*?) ===')
  }.freeze

  # Define blocks os lines transformation
  #
  # - begin_re          -> identify the begin of a blocks
  # - end_re            -> identify the end of a blocks
  # - apply_inline      -> can apply the BEAUTIFIERS and TITLES transformations?
  # - strip             -> can strip spaces from line begin?
  # - ignore_match_line -> begin and end lines will be discarded?
  BLOCKS = {
    quote: {
      begin_re: Regexp.new('\A\s+'),
      end_re: Regexp.new('\A\Z'),
      apply_inline: true,
      strip: true,
      ignore_match_line: false
    },
    verbatim: {
      begin_re: Regexp.new('\A```\Z'),
      end_re: Regexp.new('\A```\Z'),
      apply_inline: false,
      strip: false,
      ignore_match_line: true
    }
  }.freeze

  # Save input type
  def initialize(input)
    if input.respond_to?(:read)
      @input = input
    elsif input.respond_to?(:to_s)
      @input = StringIO.new(input.to_s)
    else
      raise 'Cannot read this.'
    end
  end

  # Process conform 'format' and return a iterator with processed input
  def output(format)
    block = nil
    ignore_line = false

    # We can this multiples times
    @input.rewind if @input.eof?

    Enumerator.new do |y|
      # Comments are discarded (lines beginnig with %)
      @input.readlines.reject { |l| l.start_with?('%') }.each do |line|
        # right space are discarded (line terminators, tabs and spaces)
        line.rstrip!

        if block.nil?
          # Searching for a new block...
          block = BLOCKS.find { |b| b[1][:begin_re].match line }

          # The begin of a block!
          unless block.nil?
            block = block[0]

            # We can ignore the actual line?
            ignore_line = BLOCKS[block][:ignore_match_line]

            # Send the begin mark for this format
            y.yield format::BLOCKS[block][:begin]
          end
        elsif BLOCKS[block][:end_re].match line
          # We find the end of a block!
          # Send the end mark for this format
          y.yield format::BLOCKS[block][:end]

          # We can ignore the actual line?
          if BLOCKS[block][:ignore_match_line]
            block = nil
            next
          end
        end

        # More on line!
        y.yield process_line(line, block, format) unless ignore_line
        ignore_line = false if ignore_line
      end

      # There are a close block pending?
      y.yield format::BLOCKS[block][:end] unless block.nil?
    end
  end

  def process_line(line, block, format)
    # We can strip spaces from the begin of this line?
    processed = line
    processed.strip! if !block.nil? && BLOCKS[block][:strip]

    apply(processed, block, format)
  end

  def apply(line, block, format)
    processed = line

    # an apply the BEAUTIFIERS and TITLES transformations?
    if block.nil? || (!block.nil? && BLOCKS[block][:apply_inline])
      [:BEAUTIFIERS, :TITLES].each do |type|
        type_array = Txt2Tags.const_get(type)
        type_array.keys.each do |rule|
          processed.gsub!(type_array[rule], format.const_get(type)[rule])
        end
      end
    end

    processed
  end

  # Discover available formats
  def formats
    format_list = []
    Dir[File.join(__dir__, 'txt2tags', '*.rb')].each do |format|
      format_list.push File.basename(format, '.rb')
    end

    format_list
  end

  # Require the format using a string as reference
  def load_format(name)
    require "txt2tags/#{name}"
    Object.const_get(File.basename(name, '.rb').capitalize!)
  end
end
