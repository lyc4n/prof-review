class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :description
      t.references :user, foreign_key: true
      t.references :professor, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end

    add_index :reviews, [:user_id, :professor_id, :subject_id], unique: true
  end
end
