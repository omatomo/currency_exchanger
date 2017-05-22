class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :content, presence: true,  length: { maximum: 249}
end
