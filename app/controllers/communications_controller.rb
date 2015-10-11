class CommunicationsController < ApplicationController

  def new
    @people = Person.names_for_search
  end

  def create
  end

end