require 'spec_helper'

describe PronosticosDashboard::Sale do

  describe '#complete' do
    it 'should not be complete' do
      expect(subject).to_not be_complete
    end

    let(:complete_sale) { Fabricate :complete_sale, date: DateTime.parse('2014-07-10') }

    it 'should to be complete' do
      expect(complete_sale).to be_complete
    end
  end
end

