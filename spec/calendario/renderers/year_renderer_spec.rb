RSpec.describe Calendario::Renderers::YearRenderer do
  let(:year_renderer) { described_class.new }
  let(:year) { Calendario::Year.new(2025) }

  describe '#render' do
    context 'without a block' do
      it 'renders a year', snapshot: true do
        rendered = year_renderer.render(year)
        expect(rendered).to match_snapshot
      end
    end

    context 'with a block' do
      it 'renders a year, respecting the rules in the given block', snapshot: true do
        rendered = year_renderer.render(year) do |date|
          if date.wday == 5 || date.wday == 6
            'WE'
          else
            date.day.to_s.rjust(2)
          end
        end

        expect(rendered).to match_snapshot
      end
    end
  end
end
