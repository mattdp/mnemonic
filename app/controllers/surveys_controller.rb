class SurveysController < ApplicationController

  def new
    if @survey.blank? #may be passed in from deeds
      @survey = Survey.create
      @survey.equip_with_questions(["now_how_happy","now_how_alert","now_how_purposeful",
        "yesterday_drinks","yesterday_sleep","yesterday_eating","yesterday_exercise",
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
    (1..10).reverse_each do |n|
      key = (Date.today - n.days).strftime("%a %b %e")
      #for each of those days, is there sleep # or 0?
      #might make sense to have a lookup for a date and question, handling 2 surveys on a day
      val = 400
      @sleep_data[key] = val
    end

    respond_to do |format|
      format.json {render json: @sleep_data}
    end
  end

end