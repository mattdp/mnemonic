class SurveysController < ApplicationController

  def new
    if @survey.blank? #may be passed in from deeds
      @survey = Survey.create
      @survey.equip_with_questions(["now_how_happy","now_how_alert","now_how_purposeful",
        "yesterday_drinks","yesterday_sleep_attempted","yesterday_sleep_effective","yesterday_eating","yesterday_exercise",
        "yesterday_health","yesterday_orgasm","today_weight","self_reflection"])
    end
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

  def get_sleep_data
    #what can i pass in that data will like? date -> value, i assume?
    @sleep_data = {}
    question = Question.find_by_name("yesterday_sleep_attempted")
    (0..9).reverse_each do |n|
      target_date = Date.today - n.days
      key = (target_date - 1.day).strftime("%a %b %e") #since survey on day X is about day X-1
      @sleep_data[key] = question.answer_on_date(target_date,0)
    end

    respond_to do |format|
      format.json {render json: @sleep_data}
    end
  end

end