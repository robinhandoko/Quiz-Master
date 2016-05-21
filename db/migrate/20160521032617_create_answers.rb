class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer       :question_id
      t.string        :answer
      t.boolean       :is_correct, default: false
      t.timestamps null: false
    end

    remove_column :questions, :answer
    add_column :questions, :question_type, :integer
    add_index :answers, :question_id
  end
end
