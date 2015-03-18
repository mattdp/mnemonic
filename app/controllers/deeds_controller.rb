class DeedsController < ActionController::Base

  def precommit
  end

  #meant for updating as surveys filled out & plan selected
  def create
    @deed = Deed.create

    @deed.before_survey = Survey.create
    @deed.before_survey.equip_with_questions
    @survey = @deed.before_survey #for rendering with survey#new

    @deed.after_survey = Survey.create
    @deed.after_survey.equip_with_questions

    render template: "surveys/new"
  end

end