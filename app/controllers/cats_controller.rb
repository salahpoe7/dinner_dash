class CatsController < ApplicationController
  before_action :set_cat

  def show
  end

  def edit
  end

  private

  def set_cat
    @cat = Cat.find(params[:id])
  end

end
