require 'byebug'

class SemanticVersioning
  attr_reader :outputs

  def initialize
    @outputs = []
  end

  def comparator(version_1, version_2)
    idx = 0
    while idx < version_1.length || idx < version_2.length
      # ruby has a spaceship operator used below
      # it returns -1 if the condition is less than
      # it returns 0 if they are equal
      # it returns 1 if the condition is greater than
      case version_1[idx] <=> version_2[idx]
      when -1
        @outputs << 'before'
        return 'before'
      when 1
        @outputs << 'after'
        return 'after'
      when 0
        idx += 1
      end
    end

    @outputs << 'equal'
    'equal'
  end

  def postfix?(version_1, version_2)
    # we want to make sure there is a postfix
    if version_1.index('-') || version_2.index('-')
      idx_1 = version_1.index('-')
      idx_2 = version_2.index('-')
      version_1_prefix = version_1[0..idx_1]
      version_2_prefix = version_1[0..idx_2]
      # we want to make sure that the prefixes are the same or the postfix doesn't matter
      if version_1_prefix == version_2_prefix
        return true
      end
    end

    false
  end

  def postfix(version_1, version_2)
    # set the postfixes
    idx_1 = version_1.index('-')
    idx_2 = version_2.index('-')
    version_1_postfix = version_1[idx_1..-1]
    version_2_postfix = version_2[idx_2..-1]
    # in ruby letters are determined by order in the alphabet
    # ex: a < b is true
    if version_1_postfix[1] < version_2_postfix[1]
      @outputs << 'before'
      return 'before'
    else
      @outputs << 'after'
      return 'after'
    end
  end

  def parse_input(input)
    input.split(' ')
  end

  def valid_input?(input)
    input_line = input.split(' ')
    # inputs need to be in sets of 2 for comparison
    return false unless input_line.size == 2

    input_line.each do |str|
      # with 2 periods the length should be at least 5 ex: 1.3.4 has length 5
      return false if str.length < 5
      return false unless str.count('.') == 2
      # versioning cannot have leading zeros according to Semantic Versioning 2.0.0
      return false if str[0] == '0'

      str.split('.').each do |el|
        # versions cannot have negative values according to Semantic Versioning 2.0.0
        return false if el[0] == '-'
      end
    end

    true
  end

  def invalid_input
    @outputs << 'invalid'
  end

  def output
    @outputs.each do |output|
      puts output
    end
  end
end



if $PROGRAM_NAME == __FILE__
  versioning = SemanticVersioning.new
  inputs = []

  puts "please enter input"
  # take the inputs until the user types 'done'
  while input = $stdin.gets.strip
    if input == 'done'
      break
    end
    inputs << input
  end

  inputs.each do |input|
    if versioning.valid_input?(input)
      # I made an instance method here. Could just as easily called split on the input.
      parsed = versioning.parse_input(input)
      if versioning.postfix?(parsed.first, parsed.last)
        versioning.postfix(parsed.first, parsed.last)
      else
        versioning.comparator(parsed.first, parsed.last)
      end
    else
      versioning.invalid_input
    end
  end

  puts "results: -------------------------------------"
  versioning.output
end
