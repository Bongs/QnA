class AnswersController < ApplicationController
  before_filter :authenticate_user! #, :except => [:home]
  
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new
    @answer.user_id = current_user.id.to_i
    @answer.question_id = params[:answer][:question_id].to_i
    @answer.body = params[:answer][:body]

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render json: @answer, status: :created, location: @answer }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @answer = Answer.find(params[:id])
    
    @ans_voted = false
    if @answer.user != current_user
      @answer.add_or_update_evaluation(:votes, value, current_user)
      @vc = @answer.reputation_value_for(:votes).to_i
      @alert = "Thank you for voting"
      @ans_voted = true
    else
      @alert = "Can not vote on own answer"
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: @alert }
      format.js
    end
  end
end
