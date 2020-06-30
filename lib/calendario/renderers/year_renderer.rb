require 'calendario/rendered_year'
require 'calendario/renderers/month_renderer'
require 'calendario/renderers/interval_renderer'

module Calendario
  module Renderers
    # Renders a year, line by line, in a table of 3 columns by 4 rows
    class YearRenderer < IntervalRenderer
      # Number of month columns to display
      # @return [Integer]
      NUMBER_OF_MONTH_COLUMNS = 3

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

      # Centers the year in the middle of the calendar
      #
      # @api private
      # @param [Year] year The year to be displayed at the top of the calendar
      # @return [String]
      #
      def center_year_number(year)
        year.year_number.to_s.center(61)
      end
    end
  end
end
