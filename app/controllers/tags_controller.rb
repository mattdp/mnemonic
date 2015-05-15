class TagsController < ApplicationController

  def index
    @tags = Tag.all_sorted
  end

  def show
    nfl = params[:name_for_link]
    @tag = Tag.find_by_name_for_link(nfl)
    if @tag
      @taggings = @tag.taggings
      @email_list = Person.email_list(@taggings.map{|tagging| tagging.person})
    end
  end

end