RSpec.describe Calendario::Month do
  let(:month) { described_class.new(2025, 12) }

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
