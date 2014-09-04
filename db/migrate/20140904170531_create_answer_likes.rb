class CreateAnswerLikes < ActiveRecord::Migration
  def change
    create_table :answer_likes do |t|
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
