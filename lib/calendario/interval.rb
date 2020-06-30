require 'calendario/month'

module Calendario
  # A list of one or more months
  class Interval
    include Comparable

    # Array of all months in the period
    #
    # @api private
    # @return [Array<Month>]
    #
    attr_reader :months

    # Initialize a time interval
    #
    # @api private
    #
    # @param [Integer] first_year The primitive representation of the first year
    # @param [Integer] first_month The primitive representation of the first month
    # @param [Integer] last_year The primitive representation of the last year
    # @param [Integer] last_month The primitive representation of the last month
    #
    def initialize(first_year, first_month, last_year, last_month)
      @first_year = first_year
      @first_month = first_month
      @last_year = last_year
      @last_month = last_month
      @months = (Month.new(first_year, first_month)..Month.new(last_year, last_month)).to_a
    end
  end
end
