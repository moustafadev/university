class CreateMicroposts < ActiveRecord::Migration[7.1]
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :id
      t.integer :user_id

      t.timestamps
    end
  end
end
