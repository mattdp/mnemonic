class TaggingsController < ActionController::Base

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
  end

  def create #upon submission of intermediate_new
  end

end