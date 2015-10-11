class CommunicationsController < ApplicationController

  def new
    @people = Person.all
  end

  def create
  end

end