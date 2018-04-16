class SubjectsController < ApplicationController

  def index
    @subjects = SubjectsIndexFacade.new(params[:page], params[:q])
  end
end
