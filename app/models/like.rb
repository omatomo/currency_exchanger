class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :propose, counter_cache: :likes_count
end
