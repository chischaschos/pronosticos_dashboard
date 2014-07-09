require 'spec_helper'

describe PronosticosDashboard::Reports do
  subject(:reports) { PronosticosDashboard::Reports }

  describe '#days_status' do
    context 'when there is nothing' do
      it 'should return an empty array' do
        expect(reports.days_status).to eq []
      end
    end

    context 'when there is data' do
      before do

      end

      it 'should return an array with the status per day' do
        expect(reports.days_status).to eq [
          ['152300500', '2014-07-03', 'Missed'],
          ['152300200', '2014-07-04', 'Missed'],
          ['152300500', '2014-07-04', 'Missed'],
          ['152300200', '2014-07-05', 'Missed'],
          ['152300500', '2014-07-05', 'Missed'],
          ['152300200', '2014-07-06', 'Missed'],
          ['152300500', '2014-07-06', 'Missed'],
        ]
      end
    end
  end
end
