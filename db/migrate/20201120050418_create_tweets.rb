class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content
      t.belongs_to :user

      t.timestamps
    end
  end
end
