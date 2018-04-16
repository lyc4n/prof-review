class ProfessorsController < ApplicationController
  def index
    @professors_index = ProfessorsIndexFacade.new(current_user,
                                                  params[:subject_id],
                                                  params[:page])

    respond_to do |format|
      format.html
      format.json do
        render :index, locals: {professors_index: @professors_index}
      end
    end
  end
end
