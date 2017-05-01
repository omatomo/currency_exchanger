class CreateRequestMatches < ActiveRecord::Migration
  def change
    create_table :request_matches do |t|
      t.integer :post_user_id
      t.integer :request_user_id
      t.references :propose, index: true, foreign_key: true
      t.boolean :negotiated, default: false

      t.timestamps null: false
    end
    add_index :request_matches, :post_user_id
    add_index :request_matches, :request_user_id
  end
end
