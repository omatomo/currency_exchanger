class Propose < ActiveRecord::Base
  belongs_to :user
  belongs_to :have_currency, class_name: "Currency"
  belongs_to :want_currency, class_name: "Currency"
  has_many :request_match
  has_many :likes, dependent: :destroy

  validates :comment,          presence: true
  validates :have_currency_id, presence: true
  validates :want_currency_id, presence: true
  validate  :unique_currency
  validate  :amount_validation

  def unique_currency
  	if !have_currency_id.nil? && !want_currency_id.nil? && have_currency_id == want_currency_id
  		errors.add(:have_currency_id, "とwant_currency_idが一緒です。")
  	end
  end

  def amount_validation
  	if amount == nil
  		errors.add(:amount, "が空白です。")
  	elsif amount <= 0
  		errors.add(:amount, "が不正な値です。")
  	end
  end

  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end

end
