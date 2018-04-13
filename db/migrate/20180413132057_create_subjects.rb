class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :code

      t.timestamps
    end

    add_index :subjects, :code, unique: true
  end
end
