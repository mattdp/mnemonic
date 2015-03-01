class SurveysController < ActionController::Base

  def new
    @survey = Survey.create
    @survey.equip_with_questions
  end

  def create
  end

  def show
    @survey = Survey.find(params[:id])
  end

end