class DeedsController < ApplicationController

  def precommit
  end

  def index
    @deeds = Deed.all
  end

  #meant for updating as surveys filled out & plan selected
  def create
    @deed = Deed.create

    s = Survey.create
    s.equip_with_questions
    @deed.before_survey_id = s.id
    @survey = @deed.before_survey #for rendering with survey#new

    s = Survey.create
    s.equip_with_questions
    @deed.after_survey_id = s.id

    @deed.save

    render template: "surveys/new"
  end

  def doing
    @deed = Deed.find(params[:deed_id])
    @plan = Plan.find(params[:plan_id])
    @survey = @deed.after_survey

    @deed.plan = @plan
    @deed.save

    render template: "surveys/new"
  end

  def show
    @deed = Deed.find(params[:id])
    @plan = @deed.plan
    @before_survey = @deed.before_survey
    @after_survey = @deed.after_survey

    if (@before_survey.present? and @after_survey.present?)
      diff_in_seconds = @after_survey.answers.map{|a| a.updated_at}.compact.max - @before_survey.created_at
      @minutes_elapsed = (diff_in_seconds/60).round(1) 
      @same_questions = @before_survey.questions & @after_survey.questions 
    end
  end

end