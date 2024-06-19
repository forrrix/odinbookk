class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  has_many :likes
  has_many :comments

  has_one_attached :image
end
