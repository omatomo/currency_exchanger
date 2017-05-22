class Room < ActiveRecord::Base
  belongs_to :propose
  belongs_to :postman, class_name: "User"
  belongs_to :requestman, class_name: "User"
  has_many :messages, dependent: :destroy
end
