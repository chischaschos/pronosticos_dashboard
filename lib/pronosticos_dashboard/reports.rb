module PronosticosDashboard
  class Reports
    def self.days_status(from_date, to_date)
      DaysStatus.new(from_date, to_date).report
    end

    def self.monthly_totals
      MonthlyTotals.new.report
    end

    class DaysStatus
      def initialize(from_date, to_date)
        @dates_range = (from_date..to_date)
        @sales = Sale.with_games_counts(date: @dates_range)
        @agencies = Sale.distinct.pluck(:agency)
      end

      def report
        @dates_range.reduce([]) do |days_with_status, date|
          days_with_status.concat(status_per_agency(date))
          days_with_status
        end
      end

      def status_per_day(sales = nil, agency = nil)
        if sales && agency_sale = sales.find {|sale| sale.agency == agency }
          agency_sale.complete? ? :complete : :incomplete
        else
          :missing
        end
      end

      def status_per_agency(date)
        sales = @sales.find_all {|search_date| search_date.date == date}

        if @agencies.empty?
          [[nil, date.strftime('%Y-%m-%d'), status_per_day]]
        else
          @agencies.map do |agency|
            [agency.to_i, date.strftime('%Y-%m-%d'), status_per_day(sales, agency)]
          end
        end

      end
    end

    class MonthlyTotals
      def report
        Sale.monthly_totals.reduce({}) do |reduced, row|
            reduced[row.dd] = {
              "to_pay_total" => row.tpt,
              "commission" => row.c
            }
            reduced
          end
      end
    end
  end
end
