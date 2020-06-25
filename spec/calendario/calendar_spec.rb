RSpec.describe Calendario::Calendar do
  let(:calendar) { described_class.new }

  describe '#render_current_year' do
    context 'without a block' do
      it 'renders the current year', snapshot: true do
        rendered = calendar.render_current_year
        expect(rendered).to match_snapshot
      end
    end

    context 'with a block' do
      it 'renders the current year, respecting the rules in the given block', snapshot: true do
        rendered = calendar.render_current_year do |date|
          if date.day == 1
            'ON'
          else
            date.day.to_s.rjust(2)
          end
        end

        expect(rendered).to match_snapshot
      end
    end
  end
end
