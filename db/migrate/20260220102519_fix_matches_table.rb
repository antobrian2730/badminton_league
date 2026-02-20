class FixMatchesTable < ActiveRecord::Migration[7.0]
  def change
    # Remove the loser column (it's calculated dynamically in the model)
    remove_reference :matches, :loser, foreign_key: { to_table: :players }
    
  end
end