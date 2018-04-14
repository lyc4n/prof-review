class ProfessorsIndexFacade
  attr_reader :professors

  delegate :total_entries, :per_page, :total_pages, :current_page, to: :@professors

  def initialize(subject_id, page)
    @subject    = Subject.find(subject_id)
    @professors = @subject.professors.paginate(page: page)
  end

  def subject_code
    @subject.code
  end
end
