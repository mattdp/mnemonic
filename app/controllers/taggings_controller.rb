class TaggingsController < ApplicationController
  
  def new #first new page, choose a verb and a tag
    @verbs = Verb.all
    @tags = Tag.all
  end

  def new_submission #route submit of new to appropriate intermediate_new page
    verb_id = params["Verb"]
    tag_id = params["Tag"]
    redirect_to taggings_intermediate_new_path({verb_id: verb_id,tag_id: tag_id})
  end

  def intermediate_new #second new page, choose person(s) for verb and tag
    @estranged = Person.select_group(:estranged)
    @not_estranged = Person.select_group(:not_estranged)
    @verb = Verb.find(params[:verb_id])
    @tag = Tag.find(params[:tag_id])
  end

  def create #upon submission of intermediate_new
    people_ids = params[:Person]
    people_ids.each do |person_id|
      Tagging.create_without_duplicates(person_id, params[:verb_id], params[:tag_id])
    end

    redirect_to new_tagging_path
  end

end