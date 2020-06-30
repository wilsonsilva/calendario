RSpec.describe Calendario::Renderers::IntervalRenderer do
  let(:interval_renderer) { described_class.new }

  describe '#render' do
    context 'when the interval contains more months than the given columns' do
      let(:interval) { Calendario::Interval.new(2025, 1, 2026, 12) }

      it 'renders an interval multiple rows', snapshot: true do
        rendered = interval_renderer.render(interval, columns: 6)
        expect(rendered.to_s).to match_snapshot
      end
    end

    context 'when the interval contains less months than the given columns' do
      let(:interval) { Calendario::Interval.new(2025, 1, 2025, 2) }

      it 'renders the interval in one row', snapshot: true do
        rendered = interval_renderer.render(interval, columns: 6)
        expect(rendered.to_s).to match_snapshot
      end
    end

    context 'when the interval contains the same number of months as the given columns' do
      let(:interval) { Calendario::Interval.new(2025, 1, 2025, 6) }

      it 'renders the interval in the same number of rows', snapshot: true do
        rendered = interval_renderer.render(interval, columns: 6)
        expect(rendered.to_s).to match_snapshot
      end
    end

    context 'with a block' do
      let(:interval) { Calendario::Interval.new(2025, 1, 2025, 6) }

      it 'renders an interval, respecting the rules in the given block', snapshot: true do
        rendered = interval_renderer.render(interval, columns: 2) do |date|
          if date.day == 1
            'ON'
          else
            date.day.to_s.rjust(2)
          end
        end

        expect(rendered.to_s).to match_snapshot
      end
    end
  end
end
