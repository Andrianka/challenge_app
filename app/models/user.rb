class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable

  has_many :questions
  has_many :answers
  has_many :answer_likes

  has_attached_file :avatar, :styles => { :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path("noimage.jpg");
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def to_s
    email
  end

  def name
    unless self.first_name.nil? && self.last_name.nil?
      "#{self.first_name} #{self.last_name}"
    else
      email
    end
  end

end
