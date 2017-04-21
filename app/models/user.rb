class User < ActiveRecord::Base
	before_save { self.email = email.downcase}
	#バリデーションに成功し、実際にオブジェクトが保存される直前で実行されます。INSERTされる場合も、UPDATEされる場合も呼び出されます。

	validates :name,  presence: true,
	                    length: { maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
	                    length: { maximum: 255},
	                    format: { with: VALID_EMAIL_REGEX },
	                 uniqueness: { case_sensitive: false }#大文字小文字を区別しない#Railsにおける一意性のvalidation

	 has_secure_password
	 validates :password, presence: true,
	                        length: { minimum: 6},
	                     allow_nil: true
end
