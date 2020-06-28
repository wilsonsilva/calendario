require 'calendario/rendered_year'
require 'calendario/renderers/month_renderer'

module Calendario
  module Renderers
    # Renders a year, line by line, in a table of 3 columns by 4 rows
    class YearRenderer
      # The space of an empty day
      # @return [String]
      EMPTY_DAY_SPACES = '  '.freeze

      # Number of month columns to display
      # @return [Integer]
      NUMBER_OF_MONTH_COLUMNS = 3

      # Initializes a year renderer
      #
      # @api private
      # @param [MonthRenderer] month_renderer A service to render a month line by line
      #
      def initialize(month_renderer = MonthRenderer.new)
        @month_renderer = month_renderer
      end

      # Formats a year, line by line, in a table of 3 columns by 4 rows
      #
      # @api private
      # @param [Year] year The year to be rendered.
      # @return [RenderedYear]
      #
      def render(year, &block)
        month_renderer.filter = block if block_given?

        lines = [center_year_number(year)]
        rendered_months = render_months(year.months)

        rendered_months.each_slice(NUMBER_OF_MONTH_COLUMNS) do |months|
          0.upto(7) { |month_line| lines << take_row(month_line, months) }
          lines.push('') # Separate rows of months
        end

        RenderedYear.new(lines)
      end

      private

      # A service to render a month line by line
      #
      # @api private
      # @return [Calendario::Renderers::MonthRenderer]
      #
      attr_accessor :month_renderer

      # Extracts a row from a group of months
      #
      # @api private
      # @return [Array<String>]
      #
      def take_row(month_line, months)
        months.map { |month| month[month_line] }.join(EMPTY_DAY_SPACES)
      end

      # Centers the year in the middle of the calendar
      #
      # @api private
      # @param [Year] year The year to be displayed at the top of the calendar
      # @return [String]
      #
      def center_year_number(year)
        year.year_number.to_s.center(61)
      end

      # Renders a list of months
      #
      # @api private
      # @param [Array<Month>] months The list of months to be rendered
      # @return [Array<RenderedMonth>]
      #
      def render_months(months)
        months.map { |month| month_renderer.render(month) }
      end
    end
  end
end
