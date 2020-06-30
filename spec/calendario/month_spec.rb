RSpec.describe Calendario::Month do
  let(:month) { described_class.new(2025, 12) }

  describe '#<=>' do
    context 'when comparing with a month from an earlier year' do
      let(:other_month) { described_class.new(month.year_number - 1, month.month_number) }

      it 'returns 1' do
        comparison_result = month <=> other_month
        expect(comparison_result).to eq(1)
      end
    end

    context 'when comparing with an earlier month from the same year' do
      let(:other_month) { described_class.new(month.year_number, month.month_number - 1) }

      it 'returns 1' do
        comparison_result = month <=> other_month
        expect(comparison_result).to eq(1)
      end
    end

    context 'when comparing with the same month from the same year' do
      let(:other_month) { described_class.new(month.year_number, month.month_number) }

      it 'returns 0' do
        comparison_result = month <=> other_month
        expect(comparison_result).to eq(0)
      end
    end

    context 'when comparing with a later month from the same year' do
      let(:month) { described_class.new(2025, 11) }
      let(:other_month) { described_class.new(month.year_number, month.month_number + 1) }

      it 'returns -1' do
        comparison_result = month <=> other_month
        expect(comparison_result).to eq(-1)
      end
    end

    context 'when comparing with a month from a later year' do
      let(:other_month) { described_class.new(month.year_number + 1, month.month_number) }

      it 'returns -1' do
        comparison_result = month <=> other_month
        expect(comparison_result).to eq(-1)
      end
    end
  end

  describe '#days' do
    it 'returns all days of a calendar month' do
      expect(month.days).to eq((Date.new(2025, 12, 1)..Date.new(2025, 12, 31)).to_a)
    end
  end

  describe '#first_day' do
    it 'returns the first day of the month' do
      expect(month.first_day).to eq(Date.new(2025, 12, 1))
    end
  end

  describe '#last_day' do
    it 'returns the last day of the month' do
      expect(month.last_day).to eq(Date.new(2025, 12, 31))
    end
  end

  describe '#name' do
    it 'returns the full name of the month' do
      expect(month.name).to eq('December')
    end
  end

  describe '#month_number' do
    it 'returns the numeric representation of the month' do
      expect(month.month_number).to eq(12)
    end
  end

  describe '#succ' do
    context 'when the month is December' do
      let(:month) { described_class.new(2020, 12) }

      it 'returns January frm the following year' do
        following_month = month.succ

        aggregate_failures do
          expect(following_month.year_number).to eq(2021)
          expect(following_month.month_number).to eq(1)
        end
      end
    end

    context 'when the month is not December' do
      let(:month) { described_class.new(2020, 11) }

      it 'returns the following month in the same year' do
        following_month = month.succ

        aggregate_failures do
          expect(following_month.year_number).to eq(2020)
          expect(following_month.month_number).to eq(12)
        end
      end
    end
  end

  describe '#weeks' do
    it 'returns an array of weeks in the month, each starting on Sunday and ending on Saturday' do
      weeks = month.weeks
      expect(weeks).to eq(
        [
          (Date.new(2025, 12,  1)..Date.new(2025, 12, 6)).to_a,
          (Date.new(2025, 12,  7)..Date.new(2025, 12, 13)).to_a,
          (Date.new(2025, 12, 14)..Date.new(2025, 12, 20)).to_a,
          (Date.new(2025, 12, 21)..Date.new(2025, 12, 27)).to_a,
          (Date.new(2025, 12, 28)..Date.new(2025, 12, 31)).to_a
        ]
      )
    end
  end

  describe '#year_number' do
    it 'returns the numeric representation of the year' do
      expect(month.year_number).to eq(2025)
    end
  end
end
