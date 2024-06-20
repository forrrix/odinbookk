class User < ApplicationRecord
include Gravtastic
gravtastic

after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :likes
  has_many :comments

  has_one_attached :photo

  has_many :follow_requests_as_follower, class_name: 'FollowRequest', foreign_key: 'follower_id'
  has_many :follow_requests_as_followee, class_name: 'FollowRequest', foreign_key: 'followee_id'

  has_many :followers, through: :follow_requests_as_followee, source: :follower
  has_many :followees, through: :follow_requests_as_follower, source: :followee



  def following?(other_user)
    follow_requests_as_follower.where(followee: other_user).exists?
  end


  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
