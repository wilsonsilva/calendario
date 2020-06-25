RSpec.describe Calendario::Year do
  let(:year) { described_class.new(2025) }

  describe '#days' do
    it 'returns all days of a year' do
      expect(year.days).to eq((Date.new(2025, 1, 1)..Date.new(2025, 12, 31)).to_a)
    end
  end

  describe '#first_day' do
    it 'returns the first day of the year' do
      expect(year.first_day).to eq(Date.new(2025, 1, 1))
    end
  end

  describe '#last_day' do
    it 'returns the last day of the year' do
      expect(year.last_day).to eq(Date.new(2025, 12, 31))
    end
  end

  describe '#months' do
    it 'returns all months of the year' do
      aggregate_failures do
        expect(year.months).to all(be_a(Calendario::Month))
        expect(year.months.flat_map(&:year_number)).to all(eq(year.year_number))
        expect(year.months.flat_map(&:name)).to eq(Date::MONTHNAMES.drop(1))
      end
    end
  end

  describe '#year_number' do
    it 'returns the numeric representation of the year' do
      expect(year.year_number).to eq(2025)
    end
  end
end
