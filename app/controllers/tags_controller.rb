class TagsController < ActionController::Base

  def index
    @tags = Tag.all
  end

  def show
    nfl = params[:name_for_link]
    @tag = Tag.find_by_name_for_link(nfl)
    @people = @tag.tagged_people
  end

end