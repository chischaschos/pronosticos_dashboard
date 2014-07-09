class CreateGames < ActiveRecord::Migration
  def self.up
    create_table('games') do |t|

      t.belongs_to :sale
      t.column :name, :string, required: true, key: true
      t.column :units, :integer
      t.column :total, :float

    end
  end

  def self.down
    drop_table('games')
  end
end
