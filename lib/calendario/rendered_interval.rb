module Calendario
  # A cal-like representation of an interval:
  #
  #       January               February               March
  # Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
  #           1  2  3  4                     1   1  2  3  4  5  6  7
  #  5  6  7  8  9 10 11   2  3  4  5  6  7  8   8  9 10 11 12 13 14
  # 12 13 14 15 16 17 18   9 10 11 12 13 14 15  15 16 17 18 19 20 21
  # 19 20 21 22 23 24 25  16 17 18 19 20 21 22  22 23 24 25 26 27 28
  # 26 27 28 29 30 31     23 24 25 26 27 28 29  29 30 31
  #
  class RenderedInterval
    # A list of lines representing an interval
    #
    # @api private
    # @return [Array<String>]
    #
    attr_reader :lines

    # Initializes a rendered interval
    #
    # @api private
    # @param [Array<String>] lines List of lines representing an interval
    #
    def initialize(lines)
      @lines = lines
    end

    # Returns the textual representation of an interval
    #
    # @api private
    # @return [String]
    #
    def to_s
      lines.join("\n")
    end
  end
end
