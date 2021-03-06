class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and : omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable

  validates_presence_of     :uid # optional
  validates_presence_of     :email # optional
  validates_presence_of     :first_name # optional
  validates_presence_of     :last_name # optional
  validates_presence_of     :password, on: :create
  validates_presence_of     :last_name # optional
  #validates_presence_of     :avatar # optional

  validates :uid, uniqueness: true
  validates :email, uniqueness: true, format: /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/

  validates :password, :length => {:within => 6..40}, confirmation: true, on: :create
  validates_confirmation_of :password, on: :create

  
  



  has_one_attached :avatar
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def active_for_authentication? 
    super && approved? 
  end 
  
  def inactive_message 
    approved? ? super : :not_approved
  end



  









end
