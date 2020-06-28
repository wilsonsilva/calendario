require 'calendario/renderers/year_renderer'
require 'calendario/year'

module Calendario
  # A time period to be rendered
  class Calendar
    # Formats a year, line by line, in a table of 3 columns by 4 rows
    #
    # @api private
    # @return [Calendario::Renderers::YearRenderer]
    #
    attr_reader :year_renderer

    # Initialize a calendar
    #
    # @api private
    # @param [Calendario::Renderers::YearRenderer] year_renderer # Formats a year, line by line, in a
    # table of 3 columns by 4 rows
    #
    def initialize(year_renderer = Renderers::YearRenderer.new)
      @year_renderer = year_renderer
    end

    # Renders the current year as a string
    #
    # @api public
    #
    # @example Rendering the current year
    #  calendar = Calendario::Calendar.new
    #  calendar.render_current_year
    #
    # @example Rendering a customized version of the current year
    #  calendar = Calendario::Calendar.new
    #  calendar.render_current_year do |date|
    #    if date.wday == 5 ||  if date.wday == 6
    #      'WE'
    #    else
    #      date.day.to_s.rjust(2)
    #    end
    #  end
    #
    # @return [RenderedYear]
    #
    def render_current_year(&block)
      year = Year.new(Date.today.year)
      year_renderer.render(year, &block)
    end
  end
end
