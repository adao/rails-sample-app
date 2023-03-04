class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question, null: false
      t.text :answer, null: false
      t.text :context, null: false
      t.integer :ask_count, null: false, default: 1
      t.string :audio_src_url

      t.timestamps
    end
  end
end
