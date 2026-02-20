class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :player1, null: false, foreign_key: { to_table: :players }
      t.references :player2, null: false, foreign_key: { to_table: :players }
      t.references :winner,  null: false, foreign_key: { to_table: :players }
      t.references :loser,   null: false, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
