class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.integer :wins
      t.integer :losses

      t.timestamps
    end
  end
end
