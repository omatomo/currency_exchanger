class CreateProposes < ActiveRecord::Migration
  def change
    create_table :proposes do |t|
      t.string :subject
      t.text :comment
      t.integer :amount
      t.integer :have_currency_id, index: true, null: false
      t.integer :want_currency_id, index: true, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
