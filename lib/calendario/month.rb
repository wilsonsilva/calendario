require 'date'

module Calendario
  # Any of the twelve parts, as January or February, into which the calendar year is divided
  class Month
    # List of month names (January, February, etc)
    MONTH_NAMES = Date::MONTHNAMES.freeze

    # The last day of the week is Saturday, in conformity with Ruby's standard library
    LAST_DAY_OF_THE_WEEK = 'Saturday'.freeze

    # Array of 28 to 31 days, depending on the month
    #
    # @api private
    # @return [Array<Date>]
    #
    attr_reader :days

    # The month's number from 1 to 12
    #
    # @api private
    # @return [Integer]
    #
    attr_reader :month_number

    # The primitive numeric representation of a year
    #
    # @api private
    # @return [Integer]
    #
    attr_reader :year_number

    # Initialize a month
    #
    # @api private
    # @param [Integer] year_number The primitive numeric representation of a year
    # @param [Integer] month_number The month's number from 1 to 12
    #
    def initialize(year_number = 2020, month_number = 1)
      @year_number = year_number
      @month_number = month_number
      @days = (first_day..last_day).to_a
    end

    # First day of the month
    #
    # @api private
    # @return [Date]
    #
    def first_day
      @first_day ||= Date.new(year_number, month_number, 1)
    end

    # Last day of the month
    #
    # @api private
    # @return [Date]
    #
    def last_day
      @last_day ||= Date.new(year_number, month_number, -1)
    end

    # Array of weeks in the month. Weeks start on Sunday and end on Saturday
    #
    # @api private
    # @return [Array<Date>]
    #
    def weeks
      @weeks ||= days.slice_when do |day|
        Date::DAYNAMES[day.wday] == LAST_DAY_OF_THE_WEEK
      end.to_a
    end

    # Full name of the month (ex: January)
    #
    # @api private
    # @return [String]
    #
    def name
      MONTH_NAMES[month_number]
    end
  end
end
