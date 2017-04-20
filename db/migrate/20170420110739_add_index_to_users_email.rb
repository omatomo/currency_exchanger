class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true#データベース側に一意性を保つようにお願いする。
  end
end
