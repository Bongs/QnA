class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  #default_scope :include => :answers
  
  attr_accessible :title, :body
end
