RSpec.describe Calendario::RenderedMonth do
  let(:lines) do
    [
      '       January        ',
      ' Su Mo Tu We Th Fr Sa ',
      '           1  2  3  4 ',
      '  5  6  7  8  9 10 11 ',
      ' 12 13 14 15 16 17 18 ',
      ' 19 20 21 22 23 24 25 ',
      ' 26 27 28 29 30 31    '
    ]
  end
  let(:rendered_month) { described_class.new(lines) }

  describe '#to_s' do
    it 'converts the rendered month to a string' do
      expect(rendered_month.to_s).to eq(
        "       January        \n" \
        " Su Mo Tu We Th Fr Sa \n" \
        "           1  2  3  4 \n" \
        "  5  6  7  8  9 10 11 \n" \
        " 12 13 14 15 16 17 18 \n" \
        " 19 20 21 22 23 24 25 \n" \
        ' 26 27 28 29 30 31    '
      )
    end
  end

  describe '#name' do
    it 'returns the name of the month centered' do
      expect(rendered_month.name).to eq('       January        ')
    end
  end

  describe '#weekdays' do
    it 'returns the weekdays' do
      expect(rendered_month.weekdays).to eq(' Su Mo Tu We Th Fr Sa ')
    end
  end

  describe '#weeks' do
    it 'retrieves the week lines' do
      expect(rendered_month.weeks).to eq(
        [
          '           1  2  3  4 ',
          '  5  6  7  8  9 10 11 ',
          ' 12 13 14 15 16 17 18 ',
          ' 19 20 21 22 23 24 25 ',
          ' 26 27 28 29 30 31    '
        ]
      )
    end
  end

  describe '#[]' do
    it 'retrieves a line of the rendered month' do
      expect(rendered_month[5]).to eq(' 19 20 21 22 23 24 25 ')
    end
  end
end
