class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.text :from
      t.text :to
      t.decimal :buy
      t.decimal :sell

      t.timestamps
    end
  end
end
