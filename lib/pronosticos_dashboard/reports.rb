module PronosticosDashboard
  class Reports
    def self.days_status(from_date, to_date)
      DaysStatus.new(from_date, to_date).report
    end

    class DaysStatus
      def initialize(from_date, to_date)
        @dates_range = (from_date..to_date)
        @sales = Sale.where(date: @dates_range)
        @agencies = Sale.distinct.pluck(:agency)
      end

      def report
        @dates_range.reduce([]) do |days_with_status, date|
          days_with_status.concat(status_per_agency(date))
          days_with_status
        end
      end

      def status_per_day(sale, agency)
        if sale && sale.agency == agency
          sale.complete? ? :complete : :incomplete
        else
          :missing
        end
      end

      def status_per_agency(date)
        sale = @sales.find {|search_date| search_date.date == date}

        if @agencies.empty?
          [[nil, date.strftime('%Y-%m-%d'), status_per_day(sale, nil)]]
        else
          @agencies.map do |agency|
            [agency.to_i, date.strftime('%Y-%m-%d'), status_per_day(sale, agency)]
          end
        end

      end
    end

  end
end
