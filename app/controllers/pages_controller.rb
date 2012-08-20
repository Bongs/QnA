class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]
  
  def home
    @questions = Question.order("created_at DESC").page(params[:page]).per(10)
    
    @latest_answered_qid = Answer.select("DISTINCT(question_id)").last(5).reverse
    #@latest_answered_q = Question.find(:all, :conditions => "id in (#{@latest_answered_qid})")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end
  
  def questions
    @questions = Question.order("created_at DESC").includes(:user).where(:user_id => current_user.id).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end
end
