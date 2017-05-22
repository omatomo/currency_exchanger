class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token, :reset_token#カラムにアクセスするために必要なメソッドを定義する。カラムはないがメソッドとして一時的に保存できる. ゲッターとセッターを一度にできる。
	before_save :downcase_email
	before_create :create_activation_digest
	#バリデーションに成功し、実際にオブジェクトが保存される直前で実行されます。INSERTされる場合も、UPDATEされる場合も呼び出されます。

 #has_many :tweets(user.tweetsでtweetテーブルのuser_idカラムがそのuserのものを全て取ってくる。)
	has_many :activerelationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :following, through: :activerelationships, source: :followed

	has_many :passiverelationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followers, through: :passiverelationships, source: :follower


  has_many :post_creates,    class_name: "RequestMatch", foreign_key: "post_user_id", dependent: :destroy
  has_many :requesters, through: :post_creates, source: :request_user

  has_many :request_creates, class_name: "RequestMatch", foreign_key: "request_user_id"
  has_many :posters, through: :request_creates, source: :post_user

  has_many :postman_rooms, class_name: "Room", foreign_key: "postman_id", dependent: :destroy
  has_many :requestmans, through: :postman_rooms, source: :requestman

  has_many :requestman_rooms, class_name: "Room", foreign_key: "requestman_id", dependent: :destroy
  has_many :postmans, through: :requestman_rooms, source: :postman

  mount_uploader :image, ImageUploader



	has_many :proposes, dependent: :destroy
  has_many :likes

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

	 def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
  	update_attribute(:remember_digest, nil)
  end

  # def authenticated?(remember_token)
  # 	return false if remember_digest.nil?
  # 	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  def authenticated?(attribute, token)
  	digest = send("#{attribute}_digest")
  	return false if digest.nil?
  	BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
  	update_attribute(:activated, true)
    update_attribute(:activated_at, true)
  end

  def send_activation_email
  	UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
  	self.reset_token = User.new_token
  	update_attribute(:reset_digest, User.digest(reset_token))
  	update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
  	UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def follow(other_user)
  	self.activerelationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
  	self.activerelationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
  	self.following.include?(other_user)
  end

  private

  def downcase_email
  	self.email = email.downcase
  end

  def create_activation_digest
  	self.activation_token = User.new_token
  	self.activation_digest = User.digest(activation_token)
  end

end
