class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :image
  has_attached_file :image, styles: { orginal: "",medium: "300x300",thumb: "80x80",mini: "25x25" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  has_many :posts
  has_many :comments
  has_many :likes
end
