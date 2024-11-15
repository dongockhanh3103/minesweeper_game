class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :email, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :number_of_mines, null: false
      t.string :status
      t.string :board
      t.string :revealed
      t.string :name, default: ''

      t.timestamps
    end
  end
end
