class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :title, null: false, limit: 255
      t.text :body, null: false, limit: 65535
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
