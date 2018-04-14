class ProfessorsController < ApplicationController
  def index
    @professors_index = ProfessorsIndexFacade.new(params[:subject_id])
  end
end
