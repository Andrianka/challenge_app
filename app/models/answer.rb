class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :answer_likes

  validates_presence_of :contents

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  def islike(user)
  	self.answer_likes.each do |answer|
  		if answer.user_id == user.id
  			true
  		else
  			false
  		end
  	end
	end
end
