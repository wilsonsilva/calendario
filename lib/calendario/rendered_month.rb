module Calendario
  # A cal-like representation of a month:
  #
  #       January
  # Su Mo Tu We Th Fr Sa
  #           1  2  3  4
  #  5  6  7  8  9 10 11
  # 12 13 14 15 16 17 18
  # 19 20 21 22 23 24 25
  # 26 27 28 29 30 31
  #
  class RenderedMonth
    # A list of lines representing a month. The month name, the weekday initials and 4 to 5 lines of weeks
    #
    # @api private
    # @return [Array<String>]
    #
    attr_reader :lines

    # Initializes a rendered month
    #
    # @api private
    # @param [Array<String>] lines List of lines representing a month. The month name, the weekday
    # initials and 4 to 5 lines of weeks
    #
    def initialize(lines)
      @lines = lines
    end

    # Returns the textual representation of a month
    #
    # @api private
    # @return [String]
    #
    def to_s
      lines.join("\n")
    end

    # The centered name of the month
    #
    # @api private
    # @return [String]
    #
    def name
      lines[0]
    end

    # The list of weekday initials (Su Mo Tu We Th Fr Sa)
    #
    # @api private
    # @return [String]
    #
    def weekdays
      lines[1]
    end

    # Returns 4 or 5 rows of weeks
    #
    # @api private
    # @return [Array<String>]
    #
    def weeks
      lines[2..-1]
    end

    # Finds one or more lines of the rendered month
    #
    # @api private
    # @return [Array<String>]
    #
    def [](index)
      lines.public_send(:[], index)
    end
  end
end
