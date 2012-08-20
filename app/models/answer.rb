class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
  
  default_scope :include => :user
  
  attr_accessible :body
  
  has_reputation :votes, :source => :user, :aggregated_by => :sum
end
