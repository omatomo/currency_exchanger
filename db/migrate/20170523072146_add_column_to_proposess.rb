class AddColumnToProposess < ActiveRecord::Migration
  def change
    add_reference :proposes, :airport, index: true, foreign_key: true
  end
end
