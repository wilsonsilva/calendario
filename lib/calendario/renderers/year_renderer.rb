require 'calendario/month'

module Calendario
  module Renderers
    # Formats a year, line by line, in a table of 3 columns by 4 rows
    class YearRenderer
      # The space of an empty day (3 = 2 digits + 1 space between digits)
      EMPTY_DAY_SPACES = ' ' * 3

      # The space to add on the 6th row of a month when that row is empty
      EMPTY_WEEK_SPACES = ' ' * 20

      # Formats a year, line by line, in a table of 3 columns by 4 rows like this:
      #
      #                             2020                                  | Title, centered
      #       January               February               March          | Names of months, centered
      # Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  | Weekday initials
      #           1  2  3  4                     1   1  2  3  4  5  6  7  | Rows of weeks
      #  5  6  7  8  9 10 11   2  3  4  5  6  7  8   8  9 10 11 12 13 14  |
      # 12 13 14 15 16 17 18   9 10 11 12 13 14 15  15 16 17 18 19 20 21  |
      # 19 20 21 22 23 24 25  16 17 18 19 20 21 22  22 23 24 25 26 27 28  |
      # 26 27 28 29 30 31     23 24 25 26 27 28 29  29 30 31              | Add spaces after the last day of the
      #                                                                   | month until the first day of the week of
      #                                                                   | the month of the following month on the
      #        April                  May                   June          | same row.
      # Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  |
      #           1  2  3  4                  1  2      1  2  3  4  5  6  | Add spaces before the first day of the
      #  5  6  7  8  9 10 11   3  4  5  6  7  8  9   7  8  9 10 11 12 13  | month unless it is a Sunday.
      # 12 13 14 15 16 17 18  10 11 12 13 14 15 16  14 15 16 17 18 19 20  |
      # 19 20 21 22 23 24 25  17 18 19 20 21 22 23  21 22 23 24 25 26 27  |
      # 26 27 28 29 30        24 25 26 27 28 29 30  28 29 30              |
      #                       31                                          | Add spaces before a day on the second
      #                                                                   | or third month columns if the first or
      #         July                 August              September        | second columns month are empty.
      # Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  |
      #           1  2  3  4                     1         1  2  3  4  5  |
      #  5  6  7  8  9 10 11   2  3  4  5  6  7  8   6  7  8  9 10 11 12  |
      # 12 13 14 15 16 17 18   9 10 11 12 13 14 15  13 14 15 16 17 18 19  |
      # 19 20 21 22 23 24 25  16 17 18 19 20 21 22  20 21 22 23 24 25 26  |
      # 26 27 28 29 30 31     23 24 25 26 27 28 29  27 28 29 30           |
      #                       30 31                                       |
      #                                                                   |
      #       October               November              December        |
      # Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  |
      #              1  2  3   1  2  3  4  5  6  7         1  2  3  4  5  |
      #  4  5  6  7  8  9 10   8  9 10 11 12 13 14   6  7  8  9 10 11 12  |
      # 11 12 13 14 15 16 17  15 16 17 18 19 20 21  13 14 15 16 17 18 19  |
      # 18 19 20 21 22 23 24  22 23 24 25 26 27 28  20 21 22 23 24 25 26  |
      # 25 26 27 28 29 30 31  29 30                 27 28 29 30 31        |
      #
      # @api private
      # @param [Year] year The year to be formatted.
      # @return [String]
      #
      def render(year)
        output = centered_year_line(year)

        # Display months in
        year.months.each_slice(3).with_index do |group_of_3_months, month_row|
          output << month_names_line(group_of_3_months)
          output << weekdays_initials_line

          # Display 6 rows of days. Each row is a week.
          0.upto(5) do |week_number|
            # Display
            group_of_3_months.each_with_index do |month, index|
              # Correct the position for the first date of the first week
              output << EMPTY_DAY_SPACES * month.first_day.wday if week_number.zero?

              # Display a complete row of week days
              output << (month.weeks[week_number] || []).map do |date|
                if block_given?
                  yield(date)
                else
                  date.day.to_s.rjust(2)
                end
              end.join(' ') + '  '

              # Correct the position for the first date of the following month
              output << lead_space_after_last_day(month) if last_week_of_the_month?(month, week_number)

              # Correct the position of the dates on empty rows (usually the last week)
              output << EMPTY_WEEK_SPACES if week_number == 5 && group_of_3_months[index - 1].weeks[week_number].nil?
            end

            # End of the week row. Start the next one on the next line
            output << "\n"
          end

          # Separate rows of months
          output << "\n" if month_row < 3
        end

        output
      end

      private

      # Adds blank spaces to fill the empty week days on the last week row of the month
      #
      # @api private
      # @param [Month] month
      # @return [String]
      #
      def lead_space_after_last_day(month)
        EMPTY_DAY_SPACES * (6 - month.last_day.wday)
      end

      # Centers the year in the middle of the calendar
      #
      # @api private
      # @param [Year] year The year to be displayed at the top of the calendar
      # @return [String]
      #
      def centered_year_line(year)
        year.year_number.to_s.center(61) + "\n"
      end

      # Displays 3 columns of month names in a line
      #
      # @api private
      # @param [Array<Month>] group_of_3_months The list of months whose names will be displayed
      # @return [String]
      #
      def month_names_line(group_of_3_months)
        group_of_3_months.map { |month| month.name.center(20) }.join(' ') + " \n"
      end

      # Displays 3 columns of weekdays initials in a line
      #
      # @api private
      # @return [String]
      #
      def weekdays_initials_line
        "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  \n"
      end

      # Whether the week is the last week of the month
      #
      # @api private
      # @return [Boolean]
      #
      def last_week_of_the_month?(month, week_number)
        month.weeks[week_number] == month.weeks.last
      end
    end
  end
end
