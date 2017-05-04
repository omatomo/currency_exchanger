class RequestMatch < ActiveRecord::Base
  belongs_to :propose
  belongs_to :post_user, class_name: "User"
  belongs_to :request_user, class_name: "User"


 def request_user_id?(user)
   request_user_id == user.id
 end
end
