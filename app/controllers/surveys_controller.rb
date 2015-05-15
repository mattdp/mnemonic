class SurveysController < ApplicationController

  def new
    @survey = Survey.create
    @survey.equip_with_questions
  end

  def create
    @survey = Survey.find(params[:id])
    params[:questions].each do |question_name,answer_value|
      next if answer_value.nil?
      question = Question.find_by_name(question_name)
      answer = Answer.where("question_id = ? AND survey_id = ?",question.id,@survey.id)[0]
      if question.answer_type == "text"
        answer.content_text = answer_value
      else
        answer.content_integer = answer_value.to_i
      end
      answer.save
    end

    redirect_to survey_path(@survey.id)
  end

  def show
    @survey = Survey.find(params[:id])

    @survey_purpose, @deed_id = @survey.purpose
  end

end