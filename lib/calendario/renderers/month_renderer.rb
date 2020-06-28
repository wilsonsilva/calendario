require 'calendario/month'
require 'calendario/rendered_month'

module Calendario
  module Renderers
    # Renders a month line by line
    #
    # @api private
    #
    class MonthRenderer
      # The space of an empty day
      # @return [String]
      EMPTY_DAY_SPACES = '  '.freeze

      # Initials of each week day
      # @return [String]
      WEEKDAY_INITIALS = 'Su Mo Tu We Th Fr Sa'.freeze

      # Width of a rendered month
      # @return [Integer]
      MONTH_WIDTH = 20

      # A proc to be executed on each date to define what is displayed on each day
      #
      # @api private
      # @return [Proc]
      #
      attr_accessor :filter

      # Initializes a month renderer
      #
      # @api private
      #
      def initialize
        @filter = proc { |date| date.day.to_s.rjust(2) }
      end

      # Renders a month
      #
      # @api private
      # @param [Month] month The month to be rendered
      # @return [RenderedMonth]
      #
      def render(month)
        weeks = build_weeks(month).map { |week| week.join(' ') }

        lines = [
          center_name(month),
          WEEKDAY_INITIALS,
          *weeks
        ]

        RenderedMonth.new(lines)
      end

      private

      # Builds all weeks in a month, applying a filter on every date
      #
      # @api private
      # @param [Month] month The month containing the weeks
      # @return [Array<Date|String>]
      #
      def build_weeks(month)
        weeks = month.weeks

        add_leading_spaces(month.weeks.first)
        add_trailing_spaces(month.weeks.last)

        weeks << [EMPTY_DAY_SPACES] * 7 if month.weeks.size == 5
        weeks.map do |week|
          week.map(&method(:apply_filter))
        end
      end

      # Applies a filter on a date or a blank space
      #
      # @api private
      # @param [Date|String] date_or_string A date or a string to be parsed by a filter
      # @return [Date|String]
      #
      def apply_filter(date_or_string)
        date_or_string.is_a?(Date) ? filter.call(date_or_string) : date_or_string
      end

      # Prepends leading spaces in a week until the first day of the week is found
      #
      # @api private
      # @param [Array<Date>] week A list of days in a week
      # @return [void]
      #
      def add_leading_spaces(week)
        first_day_is_sunday = week.first.wday.zero?
        return if first_day_is_sunday

        week.first.wday.times { week.unshift(EMPTY_DAY_SPACES) }
      end

      # Appends trailing spaces in a week until it has 7 items
      #
      # @api private
      # @param [Array<Date>] week A list of days in a week
      # @return [void]
      #
      def add_trailing_spaces(week)
        (6 - week.last.wday).abs.times { week.push(EMPTY_DAY_SPACES) }
      end

      # Centers the month's name horizontally
      #
      # @api private
      # @param [Month] month The month to be centered
      # @return [String]
      #
      def center_name(month)
        month.name.center(MONTH_WIDTH)
      end
    end
  end
end
