class CreateSales < ActiveRecord::Migration
  def self.up
    create_table('sales') do |t|

      t.column :agency, :string
      t.column :date, :date
      t.column :to_pay_subtotal, :float
      t.column :payments_number, :integer
      t.column :payments_amount, :float
      t.column :cancelled_number, :integer
      t.column :cancelled_amount, :float
      t.column :commission, :float
      t.column :to_pay_total, :float

    end

    add_index :sales, [:agency, :date], unique: true
  end

  def self.down
    drop_table('sales')
  end
end
