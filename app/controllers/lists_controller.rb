class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
  end

  def create
  end

  def destroy
  end

end
