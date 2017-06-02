class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :airport
    end
  end
end
