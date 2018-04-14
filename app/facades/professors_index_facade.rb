class ProfessorsIndexFacade
  attr_reader :professors

  def initialize(subject_id)
    @subject    = Subject.find(subject_id)
    @professors = Professor.who_teaches(@subject)
  end

  def subject_code
    @subject.code
  end
end
