class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :questions
  has_many :answers
  
  has_many :evaluations, :class_name => "RSEvaluation", :as => :source

  has_reputation :votes, :source => {:reputation => :votes, :of => :answers}, :aggregated_by => :sum

  def voted_for?(answer)
    evaluations.where(target_type: answer.class, target_id: haiku.id).present?
  end
end
