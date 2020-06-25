require 'calendario/month'
require 'date'

module Calendario
  # A period of 365 or 366 days, in the Gregorian calendar, divided into 12 calendar months
  class Year
    # Array of all calendar months
    #
    # @api private
    # @return [Array<Month>]
    #
    attr_reader :months

    # The primitive numeric representation of a year
    #
    # @api private
    # @return [Integer]
    #
    attr_reader :year_number

    # Initialize a year
    #
    # @api private
    # @param [Integer] year_number The primitive numeric representation of a year
    #
    def initialize(year_number = 2020)
      @year_number = year_number
      @months = 1.upto(12).map do |month_number|
        Month.new(year_number, month_number)
      end
    end

    # The first day of the year (1st of January)
    #
    # @api private
    # @return [Date]
    #
    def first_day
      @first_day ||= months.first.first_day
    end

    # The last day of the year (31st of December)
    #
    # @api private
    # @return [Date]
    #
    def last_day
      @last_day ||= months.last.last_day
    end

    # An array of 365 or 365 dates representing every day of the year
    #
    # @api private
    # @return [Date]
    #
    def days
      @days ||= months.map(&:days).flatten
    end
  end
end
