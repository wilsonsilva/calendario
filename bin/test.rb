require 'pry'
require 'pastel'
require_relative '../lib/calendario/month'
require_relative '../lib/calendario/year'
require_relative '../lib/calendario/interval'
require_relative '../lib/calendario/rendered_month'
require_relative '../lib/calendario/rendered_year'
require_relative '../lib/calendario/rendered_interval'
require_relative '../lib/calendario/renderers/month_renderer'
require_relative '../lib/calendario/renderers/interval_renderer'
require_relative '../lib/calendario/renderers/year_renderer'

# pastel = Pastel.new
# year = Calendario::Year.new(2025)
# renderer = Calendario::Renderers::YearRenderer.new
#
# # renderer.filter = proc do |date|
# #   pastel.decorate(date.day.to_s.rjust(2), :bright_black)
# # end
#
# rendered_year = renderer.render(year)
# puts rendered_year

interval = Calendario::Interval.new(2020, 2, 2020, 6)
renderer = Calendario::Renderers::IntervalRenderer.new

# renderer.filter = proc do |date|
#   pastel.decorate(date.day.to_s.rjust(2), :bright_black)
# end

rendered_year = renderer.render(interval, columns: 2)
puts rendered_year
