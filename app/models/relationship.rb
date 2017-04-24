class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	#relationsテーブルの{follower}_idのカラムを見て→{follower}クラスを見つけに行くがそんなのないため明示的にUserクラスを指定する
	belongs_to :followed, class_name: "User"
	#Relationship.first.follower => @user
	#Relationshipから見たUser
end
