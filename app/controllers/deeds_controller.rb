class DeedsController < ActionController::Base

  def precommit
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
    @survey = @deed.after_survey

    render template: "surveys/new"
  end

end