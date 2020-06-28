RSpec.describe Calendario::Renderers::MonthRenderer do
  let(:month_renderer) { described_class.new }
  let(:month) { Calendario::Month.new(2025, 1) }

  describe '#render' do
    context 'with the default filter' do
      it 'renders a month', snapshot: true do
        rendered = month_renderer.render(month)
        expect(rendered.to_s).to match_snapshot
      end
    end

    context 'with a custom filter' do
      before do
        month_renderer.filter = proc do |date|
          if date.wday == 5 || date.wday == 6
            'WE'
          else
            date.day.to_s.rjust(2)
          end
        end
      end

      it 'renders a month, respecting the rules in the filter', snapshot: true do
        rendered = month_renderer.render(month)
        expect(rendered.to_s).to match_snapshot
      end
    end
  end
end
