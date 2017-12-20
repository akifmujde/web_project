class Post < ApplicationRecord
    attr_accessor :image
    has_attached_file :image, :styles => { :orginal => "", :medium => "500x500>", :thumb => "350x350>" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    
    belongs_to :user
    has_many :comments
    has_many :likes
end
