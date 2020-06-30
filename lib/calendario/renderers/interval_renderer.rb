require 'calendario/interval'
require 'calendario/rendered_interval'
require 'calendario/renderers/month_renderer'

module Calendario
  module Renderers
    # Renders a time interval, line by line, in a table
    class IntervalRenderer
      # The space of an empty day
      # @return [String]
      EMPTY_DAY_SPACES = '  '.freeze

      # Initializes a interval renderer
      #
      # @api private
      # @param [MonthRenderer] month_renderer A service to render a month line by line
      #
      def initialize(month_renderer = MonthRenderer.new)
        @month_renderer = month_renderer
      end

      # Formats a time interval, line by line, in a table
      #
      # @api private
      # @param [Interval] interval The time interval to be rendered.
      # @return [RenderedInterval]
      #
      def render(interval, columns:, &block)
        month_renderer.filter = block if block_given?

        lines = []
        rendered_months = render_months(interval.months)

        rendered_months.each_slice(columns) do |months|
          0.upto(7) { |month_line| lines << take_row(month_line, months) }
          lines.push('') # Separate rows of months
        end

        RenderedInterval.new(lines)
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
