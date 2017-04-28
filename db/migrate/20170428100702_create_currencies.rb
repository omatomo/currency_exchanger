class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :currency
      t.string :image
    end
  end
end
