class CreateJoinTableProfessorSubject < ActiveRecord::Migration[5.1]
  def change
    create_join_table :professors, :subjects do |t|
      t.references :professor, foreign_key: true
      t.references :subject, foreign_key: true
    end
  end
end
