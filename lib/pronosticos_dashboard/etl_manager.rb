module PronosticosDashboard
  class ETLManager

    attr_accessor :cells

    def self.perform
      etl_manager = new
      etl_manager.extract
      etl_manager.transform
    end

    def extract
      unless @cells
        require "google_drive"
        session = GoogleDrive.login(ENV['GOOGLE_DRIVE_EMAIL'], ENV['GOOGLE_DRIVE_PASSWORD'])
        spreadsheet = session.spreadsheet_by_title(ENV['GOOGLE_SPREADSHEET'])
        worksheet = spreadsheet.worksheets[0]
        @cells = worksheet.cells
      end
    end

    def transform
      PronosticosDashboard::DB.setup

      total_rows = @cells.keys.last[0]

      (2..total_rows).each do |row|
        agency = @cells[[row, 1]]
        date = @cells[[row, 2]]

        sale = Sale.find_or_create_by(agency: agency, date: date)

        nonExpectedChars = /[\$,]/
        sale.to_pay_subtotal =  (@cells[[row, 27]] || '').gsub(nonExpectedChars, '').to_f
        sale.payments_number =  (@cells[[row, 28]] || '').to_i
        sale.payments_amount =  (@cells[[row, 29]] || '').gsub(nonExpectedChars, '').to_f
        sale.commission =  (@cells[[row, 30]] || '').gsub(nonExpectedChars, '').to_f
        sale.to_pay_total =  (@cells[[row, 31]] || '').gsub(nonExpectedChars, '').to_f
        sale.cancelled_number = (@cells[[row, 32]] || '').to_i
        sale.cancelled_amount = (@cells[[row, 33]] || '').gsub(nonExpectedChars, '').to_f

        if sale.save
          (3..26).each_slice(2) do |game_pair|
            total =  @cells[[row, game_pair.last]] || ''
            total.gsub!(nonExpectedChars, '')
            game = sale.games.find_or_create_by(name: @cells[[1, game_pair.first]])
            game.units = @cells[[row, game_pair.first]].to_i
            game.total = total.to_f
            game.save
          end
        end

      end
    end

  end
end
