class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :answer_likes,  dependent: :destroy

  validates_presence_of :contents

  def islike(user, p=false)
    self.answer_likes.each do |a|
      if a.user_id == user.id
        p = true
      end
    end
    return p
  end

  def set_like
    unless self.answer_likes.count == 0 || self.answer_likes.count == 1
      "likes"
    else
      "like"
    end
  end
end
