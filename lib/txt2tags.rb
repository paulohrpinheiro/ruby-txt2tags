require 'stringio'

class Txt2Tags
  @@marks = {
    # Beautifiers
    :monospace => {:type => :inline, :regexp => '``(.*?)``'},
    :bold => {:type => :inline, :regexp => '\*\*(.*?)\*\*'},
    :italic => {:type => :inline, :regexp => '//(.*?)//'},
    :underline => {:type => :inline, :regexp => '__(.*?)__'},
    :strike => {:type => :inline, :regexp => '--(.*?)--'},

    # Titles
    :title1 => {:type => :title, :regexp => '\A= (.*?) ='},
    :title2 => {:type => :title, :regexp => '\A== (.*?) =='},
    :title3 => {:type => :title, :regexp => '\A=== (.*?) ==='},

    # Blocks
    :quote => {
      :type => :block,
      :regexp => {
        :begin => '\A[ \t]+',
        :end => '\A\s*\Z'
      },
      :apply_inline => true,
      :ignore_match_line => false,
    },
    :verbatim => {
      :type => :block,
      :regexp => {
        :begin => '\A```\Z',
        :end => '\A```\Z',
      },
      :apply_inline => true,
      :ignore_match_line => true,
    }
  }

  @@targets = {
    :html5 => {
      # Beautifiers
      :monospace => '<pre>\1</pre>',
      :bold => '<strong>\1</strong>',
      :italic => '<em>\1</em>',
      :underline => '<span style="text-decoration: underline;">\1</span>',
      :strike => '<span style="text-decoration: line-through;">\1</span>',

      # Titles
      :title1 => '<h2>\1</h2>',
      :title2 => '<h3>\1</h3>',
      :title3 => '<h4>\1</h4>',

      # Blocks
      :quote => {:begin => "<blockquote>\n", :end => "</blockquote>\n"},
      :verbatim => {:begin => "<pre>\n", :end => "</pre>\n"},
    }
  }

  @@compiled = false

  def self.marks_content
    @@marks
  end

  def self.targets_content
    @@targets
  end

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
        case @@marks[m][:type]
        when :inline, :title
          @@marks[m][:regexp] = Regexp.new @@marks[m][:regexp]
        when :block
          [:begin, :end].each do |t|
            @@marks[m][:regexp][t] = Regexp.new @@marks[m][:regexp][t]
          end
        else
          raise "Mark type [#{@@marks[m][:type]}] not recognized."
        end
      end

      @@compiled = true

      @@compiled.freeze
      @@marks.freeze
      @@targets.freeze

    end
  end

  def html5
    apply_rules(:html5).to_a.join
  end

  private

  def apply_rules(format)
    in_block = false
    apply_inline = true
    apply_title = true
    close_block = nil
    close_block_re = nil
    ignore_current_line = false
    close_ignore_current_line = false

    Enumerator.new do |y|
      @input.readlines.reject{|l| l.start_with?('%')}.each do |line|
        if in_block
          if line.match(close_block_re)
            in_block = false
            apply_inline = true

            ignore_current_line = close_ignore_current_line
            y.yield close_block
          end
        else
          @@marks.keys.select{|k| @@marks[k][:type]==:block}.each do |m|
            if line.match(@@marks[m][:regexp][:begin])
              in_block = true
              ignore_current_line = @@marks[m][:ignore_match_line]
              close_ignore_current_line = ignore_current_line
              apply_inline = @@marks[m][:apply_inline]
              close_block = @@targets[format][m][:end]
              close_block_re = @@marks[m][:regexp][:end]

              y.yield @@targets[format][m][:begin]
            end
          end
        end

        if not ignore_current_line
          @@marks
            .keys
            .select{|k|
               (apply_inline && @@marks[k][:type]==:inline) or
               (apply_title && @@marks[k][:type]==:title)
            }
            .each do |m|
            line.gsub!(@@marks[m][:regexp], @@targets[format][m])
          end

          y.yield line
        else
          ignore_current_line = false
        end
      end

      y.yield close_block if in_block
    end
  end
end
