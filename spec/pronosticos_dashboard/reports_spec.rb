require 'spec_helper'

describe PronosticosDashboard::Reports do
  subject(:reports) { PronosticosDashboard::Reports }

  let(:from_date) { DateTime.parse('2014-07-10') }
  let(:to_date) { DateTime.parse('2014-07-15') }

  describe '#days_status' do
    context 'when there are not any agencies' do
      it 'should return the missing days without agency' do
        from_date = DateTime.parse('2014-07-10')
        to_date = DateTime.parse('2014-07-12')

        expect(reports.days_status(from_date, to_date)).to eq [
          [nil, '2014-07-10', :missing],
          [nil, '2014-07-11', :missing],
          [nil, '2014-07-12', :missing]
        ]
      end
    end

    context 'when there is one agency' do
      let!(:sale) { Fabricate :complete_sale, date: DateTime.parse('2014-07-11') }

      it 'should return the missing days with agency' do
        from_date = DateTime.parse('2014-07-10')
        to_date = DateTime.parse('2014-07-12')

        expect(reports.days_status(from_date, to_date)).to eq [
          [sale.agency, '2014-07-10', :missing],
          [sale.agency, '2014-07-11', :complete],
          [sale.agency, '2014-07-12', :missing]
        ]
      end
    end

    context 'when there are two agencies' do

      let!(:sale1) { Fabricate :complete_sale, date: DateTime.parse('2014-07-10') }
      let!(:sale2) { Fabricate :complete_sale, date: DateTime.parse('2014-07-11') }

      before do
        Fabricate :sale, date: DateTime.parse('2014-07-12'), agency: sale1.agency
        Fabricate :complete_sale, date: DateTime.parse('2014-07-13'), agency: sale1.agency
        Fabricate :complete_sale, date: DateTime.parse('2014-07-13'), agency: sale2.agency
      end

      it 'should return the missing, complete and incomplete days with agencies' do
        from_date = DateTime.parse('2014-07-10')
        to_date = DateTime.parse('2014-07-13')

        expect(reports.days_status(from_date, to_date)).to eq [
          [sale1.agency, '2014-07-10', :complete],
          [sale2.agency, '2014-07-10', :missing],
          [sale1.agency, '2014-07-11', :missing],
          [sale2.agency, '2014-07-11', :complete],
          [sale1.agency, '2014-07-12', :incomplete],
          [sale2.agency, '2014-07-12', :missing],
          [sale1.agency, '2014-07-13', :complete],
          [sale2.agency, '2014-07-13', :complete],
        ]
      end
    end

  end

  describe '#monthly_totals' do
    before do
      2.times do |agency_id|
        Fabricate :complete_sale, agency: "agency_#{agency_id}", date: DateTime.parse('2014-07-10'), commission: 10, to_pay_total: 50
        Fabricate :complete_sale, agency: "agency_#{agency_id}", date: DateTime.parse('2014-07-11'), commission: 10.04, to_pay_total: 50.2
      end
    end

    it 'should calculate the totals per month' do
      expect(reports.monthly_totals).to eq({
        "agency_0" => [{
          "date" => "2014-07",
          "to_pay_total" => 100.2,
          "commission" => 20.04,
        }],
        "agency_1" => [{
          "date" => "2014-07",
          "to_pay_total" => 100.2,
          "commission" => 20.04,
        }],
      })
    end
  end
end
