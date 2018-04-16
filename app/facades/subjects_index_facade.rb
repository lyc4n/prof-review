class SubjectsIndexFacade
  attr_reader :q
  delegate :any?, to: :@subjects

  def initialize(page, q)
    @q = Subject.ransack(q)
    @subjects = @q.result.paginate(page: page)
  end

  def all
    @subjects
  end
end
