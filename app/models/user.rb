class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  
  devise :database_authenticatable, :registerable, :validatable,:omniauthable,  
          :omniauth_providers => [:github] 


  has_many :questions, dependent: :destroy

  has_many :answers
  has_many :answer_likes
  before_save :set_badge
  has_attached_file :avatar, :styles => { :thumb => "100x100>" }, :default_url => "noimage.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def to_s
    email
  end

  def name
    unless self.first_name.empty? && self.last_name.empty?
      "#{self.first_name} #{self.last_name}"
    else
      self.email
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ').at(0)
      user.last_name = auth.info.name.split(' ').at(1)      
      user.avatar = auth.info.image
    end
  end 

  def set_badge
    self.badge = true if self.points >=1000
  end 

end

